import threading
import time
import queue
import edge_tts
import sounddevice as sd
import numpy as np
import miniaudio

from supermemo_toolkit.autotts.threader import ThreadController
from supermemo_toolkit.utilscripts.config import RATE, VOICE, VOLUME, get_config


class AudioSwitcher:
    def __init__(self):
        self.__current_stream = None
        self.__lock = threading.Lock()
        self.__thread_manager = ThreadController()
        self.__player_id = None
        self.__producer_id = None

        # 声音配置
        self.__voice = get_config().get(VOICE) or "en-US-BrianMultilingualNeural"
        self.__rate = get_config().get(RATE) or "+0%"
        self.__volume = get_config().get(VOLUME) or "+0%"

        # 缓冲配置
        self.__block_size = 1024
        self.__timeout = 8

        # 音频参数（延迟初始化）
        self.__audio_params = threading.Event()
        self.__audio_sample_rate = None
        self.__audio_channels = None
        self.__audio_queue = None
        self.replace_list: dict = {}

    def _stream_decoded_sentences_with_rate(self, text):
        communicate = edge_tts.Communicate(
            text=text, voice=self.__voice, volume=self.__volume, rate=self.__rate
        )
        sentence_buffer = bytearray()

        for chunk in communicate.stream_sync():
            chunk_type = chunk["type"]
            if chunk_type == "audio":
                sentence_buffer.extend(chunk["data"])
            elif chunk_type == "SentenceBoundary":
                if len(sentence_buffer) > 0:
                    audio = miniaudio.decode(
                        bytes(sentence_buffer),
                        output_format=miniaudio.SampleFormat.SIGNED16,
                    )
                    samples = np.frombuffer(audio.samples, dtype=np.int16)
                    yield (samples, audio.sample_rate, audio.nchannels)
                    sentence_buffer.clear()

        if len(sentence_buffer) > 0:
            audio = miniaudio.decode(
                bytes(sentence_buffer), output_format=miniaudio.SampleFormat.SIGNED16
            )
            samples = np.frombuffer(audio.samples, dtype=np.int16)
            yield (samples, audio.sample_rate, audio.nchannels)

    def __producer(self, stop_event: threading.Event, *param):
        """生产者线程：解码TTS流并分块"""
        try:
            # 终止情况一：开始时就结束
            if stop_event.is_set():
                return
            # 生成器阻塞：如果TTS生成器本身在等待数据（比如网络请求或文件读取），
            # 即使设置了stop_event，也要等到生成器产生下一个数据时才能检查到。
            for audio_sentence in self._stream_decoded_sentences_with_rate(param[0]):
                samples, sample_rate, nchannels = audio_sentence

                # 终止情况二：执行过程中结束
                if stop_event.is_set():
                    self.__clear_audio_queue()
                    return

                # 首次设置采样率、声道数量、初始化音频队列
                if not self.__audio_params.is_set():
                    self.__audio_sample_rate = sample_rate
                    self.__audio_channels = nchannels
                    # 根据真实采样率计算队列大小
                    max_blocks = int(
                        self.__audio_sample_rate
                        * self.__audio_channels
                        / self.__block_size
                    )
                    self.__audio_queue = queue.Queue(maxsize=max_blocks)
                    self.__audio_params.set()
                    print(
                        f"[Producer] Audio: {self.__audio_sample_rate}Hz, {self.__audio_channels}ch, Queue: {max_blocks} blocks"
                    )

                # 分块入队
                target_length = self.__block_size * self.__audio_channels
                while len(samples) >= target_length:
                    block = samples[:target_length]
                    samples = samples[target_length:]
                    # 阻塞式放入，确保不丢数据
                    # 终止情况三：执行过程到这的时候结束
                    while not stop_event.is_set():
                        try:
                            if self.__audio_queue is None:
                                break
                            self.__audio_queue.put(block, timeout=0.5)
                            break
                        except queue.Full:
                            # [阻塞守卫] 添加stop_event检查
                            if stop_event.is_set():
                                self.__clear_audio_queue()
                                return
                            time.sleep(0.05)  # 队列满时短暂让步
                    # 在分块入队中结束
                    if stop_event.is_set():
                        self.__clear_audio_queue()
                        return
                # 处理剩余数据（最后一块）
                # 终止情况四：执行过程到快结束时候结束
                if (
                    len(samples) > 0
                    and len(samples) < target_length
                    and not stop_event.is_set()
                ):
                    # 补齐 0 到完整块
                    padding = target_length - len(samples)
                    samples = np.pad(samples, (0, padding), mode="constant")
                    # [阻塞守卫] 添加超时机制和stop_event检查
                    while not stop_event.is_set():
                        try:
                            if self.__audio_queue is None:
                                break
                            self.__audio_queue.put(samples, timeout=0.1)
                            break
                        except queue.Full:
                            time.sleep(0.05)
            if not stop_event.is_set() and self.__audio_queue is not None:
                self.__audio_queue.put(None)

        except Exception as e:
            print(f"[Producer] Error: {e}")
        finally:
            # 如果按下停止按钮就应该停止。
            print("[Producer] Finished")

    def __pre_blocks(self):
        # 预缓冲：确保有足够数据再播放（关键！）
        prebuffer_seconds = 0.3
        pre_blocks = int(
            prebuffer_seconds * self.__audio_sample_rate / self.__block_size
        )
        # 等待生产者生成足够预缓冲数据队列
        while True:
            is_enough = self.__audio_queue.qsize() > pre_blocks
            is_alive = self.__thread_manager.is_alive(self.__producer_id)

            if is_enough:
                break
            if not is_alive:
                if self.__audio_queue.qsize() == 0:
                    raise RuntimeError(
                        "TTS Producer died unexpectedly (no audio data)."
                    )
                break
            time.sleep(0.005)

        print(f"[Player] Buffered {pre_blocks}/{self.__audio_queue.qsize()} blocks")

    def __play(self, stop_event: threading.Event, *param):
        """播放线程"""
        # 等待参数就绪
        # self.__audio_params设置后意味着__audio_queue已初始化。
        # 这儿已经请求好了一个chunk，也算是缓冲了一个chunk。
        # 其实这个chunk缓存的秒数已经比我设定的秒要大很多。
        if not self.__audio_params.wait(timeout=self.__timeout):
            print("[Player] Timeout")
            self.stop()
            return

        # 回调函数：禁止任何阻塞操作！
        def callback(outdata: np.ndarray, frames: int, time_info, status):
            # 这个对于暂停流程其实没有用，因为几乎是瞬间交替。
            # 他的作用主要是清理余音。
            if stop_event.is_set():
                outdata.fill(0)
                raise sd.CallbackStop

            samples_needed = frames * self.__audio_channels

            try:
                if self.__audio_queue is None:
                    outdata.fill(0)
                    raise sd.CallbackStop

                block = self.__audio_queue.get_nowait()

                # 收到结束标志，停止回调并通知player停止等待
                if block is None:
                    self.__audio_queue = None
                    outdata.fill(0)
                    raise sd.CallbackStop

                # 严格检查长度
                if len(block) == samples_needed:
                    outdata[:] = block.reshape(frames, self.__audio_channels)
                else:
                    outdata.fill(0)
                    # 数据长度异常，打印调试信息
                    print(
                        f"[Callback] Block size mismatch: {len(block)} != {samples_needed}"
                    )

            except queue.Empty:
                # 欠载：填充静音（比停止播放更平滑）
                outdata.fill(0)

        # 创建输出流
        stream = sd.OutputStream(
            samplerate=self.__audio_sample_rate,
            channels=self.__audio_channels,
            dtype="int16",
            callback=callback,
            blocksize=self.__block_size,
            latency="high",  # 高延迟模式更稳定
        )

        with self.__lock:
            self.__current_stream = stream

        # 播放，with会自动打开关闭
        with self.__current_stream:
            # 继续播放直到缓冲区为None，缓冲区为empty()不代表全部播放完成。
            # 判断播放完成的条件，就是生产者完成生产，回调函数收到End消息
            while not stop_event.is_set():
                if self.__audio_queue is not None:
                    time.sleep(0.05)
                else:
                    break

        with self.__lock:
            self.__current_stream = None
        print("[Player] Finished")

    def __clear_audio_queue(self):
        if self.__audio_queue and not self.__audio_queue.empty():
            while True:
                try:
                    self.__audio_queue.get_nowait()
                except queue.Empty:
                    break

    def play(self, text: str):
        # 重置状态
        self.__audio_queue = None
        self.__current_stream = None
        self.__audio_params.clear()

        # 停止播放
        self.stop()

        # 自定义
        if len(self.replace_list) > 0:
            for k, v in self.replace_list.items():
                text = text.replace(k, v)

        # 启动进程
        self.__producer_id = self.__thread_manager.thread(self.__producer, text)
        self.__player_id = self.__thread_manager.thread(self.__play)

    def stop(self):
        """停止播放并等待线程完全结束"""
        with self.__lock:
            if self.__current_stream:
                # 终止__producer会卡 -> thread.join() -> __producer进程卡 -> 发个信号让进程停止，然后直接丢掉这个进程
                self.__thread_manager.stop(self.__producer_id)
                self.__thread_manager.stop(self.__player_id)


# ------------------ 测试代码 ------------------
if __name__ == "__main__":
    text = """君不见，黄河之水天上来，奔流到海不复回。
            君不见，高堂明镜悲白发，朝如青丝暮成雪。
            人生得意须尽欢，莫使金樽空对月。
            天生我材必有用，千金散尽还复来。
            烹羊宰牛且为乐，会须一饮三百杯。
            岑夫子，丹丘生，将进酒，杯莫停。
            与君歌一曲，请君为我倾耳听。
            钟鼓馔玉不足贵，但愿长醉不复醒。
            古来圣贤皆寂寞，惟有饮者留其名。
            陈王昔时宴平乐，斗酒十千恣欢谑。
            主人何为言少钱，径须沽取对君酌。
            五花马，千金裘，呼儿将出换美酒，与尔同销万古愁。"""
    # text = "床前明月光，疑是地上霜。举头望明月，低头思故乡。"
    # switcher = AudioSwitcher()
    # switcher.play(text)
    # time.sleep(3)
    # switcher.stop()

    # 方式一测试
    # print(f"Text: {text}")
    # print("Starting TTS stream...")
    # switcher = AudioSwitcher()
    # switcher.play(text)
    # try:
    #     while switcher._AudioSwitcher__player_thread.is_alive():
    #         time.sleep(0.5)
    # except KeyboardInterrupt:
    #     print("\nStopping...")
    #     switcher.stop()
    # print("Done!")

    # 方式二测试
    # switcher = AudioSwitcher()
    # sentence_samples = np.array([], dtype=np.int16)
    # sample_rate = 0
    # for (
    #     samples,
    #     sample_rate,
    #     nchannels,
    # ) in switcher._stream_decoded_sentences_with_rate(text, "zh-CN-XiaoxiaoNeural"):
    #     sample_rate = sample_rate
    #     sentence_samples = np.concatenate((sentence_samples, samples), axis=0)
    # if nchannels == 2:
    #     sentence_samples = sentence_samples.reshape(-1, 2)
    # sd.play(sentence_samples, samplerate=sample_rate)
    # sd.wait()  # 等待当前句子播放完毕，再处理下一个

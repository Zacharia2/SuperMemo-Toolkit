import threading
import time
import queue
import edge_tts
import sounddevice as sd
import numpy as np
import miniaudio


class AudioSwitcher:
    def __init__(self):
        self.__current_stream = None
        self.__lock = threading.Lock()
        self.__stop_flag = threading.Event()
        self.__player_thread = None
        self.__producer_thread = None

        # 缓冲配置
        self.__block_size = 1024
        self.__prebuffer_seconds = 0.5
        self.__timeout = 8

        # 音频参数（延迟初始化）
        self.__audio_params = threading.Event()
        self.__audio_sample_rate = None
        self.__audio_channels = None
        self.__audio_queue = None

    def _stream_decoded_sentences_with_rate(self, text, voice):
        communicate = edge_tts.Communicate(text, voice)
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

    def __producer(self, text):
        """生产者线程：解码TTS流并分块"""
        try:
            voice = "zh-CN-XiaoxiaoNeural"
            for audio_sentence in self._stream_decoded_sentences_with_rate(text, voice):
                samples, sample_rate, nchannels = audio_sentence

                if self.__stop_flag.is_set():
                    break

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
                    while not self.__stop_flag.is_set():
                        try:
                            self.__audio_queue.put(block, timeout=0.1)
                            break
                        except queue.Full:
                            time.sleep(0.05)  # 队列满时短暂让步

                # 处理剩余数据（最后一块）
                if (
                    len(samples) > 0
                    and len(samples) < target_length
                    and not self.__stop_flag.is_set()
                ):
                    # 补齐 0 到完整块
                    padding = target_length - len(samples)
                    samples = np.pad(samples, (0, padding), mode="constant")
                    self.__audio_queue.put(samples)

        except Exception as e:
            print(f"[Producer] Error: {e}")
        finally:
            # 如果按下停止按钮就应该停止。
            print("[Producer] Finished")

    def __play(self, text):
        """播放线程"""
        # 等待参数就绪和缓冲创建
        # self.__audio_params设置后意味着__audio_queue已经准备好了。
        if not self.__audio_params.wait(timeout=self.__timeout):
            print("[Player] Timeout")
            self.__stop_flag.set()
            return

        # 预缓冲：确保有足够数据再播放（关键！）
        pre_blocks = int(
            self.__prebuffer_seconds * self.__audio_sample_rate / self.__block_size
        )
        # 等待生产者生成足够预缓冲数据队列
        while (
            self.__audio_queue.qsize() < pre_blocks
            and self.__producer_thread.is_alive()
        ):
            time.sleep(0.02)

        print(
            f"[Player] Buffered {pre_blocks}/{self.__audio_queue.qsize()} blocks, starting playback"
        )

        # 回调函数：禁止任何阻塞操作！
        def callback(outdata: np.ndarray, frames: int, time_info, status):
            # 这个对于暂停流程其实没有用，因为几乎是瞬间交替。
            # 他的作用主要是清理余音。
            if self.__stop_flag.is_set():
                outdata.fill(0)
                raise sd.CallbackStop

            samples_needed = frames * self.__audio_channels

            try:
                if self.__audio_queue is None:
                    outdata.fill(0)
                    raise sd.CallbackStop

                block = self.__audio_queue.get_nowait()

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
            self.__producer_thread.join()  # 等待生产完毕
            # 继续播放直到缓冲区清空
            while not self.__stop_flag.is_set():
                if self.__audio_queue is not None:
                    time.sleep(0.05)

        self.__current_stream = None
        print("[Player] Finished")

    def play(self, text):
        # 重置状态
        self.__audio_queue = None
        self.__stop_flag.clear()
        self.__audio_params.clear()

        # 总之播放前要把两个线程先终止在播放

        # 启动生产者（唯一的数据消费点）
        self.__producer_thread = threading.Thread(
            target=self.__producer, args=(text,), daemon=True
        )
        self.__producer_thread.start()

        # 启动消费者线程
        self.__player_thread = threading.Thread(
            target=self.__play, args=(text,), daemon=True
        )
        self.__player_thread.start()

    def stop(self):
        """停止播放并等待线程完全结束"""
        with self.__lock:
            if self.__current_stream:
                self.__stop_flag.set()

                # 清空队列以解除生产者阻塞
                if not self.__audio_queue.empty():
                    while True:
                        try:
                            self.__audio_queue.get_nowait()
                        except queue.Empty:
                            break

                # 等待线程结束（关键！）
                if self.__producer_thread and self.__producer_thread.is_alive():
                    self.__producer_thread.join()
                if self.__player_thread and self.__player_thread.is_alive():
                    self.__player_thread.join()

                # 现在安全地清理资源
                self.__audio_queue = None
                self.__current_stream = None


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

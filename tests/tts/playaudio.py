from os import path
import time
import audioread
import edge_tts
from supermemo_toolkit.utilscripts.config import get_config_dir
import sounddevice as sd
import numpy as np
import threading

TEXT = """君不见，黄河之水天上来，奔流到海不复回。
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


audio_tts = path.join(get_config_dir(), "audio_tts.mp3")

communicate = edge_tts.Communicate(TEXT, "zh-CN-XiaoxiaoNeural")
communicate.save_sync(audio_tts)


class AudioSwitcher:
    def __init__(self):
        self.__current_stream = None
        self.__lock = threading.Lock()
        self.__stop_flag = False
        self.__player_thread = None
        self.time_left = 0.0

    def __play(self, filename):
        with audioread.audio_open(filename) as f:
            file_iterator = iter(f)
            self.time_left = f.duration
            audio_channels = f.channels
            buffer = np.array([], dtype="int16")
            file_finished = False

            def callback(outdata: np.ndarray, frames: int, time_info, status):
                nonlocal buffer, file_finished

                if self.__stop_flag:
                    outdata.fill(0)
                    raise sd.CallbackStop

                # 计算需要的样本总数（帧数 × 声道数）
                samples_needed = frames * audio_channels

                # 适配frames 1136 init16，buf 4069 bytes 2048 int16
                while len(buffer) < samples_needed and not file_finished:
                    try:
                        buf = next(file_iterator)
                        buffer = np.append(buffer, np.frombuffer(buf, dtype="int16"))
                    except StopIteration:
                        file_finished = True
                # End of data
                if len(buffer) == 0:
                    outdata.fill(0)
                    raise sd.CallbackStop

                # Normal playback
                if len(buffer) >= samples_needed:
                    outdata[:] = buffer[:samples_needed].reshape(frames, audio_channels)
                    buffer = buffer[samples_needed:]
                else:  # 0 < remaining < samples_needed
                    remaining = len(buffer)
                    # 全部放进去就完事。
                    outdata[:remaining] = buffer.reshape(remaining, 1)
                    outdata[remaining:] = 0
                    buffer = np.array([], dtype="int16")
                    raise sd.CallbackStop

            stream = sd.OutputStream(
                samplerate=f.samplerate,
                channels=f.channels,
                dtype="int16",
                callback=callback,
            )

            with self.__lock:
                self.__current_stream = stream
                self.__stop_flag = False

            stream.start()
            while stream.active and not self.__stop_flag:
                time.sleep(0.05)

            stream.close()

    def play(self, filename):
        # Stop previous audio
        with self.__lock:
            if self.__current_stream:
                self.__stop_flag = True
                time.sleep(0.1)

        # Start new audio
        self.__player_thread = threading.Thread(
            target=self.__play, args=(filename,), daemon=True
        )
        self.__player_thread.start()

    def stop(self):
        with self.__lock:
            if self.__current_stream:
                self.__stop_flag = True
                time.sleep(0.1)
                self.__current_stream = None


# Example usage:
# 需要主线程保持活动状态。
# switcher = AudioSwitcher()
# switcher.play(audio_tts)
# switcher.play("C:/Users/Snowy/Downloads/sample-6s.wav")
# time.sleep(switcher.time_left)
# switcher.play("C:/Users/Snowy/Downloads/WAV 音频示例文件.wav")
# time.sleep(switcher.time_left)
# switcher.stop()

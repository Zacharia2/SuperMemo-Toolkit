import threading
import time
import edge_tts
import sounddevice as sd
import numpy as np
from typing import Generator
from edge_tts.typing import TTSChunk
import miniaudio


class AudioSwitcher:
    def __init__(self):
        self.__current_stream = None
        self.__lock = threading.Lock()
        self.__stop_flag = False
        self.__player_thread = None

    def __play(self, stream_tts: Generator[TTSChunk, None, None]):
        frame_iterator = iter(stream_tts)
        while True:
            chunk = next(frame_iterator)
            if chunk["type"] != "audio":
                continue
            audio = miniaudio.decode(chunk["data"])
            break

        audio_channels = audio.nchannels
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
                    chunk = next(frame_iterator)
                    if chunk["type"] != "audio":
                        continue
                    audio = miniaudio.decode(chunk["data"])
                    buffer = np.append(
                        buffer, np.frombuffer(audio.samples, dtype="int16")
                    )
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
            samplerate=audio.sample_rate,
            channels=audio.nchannels,
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


TEST_MP3_FILE = "D:/SuperMemo/AdvEng/AdvEng 2018/elements/1/16/7/11/416219.mp3"  # <--- !! 请修改为你的 MP3 文件路径 !!

# 1. 准备文本和语音
text = "床前明月光，疑是地上霜。举头望明月，低头思故乡。"
voice = "zh-CN-XiaoxiaoNeural"
communicate = edge_tts.Communicate(text, voice)

# 2. 同步获取所有音频数据块
switcher = AudioSwitcher()
switcher.play(communicate.stream_sync())
# frame_iterator = iter(communicate.stream_sync())
# while True:
#     chunk = next(frame_iterator)
#     if chunk["type"] == "audio":
#         audio = miniaudio.decode(chunk["data"])
#     else:
#         continue

# pass
time.sleep(10)

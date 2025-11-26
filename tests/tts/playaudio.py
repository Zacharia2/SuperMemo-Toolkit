from os import path
import time
import audioread
import edge_tts
from supermemo_toolkit.utilscripts.config import get_config_dir
import sounddevice as sd
import numpy as np


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

# --- 全局变量 ---
file_iterator = None
buffer = None
audio_channels = None
file_finished = False
# ------------------


def callback(outdata: np.ndarray, frames: int, time_info, status):
    global buffer, file_iterator, file_finished

    # 只要缓冲区不够，并且文件还没读完，就继续读
    while len(buffer) < frames and not file_finished:
        try:
            buf = next(file_iterator)
            buffer = np.concatenate((buffer, np.frombuffer(buf, dtype="int16")))
        except StopIteration:
            file_finished = True

    # --- 关键修正：处理播放的最后阶段 ---
    if len(buffer) == 0:
        # 缓冲区空了，并且文件也读完了，可以安全停止
        outdata.fill(0)  # 填充静音
        raise sd.CallbackStop

    elif len(buffer) >= frames:
        # 缓冲区数据充足，正常播放
        outdata[:] = buffer[:frames].reshape(frames, audio_channels)
        buffer = buffer[frames:]

    else:  # 0 < len(buffer) < frames
        # 这是最后一块数据，不够一次回调的量
        # 1. 把所有剩余数据写入 outdata
        remaining_samples = len(buffer)
        outdata[:remaining_samples] = buffer.reshape(remaining_samples, audio_channels)
        # 2. 用静音填充 outdata 剩下的部分
        outdata[remaining_samples:] = 0
        # 3. 清空缓冲区并停止流
        buffer = np.array([], dtype="int16")
        raise sd.CallbackStop
    # ------------------------------------


# --- 主逻辑 ---
with audioread.audio_open(audio_tts) as f:
    file_iterator = iter(f)
    buffer = np.array([], dtype="int16")
    audio_channels = f.channels
    file_finished = False

    stream = sd.OutputStream(
        samplerate=f.samplerate, channels=f.channels, dtype="int16", callback=callback
    )

    stream.start()
    print("开始播放...")

    while stream.active:
        time.sleep(0.1)
    # 暂停
    # stream.abort()
    time.sleep(10)

    print("播放结束。")

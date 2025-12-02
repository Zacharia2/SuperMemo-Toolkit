import edge_tts
import miniaudio
import numpy as np
import sounddevice as sd

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
voice = "zh-CN-XiaoxiaoNeural"


def quick_fix_play():
    communicate = edge_tts.Communicate(text, voice)
    buffer = bytearray()

    for chunk in communicate.stream_sync():
        if chunk["type"] == "audio":
            buffer.extend(chunk["data"])

    audio = miniaudio.decode(
        bytes(buffer), output_format=miniaudio.SampleFormat.SIGNED16
    )
    samples = np.frombuffer(audio.samples, dtype=np.int16)
    if audio.nchannels == 2:
        samples = samples.reshape(-1, 2)
    print(f"准备播放总长度为 {len(samples)} 的音频，采样率: {audio.sample_rate}")
    sd.play(samples, samplerate=audio.sample_rate)
    sd.wait()


quick_fix_play()
# time.sleep(10)

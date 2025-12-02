import edge_tts
import miniaudio
import numpy as np
import sounddevice as sd


def play_text_sync():
    """
    使用同步方式，按句子处理并播放 edge-tts 生成的音频。
    此版本修复了所有已知问题，并包含了详细的注释。
    """
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

    # 1. 创建 Communicate 对象
    communicate = edge_tts.Communicate(text, voice)

    # 2. 初始化变量
    sentence_buffer = bytearray()  # 用于累积当前句子的音频数据
    all_sentence_samples = []  # 用于收集所有句子的 NumPy 音频数组
    sample_rate = 24000  # Edge TTS 的常用采样率，设为默认值

    # 3. 使用同步流遍历所有数据块
    for chunk in communicate.stream_sync():
        chunk_type = chunk["type"]

        # 累积音频数据
        if chunk_type == "audio":
            sentence_buffer.extend(chunk["data"])

        # 处理句子边界
        elif chunk_type == "SentenceBoundary":
            # --- 关键检查：只有当缓冲区有数据时，才进行处理 ---
            if len(sentence_buffer) > 0:
                print(f"检测到句子边界，处理 {len(sentence_buffer)} 字节的音频数据...")

                try:
                    # --- 修复 TypeError: 将 bytearray 转换为 bytes ---
                    audio = miniaudio.decode(
                        bytes(sentence_buffer),
                        output_format=miniaudio.SampleFormat.SIGNED16,
                    )
                    samples = np.frombuffer(audio.samples, dtype=np.int16)

                    # 处理立体声
                    if audio.nchannels == 2:
                        samples = samples.reshape(-1, 2)

                    # 将当前句子的音频数据添加到总列表中
                    all_sentence_samples.append(samples)
                    sample_rate = audio.sample_rate

                except Exception as e:
                    print(f"解码音频时出错: {e}")

                # --- 修复逻辑错误：正确清空 bytearray ---
                sentence_buffer.clear()
            else:
                # 当缓冲区为空时，会执行这里
                # 这证明了 SentenceBoundary 可以在没有音频数据时出现（例如由逗号引起）
                print("检测到句子边界，但缓冲区为空（可能是由停顿标点引起的）。")

    # 4. 循环结束后，检查并处理最后可能剩余的数据
    if len(sentence_buffer) > 0:
        print("处理最后一句的音频数据...")
        # (这里的处理逻辑与上面相同)
        audio = miniaudio.decode(
            bytes(sentence_buffer), output_format=miniaudio.SampleFormat.SIGNED16
        )
        samples = np.frombuffer(audio.samples, dtype=np.int16)
        if audio.nchannels == 2:
            samples = samples.reshape(-1, 2)
        all_sentence_samples.append(samples)
        sample_rate = audio.sample_rate
        sentence_buffer.clear()

    # 5. 播放所有收集到的音频
    if all_sentence_samples:
        print("\n所有句子处理完毕，开始播放完整音频...")
        # --- 修复逻辑错误：拼接所有句子的音频 ---
        full_audio = np.concatenate(all_sentence_samples, axis=0)
        print(f"总音频长度: {len(full_audio)} 采样点, 采样率: {sample_rate}")
        sd.play(full_audio, samplerate=sample_rate)
        sd.wait()
        print("播放完成。")
    else:
        print("\n没有收集到任何可播放的音频。")


# --- 运行函数 ---
if __name__ == "__main__":
    play_text_sync()

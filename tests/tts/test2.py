import edge_tts
import miniaudio
import numpy as np
import sounddevice as sd


def stream_decoded_sentences_with_rate(text, voice):
    communicate = edge_tts.Communicate(text, voice)
    sentence_buffer = bytearray()
    current_sample_rate = 24000

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
                if audio.nchannels == 2:
                    samples = samples.reshape(-1, 2)
                current_sample_rate = audio.sample_rate
                # 产出元组 (samples, rate)
                yield (samples, current_sample_rate)
                sentence_buffer.clear()

    if len(sentence_buffer) > 0:
        audio = miniaudio.decode(
            bytes(sentence_buffer), output_format=miniaudio.SampleFormat.SIGNED16
        )
        samples = np.frombuffer(audio.samples, dtype=np.int16)
        if audio.nchannels == 2:
            samples = samples.reshape(-1, 2)
        current_sample_rate = audio.sample_rate
        yield (samples, current_sample_rate)


def play_streaming_by_sentence():
    """
    使用流式方式，边解码边播放每个句子。
    """
    text = """君不见，黄河之水天上来，奔流到海不复回。
        君不见，高堂明镜悲白发，朝如青丝暮成雪。
        人生得意须尽欢，莫使金樽空对月。
        天生我材必有用，千金散尽还复来。"""
    voice = "zh-CN-XiaoxiaoNeural"

    # --- 修正版：让生成器同时产出采样率 ---

    # --- 使用修正版的生成器 ---
    print("\n--- 开始流式播放 ---")
    decoded_stream_with_rate = stream_decoded_sentences_with_rate(text, voice)

    for i, (sentence_samples, sample_rate) in enumerate(decoded_stream_with_rate):
        print(
            f"\n[{i + 1}] 正在播放当前句子 (采样率: {sample_rate}, 长度: {len(sentence_samples)})..."
        )
        sd.play(sentence_samples, samplerate=sample_rate)
        sd.wait()  # 等待当前句子播放完毕，再处理下一个

    print("\n--- 所有句子播放完毕 ---")


# --- 运行函数 ---
if __name__ == "__main__":
    play_streaming_by_sentence()

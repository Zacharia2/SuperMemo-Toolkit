import mad


class MadAudioFile:
    """
    MPEG audio stream decoder using the MAD library.

    This class can decode from any file-like object (stream), not just files.
    """

    def __init__(self, file_object):
        """
        Initializes the decoder with a file-like object.

        Args:
            file_object: A readable, binary file-like object (e.g., from open(), io.BytesIO, etc.).
        """
        if not hasattr(file_object, "read"):
            raise TypeError("Input must be a file-like object with a 'read' method.")

        # MadFile 现在直接使用传入的流
        self.mf = mad.MadFile(file_object)
        if not self.mf.total_time():
            # MadFile 内部可能会关闭流，但我们不希望它关闭外部传入的流
            # 所以这里我们只抛出异常，让调用者处理流的生命周期
            raise ValueError("Failed to decode the provided stream. Is it a valid MP3?")

        # 注意：我们不再持有文件对象 (self.fp)，因为它的生命周期由调用者管理

    def close(self):
        """Closes the MAD decoder and releases resources."""
        if hasattr(self, "mf"):
            del self.mf

    def read_blocks(self, block_size=4096):
        """Generates buffers containing PCM data from the stream."""
        while True:
            out = self.mf.read(block_size)
            if not out:
                break
            yield bytes(out)

    @property
    def samplerate(self):
        """Sample rate in Hz."""
        return self.mf.samplerate()

    @property
    def duration(self):
        """Length of the audio in seconds (a float)."""
        return float(self.mf.total_time()) / 1000

    @property
    def channels(self):
        """The number of channels."""
        if self.mf.mode() == mad.MODE_SINGLE_CHANNEL:
            return 1
        elif self.mf.mode() in (
            mad.MODE_DUAL_CHANNEL,
            mad.MODE_JOINT_STEREO,
            mad.MODE_STEREO,
        ):
            return 2
        else:
            return 2

    def __del__(self):
        self.close()

    def __iter__(self):
        return self.read_blocks()

    def __enter__(self):
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.close()
        return False

    @classmethod
    def from_file(cls, filename):
        """
        Convenience class method to create an instance from a file path.

        This method handles opening and closing the file for you.
        """
        fp = open(filename, "rb")
        try:
            return cls(fp)
        except Exception:
            fp.close()
            raise

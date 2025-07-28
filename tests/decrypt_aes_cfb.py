from Crypto.Cipher import AES

# pip install pycryptodome
# Java: private static final byte[] a = {-125, -18, 109, 123, -112, 56, 65, -114, 45, -101, 46, 14, -18, -44, -54, 82};
key = bytes(
    [
        b % 256
        for b in [
            -125,
            -18,
            109,
            123,
            -112,
            56,
            65,
            -114,
            45,
            -101,
            46,
            14,
            -18,
            -44,
            -54,
            82,
        ]
    ]
)


def decrypt_aes_cfb(encrypted_data):
    try:
        cipher = AES.new(key, AES.MODE_CFB, iv=bytes(AES.block_size), segment_size=128)
        return cipher.decrypt(encrypted_data)
    except Exception as e:
        print(e)
        return None


if __name__ == "__main__":
    with open("C:/Users/Snowy/Desktop/assets/mzdxj08", "rb") as fs:
        encrypted_data = fs.read()
    decrypted_data = decrypt_aes_cfb(encrypted_data)
    decoded_str = str(decrypted_data, encoding="utf-16le", errors="ignore")

    processed_str = decoded_str.replace("  ", "\u3000\u3000")
    processed_str = processed_str.replace("\r\n\r\n", "\r\n\u3000\r\n")

    with open("C:/Users/Snowy/Desktop/mzdxj08.txt", "w", encoding="utf-16le") as fs:
        fs.write(processed_str)

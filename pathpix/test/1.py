import chardet
import codecs


def is_utf8_supported_in_gb2312(char):
    encoded_bytes = char.encode("utf-8")
    result = chardet.detect(encoded_bytes)
    encoding = result["encoding"]

    if encoding == "GB2312":
        print(f"The character '{char}' is supported by GB2312 encoding.")
        return True
    else:
        print(f"The character '{char}' is not supported by GB2312 encoding.")
        return False


char_to_check = "你"  # 输入要检查的特定字符
is_utf8_supported_in_gb2312(char_to_check)


def is_utf8_supported_in_gbk(char):
    code = ord(char)
    try:
        chr(code).encode("gbk")
    except ValueError:
        print(
            f"{code}",
            "无法找到对应的GBK字符, 将使用字符实体 (numeric character reference) 替代",
            f"&#x{code};",
        )
        return (code, f"&#x{code};")


is_utf8_supported_in_gbk(chr(0x0086))

# def is_encoding_supported(char, encoding):
#     try:
#         char.encode(encoding)
#         char.decode(encoding)
#     except UnicodeEncodeError:
#         print(f"The character '{char}' is not supported by {encoding} encoding.")
#         return False
#     except UnicodeDecodeError:
#         print(f"The character '{char}' is not supported by {encoding} encoding.")
#         return False
#     else:
#         print(f"The character '{char}' is supported by {encoding} encoding.")
#         return True


# char_to_check = "你"  # 输入要检查的特定字符
# is_encoding_supported(char_to_check, "GB2312")  # 使用GB2312编码进行检查

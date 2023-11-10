import chardet

def is_utf8_supported_in_gb2312(char):
    encoded_bytes = char.encode('utf-8')
    result = chardet.detect(encoded_bytes)
    encoding = result['encoding']
    
    if encoding == 'GB2312':
        print(f"The character '{char}' is supported by GB2312 encoding.")
        return True
    else:
        print(f"The character '{char}' is not supported by GB2312 encoding.")
        return False

char_to_check = "你"  # 输入要检查的特定字符
is_utf8_supported_in_gb2312(char_to_check)
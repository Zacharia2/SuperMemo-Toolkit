import re


def is_utf8_supported_in_gbk(char):
    code = ord(char)
    try:
        chr(code).encode("gbk")
        return True
    except ValueError:
        print(
            f"Unicode code point: {code}",
            f"无法找到对应的GBK字符, 将使用字符实体 (numeric character reference) '&#x{code};' 替代",
        )
        return (chr(code), f"&#x{code};")


# 最好可以自动将不支持的字符转换为字符实体。
# 挨个读取字符，判断gb2312是否支持，不支持就变成字符实体。
def make_escape_safe(html_str):
    escapeSequence = {
        "EM SPACE": (chr(0x2003), "&ensp;"),
        "COPYRIGHT SIGN": (chr(0x00A9), "&copy;"),
        "EM DASH": (chr(0x2014), "&#8212;"),
        "chapterlast": (chr(0xF108), "&#10048;"),
        "REPLACEMENT CHARACTER": (chr(0xFFFD), "&#65533;"),
        "WHITE FLORETTE": (chr(0x2740), "&#10048;"),
        "START OF SELECTED AREA": (chr(0x0086), "&#x0086;"),
    }
    for escape in escapeSequence.values():
        html_str = html_str.replace(escape[0], escape[1])

    nosupp_char_list = []
    for char in html_str:
        result_bool = is_utf8_supported_in_gbk(char)
        if not result_bool:
            nosupp_char_list.append(result_bool)

    for char_tuple in nosupp_char_list:
        html_str = html_str.replace(char_tuple[0], char_tuple[1])
    return html_str


# path = path.replace("\\", "/")
# directory = directory.replace("\\", "/")
# 解码URL路径，转换为文件系统路径
# fs_path = urllib.parse.unquote(path)
win_path = 'C:\\Users\\Snowy\\Desktop\\sm18\\systems\\all in one\\elements\\web_pic\\im_2023-11-11-09_50_plot_74fc811b-cb87-4bff-8d05-6d41921da7b7.png'
if not win_path.startswith("file:///"):
    win_path = "file:///" + win_path

pattern = re.compile(r"file:///(.*?elements\\|.*?elements/)")
src_path = pattern.sub("file:///[PrimaryStorage]", win_path)
print()
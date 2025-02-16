import itertools
import os
import re
import pypinyin


# resolved：空格变问号的问题
# https://blog.csdn.net/u013778905/article/details/53177042
# 符号库：https://www.fuhaoku.net/U+00A9
def escape_sequence(doc: str):
    escape_sequence = {
        "EM SPACE": (chr(0x2003), "&ensp;"),
        "COPYRIGHT SIGN": (chr(0x00A9), "&copy;"),
        "EM DASH": (chr(0x2014), "&#8212;"),
        "chapterlast": (chr(0xF108), "&#10048;"),
        "REPLACEMENT CHARACTER": (chr(0xFFFD), "&#65533;"),
    }
    for escape in escape_sequence.values():
        doc = doc.replace(escape[0], escape[1])
    return doc


def get_id_func():
    counter = itertools.count()
    next(counter)

    def p():
        return str(next(counter))

    return p


def mkdir(path):
    folder = os.path.exists(path)
    if not folder:
        os.makedirs(path)
        print("创建文件夹:: " + path)


def makeNameSafe(name):
    illegalFilenameCharacters = r"/<|>|\:|\"|\/|\\|\||\?|\*|\^|\s/g"
    fixedTitle = re.sub(illegalFilenameCharacters, "_", name)
    return fixedTitle


# 全角转半角
def full_to_half(text: str):  # 输入为一个句子
    _text = ""
    for char in text:
        inside_code = ord(
            char
        )  # 以一个字符（长度为1的字符串）作为参数，返回对应的 ASCII 数值
        if inside_code == 12288:  # 全角空格直接转换
            inside_code = 32
        elif 65281 <= inside_code <= 65374:  # 全角字符（除空格）根据关系转化
            inside_code -= 65248
        _text += chr(inside_code)
    return _text


def trans_pinyin(str):
    trans_list = []
    half_text = full_to_half(str)
    for pinyin_name in pypinyin.pinyin(half_text, style=pypinyin.NORMAL):
        for pinyin_name_ in pinyin_name:
            pinyin_name__ = pinyin_name_.capitalize()
            trans_list.append(pinyin_name__)
    return "".join(trans_list)

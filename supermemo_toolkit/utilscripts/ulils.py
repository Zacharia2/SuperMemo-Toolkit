import itertools
import os
import re
from pathlib import Path

import pypinyin
import pywintypes
import win32con
import win32file

_ERROR_SHARING_VIOLATION = 32
_ERROR_LOCK_VIOLATION = 33


def is_kno_locked(path) -> bool:
    """检测 .kno 是否被占用（SuperMemo 打开集合时会占用）。

    以 FILE_SHARE_NONE 独占打开：任何其他句柄打开着文件都会导致共享冲突。
    """
    try:
        handle = win32file.CreateFile(
            str(path),
            win32con.GENERIC_READ,
            0,  # FILE_SHARE_NONE，win32con 不定义 0 常量
            None,
            win32con.OPEN_EXISTING,
            0,
            None,
        )
    except pywintypes.error as e:
        # 32 = 共享冲突；33 = 字节范围锁冲突，一并算“被占用”
        return e.winerror in (
            _ERROR_SHARING_VIOLATION,
            _ERROR_LOCK_VIOLATION,
        )

    handle.Close()  # PyHANDLE 也支持 with 语句
    return False


def is_collection_active(kno_path: Path) -> bool:
    """集合是否正在激活（.kno 文件存在且被锁定）。"""
    p = Path(kno_path)
    return p.exists() and is_kno_locked(p)


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
    illegalFilenameCharacters = r"<|>|\:|\"|\/|\\|\||\?|\*|\^|\s"
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

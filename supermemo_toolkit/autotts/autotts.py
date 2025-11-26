from os import path
import edge_tts
import html2text
import pyperclip
import win32gui
from pywinauto.application import Application
from supermemo_toolkit.title_complete.tcomp import parseNodeAsText
import time
import logging
from supermemo_toolkit.utilscripts.config import get_config_dir

logger = logging.getLogger(__name__)


app = Application(backend="win32").connect(class_name="TElWind")
text_maker = html2text.HTML2Text()
text_maker.ignore_links = True
text_maker.bypass_tables = False
text_maker.ignore_images = True
text_maker.ignore_emphasis = True
audio_tts = path.join(get_config_dir(), "audio_tts.mp3")
hisWindowText = ""
targetClassName = [
    "TMsgDialog",
    "TBitBtnTScrollBox",
    "Internet Explorer_Server",
    "TElWind",
    "TBitBtn",
]


class PlaysoundException(Exception):
    pass


def canonicalizePath(path):
    """
    Support passing in a pathlib.Path-like object by converting to str.
    """
    import sys

    if sys.version_info[0] >= 3:
        return str(path)
    else:
        # On earlier Python versions, str is a byte string, so attempting to
        # convert a unicode string to str will fail. Leave it alone in this case.
        return path


def playsoundWin(sound, block=True):
    sound = '"' + canonicalizePath(sound) + '"'

    from ctypes import create_unicode_buffer, windll, wintypes

    windll.winmm.mciSendStringW.argtypes = [
        wintypes.LPCWSTR,
        wintypes.LPWSTR,
        wintypes.UINT,
        wintypes.HANDLE,
    ]
    windll.winmm.mciGetErrorStringW.argtypes = [
        wintypes.DWORD,
        wintypes.LPWSTR,
        wintypes.UINT,
    ]

    def winCommand(*command):
        bufLen = 600
        buf = create_unicode_buffer(bufLen)
        command = " ".join(command)
        errorCode = int(
            windll.winmm.mciSendStringW(command, buf, bufLen - 1, 0)
        )  # use widestring version of the function
        if errorCode:
            errorBuffer = create_unicode_buffer(bufLen)
            windll.winmm.mciGetErrorStringW(
                errorCode, errorBuffer, bufLen - 1
            )  # use widestring version of the function
            exceptionMessage = (
                "\n    Error " + str(errorCode) + " for command:"
                "\n        " + command + "\n    " + errorBuffer.value
            )
            logger.error(exceptionMessage)
            raise PlaysoundException(exceptionMessage)
        return buf.value

    try:
        logger.debug("Starting")
        winCommand("open {}".format(sound))
        winCommand("play {}{}".format(sound, " wait" if block else ""))
        logger.debug("Returning")
    finally:
        try:
            winCommand("close {}".format(sound))
        except PlaysoundException:
            logger.warning("Failed to close the file: {}".format(sound))
            # If it fails, there's nothing more that can be done...
            pass


# 切换页面就触发播放。
def play_content():
    app.top_window().type_keys("^c")
    text = pyperclip.paste()
    node = parseNodeAsText(text)
    if len(node) > 0 and "Component" in node[0] and "HTMFile" in node[0]["Component"]:
        htmFile = node[0]["Component"]["HTMFile"]
        with open(htmFile, mode="r", encoding="utf-8") as f:
            htm = f.read()
        text = text_maker.handle(htm).translate(str.maketrans("#*-", "   "))
        print(text)
        communicate = edge_tts.Communicate(text, "zh-CN-XiaoxiaoNeural")
        communicate.save_sync(audio_tts)
        playsoundWin(audio_tts)
    else:
        print("未找到")


while True:
    time.sleep(1)
    focus_hwnd = win32gui.WindowFromPoint(win32gui.GetCursorPos())
    focusClassName = win32gui.GetClassName(focus_hwnd)
    if focusClassName not in targetClassName:
        continue

    foreground_hwnd = win32gui.GetForegroundWindow()
    if foreground_hwnd == 0:
        continue
    foregroundClassName = win32gui.GetClassName(foreground_hwnd)
    foregroundWindowText = win32gui.GetWindowText(foreground_hwnd)

    if foregroundClassName == "TElWind" and hisWindowText != foregroundWindowText:
        print(f"窗口标题: {foregroundWindowText}")
        play_content()
        hisWindowText = foregroundWindowText


# 在sm窗口下，然后要监听鼠标左键，然后看看标题或者内容是否改变，然后再决定是否播放内容。
# 交互逻辑是点击下一个自动播放。或者自己复制自动播放。

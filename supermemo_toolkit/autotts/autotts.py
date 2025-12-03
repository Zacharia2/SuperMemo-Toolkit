import time
import html2text
import pyperclip
import win32gui
import logging
from os import path
from pywinauto.application import Application
from supermemo_toolkit.autotts.switcher import AudioSwitcher
from supermemo_toolkit.title_complete.tcomp import parseNodeAsText
from supermemo_toolkit.utilscripts.config import get_config_dir
import warnings


logger = logging.getLogger(__name__)
warnings.filterwarnings("ignore", message=".*32-bit application should be automated.*")


app = Application(backend="win32").connect(class_name="TElWind")
switcher = AudioSwitcher()
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
    "TScrollBox",
    "TTabControl",
    "TToolBar",
]


# 切换页面就触发获取文本。
def get_content():
    # 不能是编辑状态下 alt+10,o,e
    TElWind = app.window(class_name="TElWind")
    TElWind.type_keys("%{F12}co")  # alt+f12, c, o
    time.sleep(0.5)
    text = pyperclip.paste()
    time.sleep(0.5)
    pyperclip.copy("")
    if "-" * 15 in text:
        lines_text = []
        for index, line in enumerate(text.splitlines()):
            if line.startswith("-" * 15):
                lines_text = text.splitlines()[:index]
                break
        text = "\n".join(lines_text)
    if text == "" or len(text) < 5:
        TElWind.type_keys("%{F12}mp^c")  # alt+f12, m, p, ctrl+c
        time.sleep(0.5)
        text = pyperclip.paste()
        time.sleep(0.5)
        pyperclip.copy("")
        # 解析nodeText，并设置空值守卫
        node = parseNodeAsText(text)
        if (
            len(node) == 0
            or "Component" not in node[0]
            or "HTMFile" not in node[0]["Component"]
        ):
            return ""
        # 解析html并转换为plainText。
        htmFile = node[0]["Component"]["HTMFile"]
        with open(htmFile, mode="r", encoding="utf-8") as f:
            htm = f.read()
        text = text_maker.handle(htm).translate(str.maketrans("#*-", "   "))
        return text
    return text


def focusInArea() -> bool:
    focus_hwnd = win32gui.WindowFromPoint(win32gui.GetCursorPos())
    focusClassName = win32gui.GetClassName(focus_hwnd)
    if focusClassName not in targetClassName:
        return False
    return True


def foregroundInArea() -> bool:
    foreground_hwnd = win32gui.GetForegroundWindow()
    if foreground_hwnd == 0:
        return False
    foregroundClassName = win32gui.GetClassName(foreground_hwnd)
    if foregroundClassName not in targetClassName:
        return False
    return True


def run():
    global hisWindowText

    while True:
        time.sleep(1)
        # 1. 光标位置必须在选定区域内
        if not focusInArea():
            continue

        # 2. 最前窗口名字必须为TElWind
        if not foregroundInArea():
            continue
        # 3. 历史最求窗口名和当前最前窗口名必须不一致
        # 当光标在选定区域并且最前窗口为选定区域，说明目标窗口聚焦
        foregroundWindowText = win32gui.GetWindowText(win32gui.GetForegroundWindow())
        if hisWindowText != foregroundWindowText:
            print(f"[Main] 窗口标题: {foregroundWindowText}")
            text = get_content()
            print(f"[Main] len={len(text)}, {text[:10]}")
            if text is not None and text != "":
                switcher.stop()
                switcher.play(text)
            hisWindowText = foregroundWindowText


run()
# 在sm窗口下，然后要监听鼠标左键，然后看看标题或者内容是否改变，然后再决定是否播放内容。
# 交互逻辑是点击下一个自动播放。或者自己复制自动播放。

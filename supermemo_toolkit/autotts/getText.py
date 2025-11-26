from os import path
import edge_tts
import html2text
import pyperclip
import win32gui
from pywinauto.application import Application
from supermemo_toolkit.title_complete.tcomp import parseNodeAsText
from pynput import mouse
import time
from playsound import playsound

from supermemo_toolkit.utilscripts.config import get_config_dir

app = Application(backend="win32").connect(class_name="TElWind")
text_maker = html2text.HTML2Text()
text_maker.ignore_links = True
text_maker.bypass_tables = False
text_maker.ignore_images = True
text_maker.ignore_emphasis = True
audio_tts = path.join(get_config_dir(), "audio_tts.mp3")


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
        playsound(audio_tts)
    else:
        print("未找到")


def on_click(x, y, button, pressed):
    if not pressed:
        return
    className = win32gui.GetClassName(win32gui.WindowFromPoint((x, y)))
    targetClassName = [
        "TMsgDialog",
        "TBitBtnTScrollBox",
        "Internet Explorer_Server",
        "TElWind",
        "TBitBtn",
    ]

    if className not in targetClassName:
        print(f"窗口: {className}")
        return

    elif className == "TBitBtn":
        print(f"鼠标点击了目标按钮: {className}")
        time.sleep(1)
        play_content()


with mouse.Listener(on_click=on_click) as listener:
    listener.join()


# 在sm窗口下，然后要监听鼠标左键，然后看看标题或者内容是否改变，然后再决定是否播放内容。
# 交互逻辑是点击下一个自动播放。或者自己复制自动播放。

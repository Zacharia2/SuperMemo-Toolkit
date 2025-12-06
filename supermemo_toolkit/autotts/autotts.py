import sys
import time
from bs4 import BeautifulSoup
import pyperclip
import win32gui
import logging
import warnings
from tkinter import messagebox
from pywinauto.application import Application
from pywinauto.findwindows import ElementNotFoundError
from pywinauto.base_wrapper import ElementNotEnabled
from supermemo_toolkit.autotts.switcher import AudioSwitcher
from supermemo_toolkit.autotts.ui import WinGUI
from supermemo_toolkit.title_complete.tcomp import parseNodeAsText


class AutoTTS:
    def __init__(self):
        self.logger = logging.getLogger(__name__)
        warnings.filterwarnings(
            "ignore", message=".*32-bit application should be automated.*"
        )

        try:
            self.app = Application(backend="win32").connect(class_name="TElWind")
        except Exception as e:
            if isinstance(e, ElementNotFoundError):
                messagebox.showerror("错误", "SuperMemo 可能未启动\n" + str(e))
            else:
                messagebox.showerror("错误", e)
            exit()

        self.switcher = AudioSwitcher()
        self.hisWindowText = ""
        self.targetClassName = [
            "TMsgDialog",
            "TBitBtnTScrollBox",
            "Internet Explorer_Server",
            "TElWind",
            "TBitBtn",
            "TScrollBox",
            "TTabControl",
            "TToolBar",
        ]
        self.window = None
        self.stop_run_main_loop = True  # 软件启动后手动启动监听

    def set_autotts_window(self, window: WinGUI):
        self.window = window

    def get_text_by_parseNodeText(self) -> tuple[str, bool]:
        """方案一，解析nodeText"""
        TElWind = self.app.window(class_name="TElWind")
        TElWind.type_keys("%{F12}mp^c")  # alt+f12, m, p, ctrl+c
        # TODO 有时mp会写到笔记里面
        time.sleep(0.3)
        nodeText = pyperclip.paste()
        if len(nodeText) < 5:
            time.sleep(0.3)
            pyperclip.copy("")
            TElWind.type_keys("%{F12}b^c")  # alt+f12, b, ctrl+c
            time.sleep(0.3)
            nodeText = pyperclip.paste()
        time.sleep(0.3)
        pyperclip.copy("")
        return self.getParsedNodeText(nodeText)

    def getParsedNodeText(self, nodeText: str):
        """对快捷键序列ctrl+c获得的文本进行解析"""
        # 解析nodeText
        # Topic和Learn卡片的第一个组件#1（Q）默认不读答案
        nodeListOfOne = parseNodeAsText(nodeText)
        if (
            len(nodeListOfOne) == 1
            and "Component#1" in nodeListOfOne[0]
            and "HTMFile" in nodeListOfOne[0]["Component#1"]
        ):
            # 解析html并转换为plainText。
            htmFile = nodeListOfOne[0]["Component#1"]["HTMFile"]
            with open(htmFile, mode="r", encoding="utf-8") as f:
                htm = f.read()
            soup = BeautifulSoup(htm, "html.parser")
            if soup.body:
                parsedText = soup.body.get_text(separator="\n", strip=True)
            else:
                parsedText = soup.get_text(separator="\n", strip=True)
            return (parsedText, True)
        else:
            return ("", False)

    def get_text_by_copyPlainText(self) -> str:
        """方案二，直接取文本内容"""
        # 此方案执行快捷键序列只会获取第一个组件的内容，对于Learn只会获取Q。
        # 如果鼠标选中执行将复制获取焦点的组件内容
        TElWind = self.app.window(class_name="TElWind")
        TElWind.type_keys("%{F12}co")  # alt+f12, c, o
        time.sleep(0.3)
        text = pyperclip.paste()
        time.sleep(0.3)
        pyperclip.copy("")
        return self.getPrasedPlainText(text)

    def getPrasedPlainText(self, text: str):
        """对快捷键序列alt+f12, c, o获得的文本进行解析"""
        if "-" * 15 in text:
            lines_text = []
            for index, line in enumerate(text.splitlines()):
                if line.startswith("-" * 15):
                    lines_text = text.splitlines()[:index]
                    break
            text = "\n".join(lines_text)
        if len(text) < 5:
            text = ""
        return text

    def get_content(self):
        """切换页面就触发获取文本。"""
        # 让pywinauto自己获取焦点是不可用的。
        # 不能是编辑状态下
        # alt+10,o,e
        text, ok = self.get_text_by_parseNodeText()
        if ok:
            return text
        else:
            text = self.get_text_by_copyPlainText()
            return text

    def focusInArea(self) -> bool:
        focus_hwnd = win32gui.WindowFromPoint(win32gui.GetCursorPos())
        focusClassName = win32gui.GetClassName(focus_hwnd)
        if focusClassName not in self.targetClassName:
            return False
        return True

    def foregroundInArea(self) -> bool:
        # pywintypes.error: (5, 'GetCursorPos', '拒绝访问。')
        # 典型的 Windows 权限问题，最常见、最直接的解决方案：以管理员身份运行
        foreground_hwnd = win32gui.GetForegroundWindow()
        if foreground_hwnd == 0:
            return False
        foregroundClassName = win32gui.GetClassName(foreground_hwnd)
        if foregroundClassName not in self.targetClassName:
            return False
        return True

    @staticmethod
    def format_title(text: str) -> str:
        title = text[:10].translate(str.maketrans("\n\r", "  ")).strip()
        return f"[Main] len={len(title)}, {title}"

    def run_main_loop(self):
        # 停止监听守卫，默认停止监听
        if self.stop_run_main_loop:
            self.window.after(500, self.run_main_loop)
            return
        # 1. 光标位置必须在选定区域内
        if not self.focusInArea():
            self.window.after(500, self.run_main_loop)
            return

        # 2. 最前窗口名字必须为TElWind
        if not self.foregroundInArea():
            self.window.after(500, self.run_main_loop)
            return
        # 3. 历史最求窗口名和当前最前窗口名必须不一致
        # 当光标在选定区域并且最前窗口为选定区域，说明目标窗口聚焦
        foregroundWindowText = win32gui.GetWindowText(win32gui.GetForegroundWindow())
        if self.hisWindowText != foregroundWindowText:
            print(f"[Main] 窗口标题: {foregroundWindowText}")
            try:
                text = self.get_content()
            except ElementNotEnabled as _:
                print(
                    "[ElementNotEnabled] 未获取supermemo主元素内容窗口焦点，请点击窗口后再切换元素"
                )
                self.window.after(500, self.run_main_loop)
                return
            if text is not None and text != "":
                print(self.format_title(text))
                self.window.update_lable_text(self.format_title(text))
                self.switcher.stop()
                self.switcher.play(text)
                # 保存到重播按钮
                self.window.update_text(text)
            self.hisWindowText = foregroundWindowText

        self.window.after(500, self.run_main_loop)


class Controller:
    # 导入UI类后，替换以下的 object 类型，将获得 IDE 属性提示功能
    ui: WinGUI

    def __init__(self):
        self.auto_tts: AutoTTS = None

    def init(self, ui):
        """
        得到UI实例，对组件进行初始化配置
        """
        self.ui = ui

    def onEClick(self, evt):
        self.auto_tts.stop_run_main_loop = not self.auto_tts.stop_run_main_loop
        if self.auto_tts.stop_run_main_loop:
            self.auto_tts.window.update_lable_text("AutoTTS 窗口监听 已停止")
        else:
            self.auto_tts.window.update_lable_text("AutoTTS 窗口监听 已恢复")

    def onERightClick(self, evt):
        self.auto_tts.switcher.stop()
        self.auto_tts.window.update_lable_text(
            "[Main] stop play, wait again or next or copy-tts"
        )

    def onAClick(self, evt):
        # 目前为止所有获取内容都不是主动获得焦点的，而是被动获取
        text: str = self.ui.last_text
        if text is not None and text != "":
            print(self.auto_tts.format_title(text))
            self.auto_tts.window.update_lable_text(self.auto_tts.format_title(text))
            self.auto_tts.switcher.stop()
            self.auto_tts.switcher.play(text)

    def onTClick(self, evt):
        text = pyperclip.paste()
        time.sleep(0.3)
        pyperclip.copy("")
        text = self.auto_tts.getPrasedPlainText(text)
        if text is not None and text != "":
            print(self.auto_tts.format_title(text))
            self.auto_tts.window.update_lable_text(self.auto_tts.format_title(text))
            self.auto_tts.switcher.stop()
            self.auto_tts.switcher.play(text)
            self.auto_tts.window.update_text(text)

    def run_auto_tts_loop(self):
        self.auto_tts.run_main_loop()

    def set_autotts(self, autotts: AutoTTS):
        self.auto_tts = autotts

    def playPrasedPlainText(self):
        text = pyperclip.paste()
        time.sleep(0.3)
        pyperclip.copy("")
        text = self.auto_tts.getPrasedPlainText(text)
        if text != "":
            print(self.auto_tts.format_title(text))
            self.auto_tts.window.update_lable_text(self.auto_tts.format_title(text))
            self.auto_tts.switcher.stop()
            self.auto_tts.switcher.play(text)
            self.auto_tts.window.update_text(text)

    def playParsedNodeText(self):
        text = pyperclip.paste()
        time.sleep(0.3)
        pyperclip.copy("")
        text, ok = self.auto_tts.getParsedNodeText(text)
        if ok:
            print(self.auto_tts.format_title(text))
            self.auto_tts.window.update_lable_text(self.auto_tts.format_title(text))
            self.auto_tts.switcher.stop()
            self.auto_tts.switcher.play(text)
            self.auto_tts.window.update_text(text)


class Win(WinGUI):
    ctl: Controller

    def __init__(self, controller):
        self.ctl = controller
        super().__init__()
        self.__event_bind()
        self.__style_config()
        self.ctl.init(self)
        self.last_text = ""

    def __event_bind(self):
        self.tk_button_miik3xn9.bind("<Button-1>", self.ctl.onEClick)
        self.tk_button_miik3xn9.bind("<Button-3>", self.ctl.onERightClick)
        self.tk_button_miileno7.bind("<Button-1>", self.ctl.onAClick)
        self.tk_button_mipjikfh.bind("<Button-1>", self.ctl.onTClick)
        self.menu.add_command(
            label="重启监听",
            command=lambda: self.after(500, self.ctl.run_auto_tts_loop),
        )
        self.menu.add_command(
            label="播放文本(解析alt+f12+co)", command=self.ctl.playPrasedPlainText
        )
        self.menu.add_command(
            label="播放结点(解析ctrl+c,nodeText)", command=self.ctl.playParsedNodeText
        )
        self.menu.add_command(
            label="重置窗口位置", command=lambda: self.geometry(self.geometry_size)
        )
        self.menu.add_command(label="退出程序", command=self.quit)

    def quit(self):
        """退出程序"""
        print("[Replay] 正在退出程序...")
        # 设置守护线程的话，这边就直接终止不用等待？
        # 然后我也可以join守护线程嘛？
        # 不用，丢就丢了，通知到位就可以
        # join的话就丢不了了。
        # exit(0)
        # os._exit(0)
        # 先暂停把，清理完成就退出了
        self.ctl.auto_tts.switcher.stop()
        sys.exit(0)

    def __style_config(self):
        pass

    def update_text(self, text):
        """更新要重播的文本内容"""
        self.last_text = text

    def update_lable_text(self, mtext):
        """更新要重播的文本内容"""
        super().update_lable_text(mtext)


def run_auto_tts():
    controller = Controller()
    autotts_window = Win(controller)
    autotts = AutoTTS()
    autotts.set_autotts_window(autotts_window)
    controller.set_autotts(autotts)
    autotts_window.after(500, controller.run_auto_tts_loop())
    autotts_window.mainloop()


if __name__ == "__main__":
    run_auto_tts()

# if __name__ == "__main__":
#     while True:
#         run_main_loop()
# 在sm窗口下，然后要监听鼠标左键，然后看看标题或者内容是否改变，然后再决定是否播放内容。
# 交互逻辑是点击下一个自动播放。或者自己复制自动播放。

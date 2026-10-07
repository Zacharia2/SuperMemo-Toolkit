import logging
import sys
import threading
import warnings
from tkinter import messagebox

import pyperclip
from pywinauto.application import Application
from pywinauto.findwindows import ElementNotFoundError

from supermemo_toolkit.autotts.switcher import AudioSwitcher
from supermemo_toolkit.autotts.ui import WinGUI
from supermemo_toolkit.database.registry import TextRegistry
from supermemo_toolkit.database.trace import Trace


class AutoTTS:
    def __init__(self, onlyat=False):
        self.logger = logging.getLogger(__name__)
        warnings.filterwarnings(
            "ignore", message=".*32-bit application should be automated.*"
        )
        if not onlyat:
            try:
                self.app = Application(backend="win32").connect(class_name="TElWind")
            except Exception as e:  # noqa: BLE001
                if isinstance(e, ElementNotFoundError):
                    messagebox.showerror("错误", "SuperMemo 可能未启动\n" + str(e))
                else:
                    messagebox.showerror("错误", e)
                sys.exit()

        self.switcher = AudioSwitcher()
        self.window: Win = None
        self.trace: Trace = Trace()
        self.trace_thread = None
        self.stoped = True  # 软件启动后手动启动监听
        self.eid = None
        self.title = None

    def play_current_content(self, text_reg: TextRegistry = None):
        """在主线程里真正播放当前内容"""
        self.eid = text_reg.eId
        self.title = text_reg.eTitle[:12].strip()
        self.switcher.stop()
        if self.stoped == True:
            return

        text = text_reg.eComponents[1].eText if len(text_reg.eComponents) != 0 else None
        print(self.show_title())
        if text is not None and text != "":
            self.window.update_lable_text(self.show_title())
            self.switcher.play(text)
            # 保存到重播按钮
            self.window.update_text(text)

    def _on_trace_element_changed(self, text_reg):
        """Trace 线程里的回调，不能直接碰 Tk 控件"""

        if self.window:
            # 切回 Tk 主线程执行
            self.window.after(0, lambda tr=text_reg: self.play_current_content(tr))
        else:
            self.play_current_content(text_reg)

    def start_trace(self, mode="m"):
        """
        mode: 'm' 使用内存读取，'o' 使用 watchdog observer
        """
        if self.stoped == True:
            return

        def run():
            if mode == "m":
                self.trace.trace_with_mem(self._on_trace_element_changed)
            elif mode == "o":
                self.trace.trace_with_observer(self._on_trace_element_changed)
            else:
                raise ValueError("mode 只能是 'm' 或 'o'")

        self.trace.set_running()
        self.trace_thread = threading.Thread(target=run, daemon=True)
        self.trace_thread.start()
        self.stoped = False

    def stop_trace(self):
        self.trace.set_running(False)
        self.switcher.stop()
        self.stoped = True

    def set_autotts_window(self, window: WinGUI):
        self.window = window

    def set_replace_list(self, replace_list: dict):
        """设置替换列表，传入一个字典，键为要替换的文本，值为替换后的文本。"""
        self.switcher.replace_list = replace_list

    def show_title(self) -> str:
        return f"[TTS] [No. {self.eid}] [Title: {self.title[:12].strip()}]"

    @staticmethod
    def format_title(text: str) -> str:
        title = text[:12].translate(str.maketrans("\n\r", "  ")).strip()
        return f"[TTS] [LEN: {len(text)}] [Title: {title}]"


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
        self.auto_tts.stoped = not self.auto_tts.stoped
        if self.auto_tts.stoped:
            self.auto_tts.stop_trace()
            self.auto_tts.window.update_lable_text("AutoTTS 窗口监听 已停止")
        else:
            self.auto_tts.start_trace()
            self.auto_tts.window.update_lable_text("AutoTTS 窗口监听 已恢复")

    def onERightClick(self, evt):
        self.auto_tts.switcher.stop()
        self.auto_tts.window.update_lable_text("[TTS] play stopped")

    def onAClick(self, evt):
        # 目前为止所有获取内容都不是主动获得焦点的，而是被动获取
        text: str = self.ui.last_text
        if text is not None and text != "":
            print(self.auto_tts.format_title(text))
            self.auto_tts.window.update_lable_text(self.auto_tts.format_title(text))
            self.auto_tts.switcher.play(text)

    def onTClick(self, evt):
        text = pyperclip.paste()
        if text is not None and text != "":
            print(self.auto_tts.format_title(text))
            self.auto_tts.window.update_lable_text(self.auto_tts.format_title(text))
            self.auto_tts.switcher.play(text)
            self.auto_tts.window.update_text(text)

    def set_autotts(self, autotts: AutoTTS):
        self.auto_tts = autotts


class Win(WinGUI):
    ctl: Controller

    def __init__(self, controller: Controller, onlyat=False):
        self.ctl = controller
        super().__init__()
        if onlyat:
            self.__onlyat_event_bind()
        else:
            self.__full_event_bind()
        self.__style_config()
        self.ctl.init(self)
        self.last_text = ""

    def __full_event_bind(self):
        self.tk_button_miik3xn9.bind("<Button-1>", self.ctl.onEClick)
        self.tk_button_miik3xn9.bind("<Button-3>", self.ctl.onERightClick)
        self.tk_button_miileno7.bind("<Button-1>", self.ctl.onAClick)
        self.tk_button_mipjikfh.bind("<Button-1>", self.ctl.onTClick)
        self.menu.add_command(
            label="重置窗口位置", command=lambda: self.geometry(self.geometry_size)
        )
        self.menu.add_command(label="退出程序", command=self.quit)

    def __onlyat_event_bind(self):
        self.tk_button_miik3xn9.config(state="disabled")
        self.tk_button_miileno7.bind("<Button-1>", self.ctl.onAClick)
        self.tk_button_mipjikfh.bind("<Button-1>", self.ctl.onTClick)
        self.menu.add_command(
            label="重置窗口位置", command=lambda: self.geometry(self.geometry_size)
        )
        self.menu.add_command(label="退出程序", command=self.quit)

    def quit(self):
        """退出程序"""
        print("[Replay] 正在退出程序...")
        # 设置守护线程的话，这边就直接终止不用等待？ 然后我也可以join守护线程嘛？
        # 不用，丢就丢了，通知到位就可以 join的话就丢不了了。
        # exit(0) os._exit(0)
        # 先暂停把，清理完成就退出了
        self.ctl.auto_tts.stop_trace()
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


def run_auto_tts(onlyat: bool = False):
    controller = Controller()
    autotts_window = Win(controller, onlyat)
    autotts = AutoTTS(onlyat)
    autotts.set_autotts_window(autotts_window)
    autotts.set_replace_list({"[...]": "，什么，"})
    controller.set_autotts(autotts)
    autotts.start_trace()  # 或 mode="o"
    autotts_window.mainloop()


if __name__ == "__main__":
    # 点击下一个自动播放。或者自己复制自动播放。
    run_auto_tts()

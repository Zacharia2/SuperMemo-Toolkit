import sys
import pyperclip
import win32gui
import logging
import warnings
from tkinter import messagebox
from pywinauto.application import Application
from pywinauto.findwindows import ElementNotFoundError
from supermemo_toolkit.autotts.get_doc import get_supermemo_html_doc_by_win32
from supermemo_toolkit.autotts.switcher import AudioSwitcher
from supermemo_toolkit.autotts.ui import WinGUI


class AutoTTS:
    def __init__(self, onlyat=False):
        self.logger = logging.getLogger(__name__)
        warnings.filterwarnings(
            "ignore", message=".*32-bit application should be automated.*"
        )
        if not onlyat:
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

    def set_replace_list(self, replace_list: dict):
        """设置替换列表，传入一个字典，键为要替换的文本，值为替换后的文本。"""
        self.switcher.replace_list = replace_list

    def get_content(self):
        """切换页面就触发获取文本。"""
        return get_supermemo_html_doc_by_win32(self.app)

    def focusInArea(self) -> bool:
        focus_hwnd = win32gui.WindowFromPoint(win32gui.GetCursorPos())
        focusClassName = win32gui.GetClassName(focus_hwnd)
        if focusClassName not in self.targetClassName:
            return False
        return True

    @staticmethod
    def format_title(text: str) -> str:
        title = text[:12].translate(str.maketrans("\n\r", "  ")).strip()
        return f"[Main] len={len(text)}, {title}"

    def run_main_loop(self):
        # 停止监听守卫，默认停止监听
        if self.stop_run_main_loop:
            self.window.after(500, self.run_main_loop)
            return
        # 1. 光标位置必须在选定区域内
        if not self.focusInArea():
            self.window.after(500, self.run_main_loop)
            return

        # 3. 历史最求窗口名和当前最前窗口名必须不一致
        # 当光标在选定区域并且最前窗口为选定区域，说明目标窗口聚焦
        foregroundWindowText = self.app.window(class_name="TElWind").window_text()
        if self.hisWindowText != foregroundWindowText:
            print(f"[Main] 窗口标题: {foregroundWindowText}")
            text = self.get_content()
            if text is not None and text != "":
                print(self.format_title(text))
                self.window.update_lable_text(self.format_title(text))
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
        self.auto_tts.window.update_lable_text("[Main] play stopped")

    def onAClick(self, evt):
        # 目前为止所有获取内容都不是主动获得焦点的，而是被动获取
        text: str = self.ui.last_text
        if text is not None and text != "":
            print(self.auto_tts.format_title(text))
            self.auto_tts.window.update_lable_text(self.auto_tts.format_title(text))
            self.auto_tts.switcher.play(text)

    def onTClick(self, evt):
        text = pyperclip.paste()
        text = self.auto_tts.getPrasedPlainText(text)
        if text is not None and text != "":
            print(self.auto_tts.format_title(text))
            self.auto_tts.window.update_lable_text(self.auto_tts.format_title(text))
            self.auto_tts.switcher.play(text)
            self.auto_tts.window.update_text(text)

    def run_auto_tts_loop(self):
        self.auto_tts.run_main_loop()

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
            label="重启监听",
            command=lambda: self.after(500, self.ctl.run_auto_tts_loop),
        )
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
    autotts_window.after(500, controller.run_auto_tts_loop())
    autotts_window.mainloop()


if __name__ == "__main__":
    # 点击下一个自动播放。或者自己复制自动播放。
    run_auto_tts()

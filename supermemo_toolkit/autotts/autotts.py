import logging
import threading
from tkinter import messagebox

import pyperclip
import win32gui
from pywinauto.findwindows import ElementNotFoundError

from supermemo_toolkit.autotts.replace import normalize_text
from supermemo_toolkit.autotts.switcher import AudioSwitcher
from supermemo_toolkit.autotts.ui import WinGUI
from supermemo_toolkit.database.htmtext import get_supermemo_html
from supermemo_toolkit.database.registry import TextRegistry
from supermemo_toolkit.database.trace import Trace
from supermemo_toolkit.utilscripts.connector import supermemo


class AutoTTS:
    def __init__(self, onlyat=False):
        self.logger = logging.getLogger(__name__)

        if not onlyat:
            self.trace: Trace = Trace()
            self.app = supermemo.app
            if self.app is None:
                raise RuntimeError("AutoTTS 初始化失败，无法连接到 SuperMemo")

        self.switcher = AudioSwitcher()
        self.window: Win | None = None
        self.trace_thread = None
        self.stopped = True  # 软件启动后手动启动监听
        self.eid = None
        self.title = None
        self.legacy_version_his_window_text: str = ""
        self.legacy_sm_closed: bool = False

    def play_current_content(self, text_reg: TextRegistry = None):
        """在主线程里真正播放当前内容"""
        if text_reg is None or text_reg.eId is None:
            return
        self.eid = text_reg.eId
        self.title = text_reg.eTitle[:12].strip()
        self.switcher.stop()
        if self.stopped == True:
            return

        text = text_reg.get_component().Text
        print(self.show_title())
        if text != "":
            text = normalize_text(text)
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
        if self.stopped == True:
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
        self.stopped = False

    def stop_trace(self):
        if hasattr(self, "trace"):
            self.trace.set_running(False)
        self.switcher.stop()
        self.stopped = True

    def set_autotts_window(self, window: WinGUI):
        self.window = window

    def show_title(self) -> str:
        return f"[TTS] [No. {self.eid}] [Title: {self.title[:12].strip()}]"

    @staticmethod
    def format_title(text: str) -> str:
        title = text[:12].translate(str.maketrans("\n\r", "  ")).strip()
        return f"[TTS] [LEN: {len(text)}] [Title: {title}]"

    def legacy(self):
        def focusInArea() -> bool:
            targetClassName = [
                "TMsgDialog",
                "TBitBtnTScrollBox",
                "Internet Explorer_Server",
                "TElWind",
                "TBitBtn",
                "TScrollBox",
                "TTabControl",
                "TToolBar",
                "TButton",
                "TPage",
            ]
            focus_hwnd = win32gui.WindowFromPoint(win32gui.GetCursorPos())
            focusClassName = win32gui.GetClassName(focus_hwnd)
            return focusClassName in targetClassName

        # 停止监听守卫，默认停止监听
        if self.stopped:
            self.window.after(500, self.legacy)
            return

        if supermemo.snapshot is None:
            if supermemo.ensure_snapshot() is None:
                if not self.legacy_sm_closed:
                    self.window.update_lable_text("[TTS] SuperMemo 已关闭，等待重启")
                    self.legacy_sm_closed = True
                    self.legacy_version_his_window_text = ""
                self.window.after(2000, self.legacy)
                return
            self.app = supermemo.app
            self.legacy_sm_closed = False
            self.legacy_version_his_window_text = ""

        # 1. 光标位置必须在选定区域内
        if not focusInArea():
            self.window.after(500, self.legacy)
            return

        # 3. 历史最求窗口名和当前最前窗口名必须不一致
        # 当光标在选定区域并且最前窗口为选定区域，说明目标窗口聚焦
        foregroundWindowText = supermemo.window_text()
        if not foregroundWindowText:
            self.window.after(500, self.legacy)
            return

        if self.legacy_version_his_window_text != foregroundWindowText:
            print(f"[Main] 窗口标题: {foregroundWindowText}")
            text = get_supermemo_html(self.app)
            if text is not None and text != "":
                print(self.format_title(text))
                self.window.update_lable_text(self.format_title(text))
                self.switcher.play(text)
                # 保存到重播按钮
                self.window.update_text(text)
            self.legacy_version_his_window_text = foregroundWindowText

        self.window.after(500, self.legacy)


class Controller:
    # 导入UI类后，替换以下的 object 类型，将获得 IDE 属性提示功能
    ui: WinGUI

    def __init__(self, sm_ver: str = ""):
        self.auto_tts: AutoTTS = None
        self.sm_ver = sm_ver

    def init(self, ui):
        """
        得到UI实例，对组件进行初始化配置
        """
        self.ui = ui

    def onEClick(self, evt):
        self.auto_tts.stopped = not self.auto_tts.stopped
        if self.auto_tts.stopped:
            if self.sm_ver not in ["sm15", "sm16"]:
                self.auto_tts.stop_trace()
            self.auto_tts.window.update_lable_text("AutoTTS 窗口监听 已停止")
        else:
            if self.sm_ver not in ["sm15", "sm16"]:
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

    def run_legacy_autotts(self):
        self.auto_tts.legacy()


class Win(WinGUI):
    ctl: Controller

    def __init__(self, controller: Controller, onlyat=False, sm_ver: str = ""):
        self.ctl = controller
        self.sm_ver = sm_ver
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
        if self.sm_ver in ["sm15", "sm16"]:
            self.menu.add_command(
                label="重启监听",
                command=lambda: self.after(500, self.ctl.run_legacy_autotts),
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
        try:
            self.ctl.auto_tts.stop_trace()
            self.ctl.auto_tts.switcher.stop()
        finally:
            self.destroy()  # ← 销毁 Tk 窗口，mainloop() 立刻返回

    def __style_config(self):
        pass

    def update_text(self, text):
        """更新要重播的文本内容"""
        self.last_text = text

    def update_lable_text(self, mtext):
        """更新要重播的文本内容"""
        super().update_lable_text(mtext)


def supermemo_ver():
    """兼容旧调用。返回 sm_ver 或 None（弹窗已弹）。"""
    snap = supermemo.ensure_snapshot()
    if snap is None:
        err = supermemo.last_error
        if isinstance(err, ElementNotFoundError):
            messagebox.showerror("错误", "SuperMemo 可能未启动\n" + str(err))
        else:
            messagebox.showerror("错误", str(err) if err else "无法连接 SuperMemo")
        return None
    return snap.sm_ver


def run_auto_tts(onlyat: bool = False):
    if onlyat:
        autotts = AutoTTS(onlyat=True)
        controller = Controller()
        autotts_window = Win(controller, onlyat=True)
        autotts.set_autotts_window(autotts_window)
        controller.set_autotts(autotts)
    else:
        sm_ver = supermemo_ver()
        if sm_ver is None:
            return  # supermemo_ver 里已经弹过错误框，直接结束

        try:
            autotts = AutoTTS(onlyat=False)  # 先连 SuperMemo
        except Exception:  # noqa: BLE001
            return

        controller = Controller(sm_ver)
        autotts_window = Win(controller, onlyat=False, sm_ver=sm_ver)  # 成功后再建窗口
        autotts.set_autotts_window(autotts_window)
        controller.set_autotts(autotts)

        if sm_ver not in ["sm15", "sm16"]:
            autotts.start_trace()
        else:
            autotts_window.after(500, controller.run_legacy_autotts)

    autotts_window.mainloop()


if __name__ == "__main__":
    # 点击下一个自动播放。或者自己复制自动播放。
    run_auto_tts(onlyat=True)

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
import tkinter as tk


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

# 全局变量：存储上次播放的文本和悬浮按钮实例
last_played_text = ""
replay_button = None


# 悬浮重播按钮类
class ReplayButton:
    def __init__(self, switcher):
        self.switcher = switcher
        self.last_text = ""
        
        self.root = tk.Tk()
        self.root.overrideredirect(True)  # 移除窗口边框
        self.root.attributes('-topmost', True)  # 始终置顶
        self.root.attributes('-alpha', 0.85)  # 设置透明度
        self.root.geometry('70x30+100+100')  # 初始大小和位置
        
        # 创建按钮
        self.button = tk.Button(
            self.root,
            text="重播",
            command=self.replay,
            bg='#4CAF50',
            fg='white',
            activebackground='#45a049',
            relief=tk.FLAT,
            font=('Microsoft YaHei', 10, 'bold'),
            cursor='hand2'
        )
        self.button.pack(fill=tk.BOTH, expand=True)
        
        # 拖拽功能绑定
        self._offsetx = 0
        self._offsety = 0
        self.button.bind('<Button-1>', self.click_window)
        self.button.bind('<B1-Motion>', self.drag_window)
        
        # 右键菜单
        self.menu = tk.Menu(self.root, tearoff=0, bg='white', fg='black')
        self.menu.add_command(label="退出程序", command=self.quit)
        self.button.bind('<Button-3>', self.show_menu)
        
    def click_window(self, event):
        """记录鼠标点击位置"""
        self._offsetx = event.x
        self._offsety = event.y
        
    def drag_window(self, event):
        """拖拽移动窗口"""
        x = self.root.winfo_x() + event.x - self._offsetx
        y = self.root.winfo_y() + event.y - self._offsety
        self.root.geometry(f'+{x}+{y}')
        
    def show_menu(self, event):
        """显示右键菜单"""
        self.menu.post(event.x_root, event.y_root)
        
    def update_text(self, text):
        """更新要重播的文本内容"""
        self.last_text = text
        
    def replay(self):
        """重播上次的内容"""
        if self.last_text:
            print(f"[Replay] 重播文本，长度: {len(self.last_text)}")
            self.switcher.stop()
            self.switcher.play(self.last_text)
        else:
            print("[Replay] 暂无内容可重播")
        
    def quit(self):
        """退出程序"""
        print("[Replay] 正在退出程序...")
        self.root.quit()
        self.root.destroy()


def get_content():
    # 不能是编辑状态下 alt+10,o,e
    TElWind = app.window(class_name="TElWind")
    # =========
    TElWind.set_focus()
    time.sleep(0.2)
    TElWind.type_keys("%{F12}mp^c", set_foreground=False)  # alt+f12, m, p, ctrl+c
    time.sleep(0.3)
    text = pyperclip.paste()
    if len(text) < 5:
        TElWind.set_focus()
        TElWind.type_keys("%{F12}b^c", set_foreground=False)  # alt+f12, b, ctrl+c
        time.sleep(0.3)
        text = pyperclip.paste()
    time.sleep(0.3)
    pyperclip.copy("")
    # 解析nodeText
    node = parseNodeAsText(text)
    if len(node) != 0 and "Component" in node[0] and "HTMFile" in node[0]["Component"]:
        # 解析html并转换为plainText。
        htmFile = node[0]["Component"]["HTMFile"]
        with open(htmFile, mode="r", encoding="utf-8") as f:
            htm = f.read()
        text = text_maker.handle(htm).translate(str.maketrans("#*-", "   "))

    # =========
    else:
        TElWind.set_focus()
        time.sleep(0.2)
        TElWind.type_keys("%{F12}co", set_foreground=False)  # alt+f12, c, o
        time.sleep(0.3)
        text = pyperclip.paste()
        time.sleep(0.3)
        pyperclip.copy("")
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


def run_main_loop():
    """主监控循环（由 tkinter 定时调用）"""
    global hisWindowText, last_played_text
    
    try:
        # 1. 光标位置必须在选定区域内
        if not focusInArea():
            replay_button.root.after(500, run_main_loop)
            return

        # 2. 最前窗口名字必须在目标列表中
        if not foregroundInArea():
            replay_button.root.after(500, run_main_loop)
            return
            
        # 3. 窗口标题变化时获取新内容
        foregroundWindowText = win32gui.GetWindowText(win32gui.GetForegroundWindow())
        if hisWindowText != foregroundWindowText:
            print(f"[Main] 检测到窗口变化: {foregroundWindowText}")
            text = get_content()
            print(f"[Main] 获取内容长度: {len(text)}, 预览: {text[:50].strip()}")
            if text and len(text) >= 5:
                # 停止当前播放并播放新内容
                switcher.stop()
                switcher.play(text)
                # 保存到重播按钮
                last_played_text = text
                replay_button.update_text(text)
            hisWindowText = foregroundWindowText
            
    except Exception as e:
        print(f"[Main] 循环中发生错误: {e}")
        
    # 每 500ms 执行一次
    replay_button.root.after(500, run_main_loop)


def run():
    """主入口函数"""
    global replay_button, hisWindowText
    
    # 初始化历史窗口文本
    hisWindowText = ""
    
    # 创建悬浮按钮
    replay_button = ReplayButton(switcher)
    
    # 启动主循环（延迟 500ms 开始）
    replay_button.root.after(500, run_main_loop)
    
    # 运行 Tkinter 主事件循环
    print("[Main] 程序已启动，悬浮按钮已显示")
    replay_button.root.mainloop()


if __name__ == "__main__":
    run()
#!/usr/bin/env python3
"""smtk_launcher.py - SuperMemo toolkit 命令启动器 (极限紧凑版 + 悬浮视图)"""

from __future__ import annotations

import json
import os
import queue
import re
import shlex
import shutil
import socket
import subprocess
import sys
import threading
import time
import tkinter as tk
from pathlib import Path
from tkinter import messagebox, scrolledtext, ttk

# ============================================================
# 常量与主题字典
# ============================================================

APP_TITLE = "smtk Launcher"
CONFIG_FILE = Path.home() / ".config" / "supermemo_toolkit" / ".smtk_launcher.json"
CREATE_NO_WINDOW = 0x08000000 if sys.platform == "win32" else 0
SINGLE_INSTANCE_PORT = 49152
SHUTDOWN_PORT = 49200  # time_watch 关闭信号端口，以time_rewind.py定义为准

THEMES = {
    "light": {
        "BG_MAIN": "#f3f4f6",
        "BG_PANEL": "#ffffff",
        "BG_HOVER": "#e5e7eb",
        "FG_MAIN": "#1f2937",
        "FG_DIM": "#6b7280",
        "ACCENT": "#2563eb",
        "BORDER": "#e5e7eb",
        "PRIMARY_BG": "#2563eb",
        "PRIMARY_FG": "#ffffff",
        "PRIMARY_HOVER": "#1d4ed8",
        "STATUS_RUNNING": "#10b981",
        "TYPE_COLORS": {
            "TOPIC": "#10b981",
            "ITEM": "#3b82f6",
            "TASK": "#f59e0b",
            "UNKNOWN": "#ef4444",
        },
    },
    "dark": {
        "BG_MAIN": "#0d1117",
        "BG_PANEL": "#161b22",
        "BG_HOVER": "#21262d",
        "FG_MAIN": "#c9d1d9",
        "FG_DIM": "#8b949e",
        "ACCENT": "#58a6ff",
        "BORDER": "#30363d",
        "PRIMARY_BG": "#238636",
        "PRIMARY_FG": "#ffffff",
        "PRIMARY_HOVER": "#2ea043",
        "STATUS_RUNNING": "#3fb950",
        "TYPE_COLORS": {
            "TOPIC": "#3fb950",
            "ITEM": "#58a6ff",
            "TASK": "#d29922",
            "UNKNOWN": "#f85149",
        },
    },
}

COMMANDS = [
    {
        "name": "time_watch",
        "label": "托盘备份",
        "args": ["time", "watch"],
        "help": "监控集合打开/关闭",
    },
    {
        "name": "imgfit",
        "label": "图片适配",
        "args": ["imgfit", "--trace"],
        "help": "自动适配图片尺寸",
    },
    {
        "name": "autotts",
        "label": "自动朗读",
        "args": ["autotts"],
        "help": "AutoTTS 朗读当前元素",
    },
    {
        "name": "math_card",
        "label": "公式渲染",
        "args": ["math", "card", "--trace"],
        "help": "追踪并渲染公式",
    },
    {
        "name": "trace_mem",
        "label": "内存追踪",
        "args": ["trace", "--mem"],
        "help": "监控并展示在仪表盘",
    },
]

CUSTOM_NAME = "custom"
CUSTOM_LABEL = "自定义"
LOG: queue.Queue[tuple[str, str]] = queue.Queue()

# 全局保存互斥体句柄，防止被 Python 垃圾回收机制释放
_GLOBAL_MUTEX = None


# ============================================================
# 系统级工具 (单实例 & 防闪烁)
# ============================================================


def _ensure_single_instance() -> bool:
    """使用 Windows Mutex 确保单实例运行；若已存在则发送 UDP 唤醒信号。"""
    global _GLOBAL_MUTEX
    if sys.platform != "win32":
        return True

    import ctypes

    mutex_name = "Global\\smtk_launcher_mutex_v1"
    kernel32 = ctypes.windll.kernel32

    # 创建互斥体并保存句柄到全局变量
    _GLOBAL_MUTEX = kernel32.CreateMutexW(None, False, mutex_name)
    last_error = kernel32.GetLastError()

    if last_error == 183:  # ERROR_ALREADY_EXISTS
        kernel32.CloseHandle(_GLOBAL_MUTEX)
        _GLOBAL_MUTEX = None

        # 发送 UDP 唤醒信号给第一个实例
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.sendto(b"WAKE_UP", ("127.0.0.1", SINGLE_INSTANCE_PORT))
        except Exception:
            pass
        finally:
            s.close()
        return False
    return True


def _apply_composited_fix(root: tk.Tk):
    """使用 Win32 API 强制开启双缓冲，彻底解决透明窗口重绘闪烁"""
    if sys.platform != "win32":
        return
    try:
        import ctypes

        GWL_EXSTYLE = -20
        WS_EX_COMPOSITED = 0x02000000
        hwnd = ctypes.windll.user32.GetParent(root.winfo_id())
        if hwnd:
            style = ctypes.windll.user32.GetWindowLongW(hwnd, GWL_EXSTYLE)
            ctypes.windll.user32.SetWindowLongW(
                hwnd, GWL_EXSTYLE, style | WS_EX_COMPOSITED
            )
    except Exception:
        pass


# ============================================================
# 悬浮窗：创建即满足 origin_window.is_focusable_top_window() 判据
# ============================================================


class FloatingWindow(tk.Toplevel):
    """无边框悬浮窗：创建即满足 origin_window.is_focusable_top_window() 判据。

    Tk 的 overrideredirect 窗口有两个坑，都会让 origin_window 拒绝：
      1. 异步 map —— 刚创建时 IsWindowVisible=0，必须 update() 一次；
      2. 带 WS_EX_TOOLWINDOW —— origin_window 明确排除。
    这里在构造期一次性清掉 TOOLWINDOW/NOACTIVATE，让这个窗口成为
    find_origin_window() 从子进程上溯时可以命中的"可聚焦顶层窗口"，
    从而 imgfit --trace / math card --trace 等能正确找回焦点。
    """

    def __init__(
        self,
        master: tk.Misc,
        geometry: str = "400x130",
        opacity: float = 1.0,
        **kw,
    ):
        super().__init__(master, **kw)
        self.overrideredirect(True)
        self.attributes("-topmost", True)
        self.attributes("-alpha", opacity)
        self.geometry(geometry)
        self._become_focusable()

    def _become_focusable(self) -> None:
        if sys.platform != "win32":
            return
        try:
            import ctypes
            from ctypes import wintypes

            u = ctypes.WinDLL("user32", use_last_error=True)
            u.GetAncestor.argtypes = [wintypes.HWND, ctypes.c_uint]
            u.GetAncestor.restype = wintypes.HWND

            self.update()  # 强制 map → IsWindowVisible=1
            hwnd = u.GetAncestor(self.winfo_id(), 2) or self.winfo_id()
            if not hwnd:
                return

            # 清 WS_EX_NOACTIVATE(0x08000000) / WS_EX_TOOLWINDOW(0x80)
            ex = u.GetWindowLongW(hwnd, -20)  # GWL_EXSTYLE
            u.SetWindowLongW(hwnd, -20, ex & ~0x08000000 & ~0x00000080)
        except Exception:
            pass


# ============================================================
# 进程管理
# ============================================================


class Runner:
    """封装一个 smtk 子进程。"""

    def __init__(self, name: str, label: str, args: list[str] | None = None):
        self.name = name
        self.label = label
        self.args = list(args or [])
        self.proc: subprocess.Popen | None = None
        self.reader: threading.Thread | None = None

    def start(self, smtk_path: str) -> bool:
        if self.is_running():
            return False
        return self._spawn([smtk_path, *self.args])

    def _spawn(self, cmd: list[str]) -> bool:
        env = os.environ.copy()
        env["PYTHONIOENCODING"] = "utf-8"
        env["PYTHONUNBUFFERED"] = "1"
        # UI 模式：让 time_rewind.setup_logging 只往 stderr 写，
        # 由 _read_output 读入 LOG 队列，显示到日志窗口。
        env["SMTK_LOG_UI_ONLY"] = "1"
        try:
            self.proc = subprocess.Popen(
                cmd,
                stdin=subprocess.DEVNULL,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                creationflags=CREATE_NO_WINDOW,
                text=True,
                encoding="utf-8",
                errors="replace",
                bufsize=1,
                env=env,
            )
        except OSError as e:
            LOG.put((self.name, f"[启动失败] {e}\n"))
            self.proc = None
            return False
        LOG.put((self.name, f"$ {' '.join(cmd)}\n[PID {self.proc.pid}]\n"))
        self.reader = threading.Thread(
            target=self._read_output, name=f"reader-{self.name}", daemon=True
        )
        self.reader.start()
        return True

    def _read_output(self) -> None:
        p = self.proc
        if p is None or p.stdout is None:
            return
        try:
            for line in p.stdout:
                LOG.put((self.name, line))
        except Exception as e:
            LOG.put((self.name, f"\n[读取输出异常] {e}\n"))
        finally:
            try:
                rc = p.wait(timeout=1)
                LOG.put((self.name, f"\n[进程退出 rc={rc}]\n"))
            except Exception:
                pass

    def stop(self, timeout: float = 5.0) -> None:
        p = self.proc
        if p is None or p.poll() is not None:
            return
        try:
            p.terminate()
        except OSError:
            pass
        try:
            p.wait(timeout=timeout)
        except subprocess.TimeoutExpired:
            try:
                p.kill()
                p.wait(timeout=2)
            except Exception:
                pass

    def signal_shutdown(self) -> None:
        """通过 UDP 发送优雅关闭信号给 time_watch 子进程。"""
        if self.name != "time_watch":
            return
        try:
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            s.sendto(b"SHUTDOWN", ("127.0.0.1", SHUTDOWN_PORT))
            s.close()
            LOG.put((self.name, "[已发送关闭信号，等待安全退出…]\n"))
        except Exception as e:
            LOG.put((self.name, f"[signal_shutdown] {e}\n"))

    def is_running(self) -> bool:
        return self.proc is not None and self.proc.poll() is None

    def status(self) -> str:
        if self.proc is None:
            return "未启动"
        if self.is_running():
            return f"运行中 ({self.proc.pid})"
        rc = self.proc.returncode
        return "已退出" if rc == 0 else "异常退出"


# ============================================================
# 工具函数
# ============================================================


def _enable_dpi_awareness() -> None:
    if sys.platform != "win32":
        return
    try:
        import ctypes

        ctypes.windll.shcore.SetProcessDpiAwareness(1)
    except Exception:
        try:
            import ctypes

            ctypes.windll.user32.SetProcessDPIAware()
        except Exception:
            pass


def _resolve_smtk() -> str | None:
    return shutil.which("smtk")


# ============================================================
# 主窗口
# ============================================================


class LauncherApp:
    def __init__(self, root: tk.Tk):
        self.root = root
        self.root.title(APP_TITLE)

        # 【极限固定尺寸】
        self.root.geometry("480x480")
        self.root.resizable(False, False)

        _apply_composited_fix(self.root)

        self.smtk_path: str | None = None
        self._path_warned = False
        self._last_trace = None
        self.current_trace_text = None
        self.current_path = ""

        self._last_statuses: dict[str, str] = {}
        self.is_topmost = False

        self._poll_status_id = None
        self._poll_trace_id = None
        self._drain_logs_id = None

        self.runners: dict[str, Runner] = {
            s["name"]: Runner(s["name"], s["label"], s["args"]) for s in COMMANDS
        }
        self.runners[CUSTOM_NAME] = Runner(CUSTOM_NAME, CUSTOM_LABEL)

        self.row_widgets: dict[str, dict] = {}
        self.log_views: dict[str, scrolledtext.ScrolledText] = {}
        self.log_buffer: dict[str, list[str]] = {}
        self.log_window: tk.Toplevel | None = None
        self.log_notebook: ttk.Notebook | None = None

        self.hud_card_widgets: dict | None = None
        self.mini_hud_widgets: dict | None = None
        self.mini_window: tk.Toplevel | None = None

        self.config = self._load_config()
        self.theme_name = self.config.get("theme", "light")
        self.opacity = self.config.get("opacity", 1.0)
        self.colors = THEMES[self.theme_name]

        self.root.configure(bg=self.colors["BG_MAIN"])
        self.root.attributes("-alpha", 1.0)

        self.custom_var = tk.StringVar()

        self._build_ui()
        self._restore_state()

        self.root.protocol("WM_DELETE_WINDOW", self._on_close)
        # 保存 after 返回值，便于退出时取消
        self._drain_logs_id = self.root.after(100, self._drain_logs)
        self._poll_trace_id = self.root.after(200, self._poll_trace)
        self._poll_status_id = self.root.after(500, self._poll_status)
        self.root.after(200, self._check_smtk_on_startup)
        self.root.after(150, lambda: self.root.attributes("-alpha", self.opacity))

        # 启动 UDP 监听用于单实例唤醒
        self._start_udp_listener()

    # ---------- 单实例唤醒 (UDP 通信) ----------
    def _start_udp_listener(self):
        def listen():
            s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            try:
                s.bind(("127.0.0.1", SINGLE_INSTANCE_PORT))
            except OSError:
                return

            while True:
                try:
                    data, _ = s.recvfrom(1024)
                    if data == b"WAKE_UP":
                        self.root.after(0, self._bring_to_front)
                except Exception:
                    break

        threading.Thread(target=listen, daemon=True).start()

    def _bring_to_front(self):
        # 如果悬浮窗开着，先关掉恢复主窗口
        if self.mini_window is not None and self.mini_window.winfo_exists():
            self._close_floating_view()

        # 纯 Tkinter 原生恢复，完美重绘客户区
        self.root.deiconify()
        self.root.lift()
        self.root.focus_force()

        # 临时置顶一下保证盖过其他窗口
        was_topmost = self.root.attributes("-topmost")
        self.root.attributes("-topmost", True)
        self.root.after(100, lambda: self.root.attributes("-topmost", was_topmost))

    # ---------- 配置 ----------
    def _load_config(self) -> dict:
        cfg = {"geometry": "", "custom_args": "", "theme": "light", "opacity": 1.0}
        try:
            if CONFIG_FILE.is_file():
                cfg.update(json.loads(CONFIG_FILE.read_text(encoding="utf-8")))
        except Exception:
            pass
        return cfg

    def _save_config(self) -> None:
        try:
            # 获取当前位置，强制固定宽高为 480x480
            x = self.root.winfo_x()
            y = self.root.winfo_y()
            sw = self.root.winfo_screenwidth()
            sh = self.root.winfo_screenheight()
            if 0 <= x < sw and 0 <= y < sh:
                self.config["geometry"] = f"480x480+{x}+{y}"
            self.config["custom_args"] = self.custom_var.get().strip()
            self.config["theme"] = self.theme_name
            self.config["opacity"] = self.opacity
            CONFIG_FILE.parent.mkdir(parents=True, exist_ok=True)
            CONFIG_FILE.write_text(
                json.dumps(self.config, ensure_ascii=False, indent=2), encoding="utf-8"
            )
        except Exception as e:
            if sys.stderr is not None:
                print(f"save config: {e}", file=sys.stderr)

    def _restore_state(self) -> None:
        if self.config.get("custom_args"):
            self.custom_var.set(self.config["custom_args"])

        # 提取历史保存的坐标位置
        geo = self.config.get("geometry")
        if geo:
            match = re.search(r"([+-]\d+[+-]\d+)$", geo)
            if match:
                # 强制宽高为 480x480，只应用坐标
                self.root.geometry(f"480x480{match.group(1)}")

    # ---------- 自定义扁平按钮 ----------
    def _create_button(self, parent, text, command, width=6, is_primary=False):
        c = self.colors
        if is_primary:
            bg, fg, abg = c["PRIMARY_BG"], c["PRIMARY_FG"], c["PRIMARY_HOVER"]
        else:
            bg, fg, abg = c["BG_HOVER"], c["FG_MAIN"], c["BG_HOVER"]
        return tk.Button(
            parent,
            text=text,
            command=command,
            width=width,
            font=("Microsoft YaHei", 8),
            bg=bg,
            fg=fg,
            activebackground=abg,
            activeforeground=fg,
            relief="flat",
            bd=0,
            cursor="hand2",
            pady=0,
        )

    # ---------- HUD 卡片构建（主窗口 / 悬浮窗共用）----------
    def _build_hud_card(self, parent, enable_path_click: bool = True) -> dict:
        c = self.colors

        card = tk.Frame(
            parent,
            bg=c["BG_PANEL"],
            highlightbackground=c["BORDER"],
            highlightthickness=1,
        )

        top_bar = tk.Frame(card, bg=c["BG_PANEL"])
        top_bar.pack(fill="x", padx=8, pady=(6, 2))

        lbl_type = tk.Label(
            top_bar,
            text="UNKNOWN",
            font=("Consolas", 8, "bold"),
            bg=c["TYPE_COLORS"]["UNKNOWN"],
            fg="#ffffff",
            padx=4,
            pady=1,
        )
        lbl_type.pack(side="left")

        right_data = tk.Frame(top_bar, bg=c["BG_PANEL"])
        right_data.pack(side="right")

        lbl_pos_val = tk.Label(
            right_data,
            text="-",
            font=("Consolas", 10),
            bg=c["BG_PANEL"],
            fg=c["FG_MAIN"],
        )
        lbl_pos_val.pack(side="right")
        tk.Label(
            right_data,
            text="POS:",
            font=("Consolas", 8, "bold"),
            bg=c["BG_PANEL"],
            fg=c["FG_DIM"],
        ).pack(side="right", padx=(0, 2))

        lbl_no_val = tk.Label(
            right_data,
            text="-",
            font=("Consolas", 11, "bold"),
            bg=c["BG_PANEL"],
            fg=c["ACCENT"],
        )
        lbl_no_val.pack(side="right", padx=(0, 8))
        tk.Label(
            right_data,
            text="NO.",
            font=("Consolas", 8, "bold"),
            bg=c["BG_PANEL"],
            fg=c["FG_DIM"],
        ).pack(side="right", padx=(0, 2))

        tk.Frame(card, height=1, bg=c["BORDER"]).pack(fill="x", padx=8)

        lbl_title = tk.Label(
            card,
            text="等待数据...",
            font=("Microsoft YaHei", 12, "bold"),
            bg=c["BG_PANEL"],
            fg=c["FG_MAIN"],
            justify="center",
            anchor="center",
        )
        lbl_title.pack(fill="both", expand=True, padx=8, pady=2)

        path_frame = tk.Frame(card, bg=c["BG_PANEL"])
        path_frame.pack(fill="x", side="bottom", padx=8, pady=(2, 6))

        tk.Label(
            path_frame,
            text=">_",
            font=("Consolas", 8, "bold"),
            bg=c["BG_PANEL"],
            fg=c["FG_DIM"],
        ).pack(side="left")

        # 仅当启用路径点击时才显示手型光标，避免悬浮窗中误导用户
        lbl_path = tk.Label(
            path_frame,
            text="",
            font=("Consolas", 8),
            bg=c["BG_PANEL"],
            fg=c["ACCENT"],
            cursor="hand2" if enable_path_click else "",
            anchor="w",
            justify="left",
        )
        lbl_path.pack(side="left", fill="x", expand=True, padx=(2, 0))
        if enable_path_click:
            lbl_path.bind("<Button-1>", self._on_path_clicked)

        widgets = {
            "card": card,
            "type": lbl_type,
            "no_val": lbl_no_val,
            "pos_val": lbl_pos_val,
            "title": lbl_title,
            "path": lbl_path,
        }

        def on_resize(event):
            w = event.width - 25
            if w > 100:
                widgets["title"].config(wraplength=w)
                widgets["path"].config(wraplength=w)

        card.bind("<Configure>", on_resize)

        return widgets

    # ---------- 核心 UI 构建 ----------
    def _build_ui(self) -> None:
        c = self.colors

        # 1. 底部固定按钮栏 (增加按钮宽度)
        bottom = tk.Frame(self.root, bg=c["BG_MAIN"], padx=3, pady=6)
        bottom.pack(side="bottom", fill="x")

        # 调整宽度以容纳 4 个中文字符（约等于 8~9 个英文字符宽）
        self._create_button(
            bottom, "全部启动", self._start_all, width=8, is_primary=True
        ).pack(side="left")
        self._create_button(bottom, "全部停止", self._stop_all, width=8).pack(
            side="left", padx=(4, 0)
        )
        self._create_button(bottom, "悬浮", self._toggle_floating_view, width=6).pack(
            side="left", padx=(4, 0)
        )

        theme_text = "🌙 暗色" if self.theme_name == "light" else "☀ 亮色"
        self._create_button(bottom, theme_text, self._toggle_theme, width=7).pack(
            side="left", padx=(4, 0)
        )

        topmost_text = "📌 置顶" if not self.is_topmost else "📌 取消置顶"
        self.btn_topmost = self._create_button(
            bottom, topmost_text, self._toggle_topmost, width=9
        )
        self.btn_topmost.pack(side="left", padx=(4, 0))

        opacity_text = f"🔮 {int(self.opacity * 100)}%"
        self.btn_opacity = self._create_button(
            bottom, opacity_text, self._toggle_opacity, width=7
        )
        self.btn_opacity.pack(side="left", padx=(4, 0))

        self._create_button(bottom, "日志", self._open_log_window, width=6).pack(
            side="right"
        )

        # 2. 顶部命令区
        body = tk.Frame(self.root, bg=c["BG_MAIN"], padx=6, pady=4)
        body.pack(side="top", fill="x")

        tk.Label(
            body,
            text="常驻命令",
            font=("Microsoft YaHei", 9, "bold"),
            bg=c["BG_MAIN"],
            fg=c["FG_MAIN"],
        ).pack(anchor="w", pady=(0, 2))

        for spec in COMMANDS:
            self._build_row(body, spec["name"], spec["label"], spec.get("help", ""))

        tk.Frame(body, height=1, bg=c["BORDER"]).pack(fill="x", pady=4)
        tk.Label(
            body,
            text="自定义命令",
            font=("Microsoft YaHei", 9, "bold"),
            bg=c["BG_MAIN"],
            fg=c["FG_MAIN"],
        ).pack(anchor="w", pady=(0, 2))

        custom_row = tk.Frame(body, bg=c["BG_MAIN"])
        custom_row.pack(fill="x")
        tk.Label(
            custom_row,
            text="参数",
            width=5,
            anchor="w",
            bg=c["BG_MAIN"],
            fg=c["FG_DIM"],
            font=("Microsoft YaHei", 8),
        ).pack(side="left")

        entry = tk.Entry(
            custom_row,
            textvariable=self.custom_var,
            bg=c["BG_PANEL"],
            fg=c["FG_MAIN"],
            insertbackground=c["FG_MAIN"],
            relief="flat",
            font=("Consolas", 9),
            highlightthickness=1,
            highlightbackground=c["BORDER"],
            highlightcolor=c["ACCENT"],
        )
        entry.pack(side="left", fill="x", expand=True, padx=(0, 4), ipady=0)
        self._create_button(
            custom_row, "运行", lambda: self._start(CUSTOM_NAME), width=5
        ).pack(side="left")

        # 3. 底部仪表盘区
        trace_frame = tk.Frame(self.root, bg=c["BG_MAIN"], padx=6, pady=4)
        trace_frame.pack(fill="both", expand=True)

        self.hud_card_widgets = self._build_hud_card(
            trace_frame, enable_path_click=True
        )
        self.hud_card_widgets["card"].pack(fill="both", expand=True)

    def _build_row(
        self, parent: tk.Frame, name: str, label: str, help_text: str
    ) -> None:
        c = self.colors
        row = tk.Frame(parent, bg=c["BG_MAIN"])
        row.pack(fill="x", pady=0)

        tk.Label(
            row,
            text=label,
            width=7,
            anchor="w",
            bg=c["BG_MAIN"],
            fg=c["FG_MAIN"],
            font=("Microsoft YaHei", 8, "bold"),
        ).pack(side="left")

        status_var = tk.StringVar(value="未启动")
        status_lbl = tk.Label(
            row,
            textvariable=status_var,
            width=11,
            anchor="w",
            bg=c["BG_MAIN"],
            fg=c["FG_DIM"],
            font=("Microsoft YaHei", 8),
        )
        status_lbl.pack(side="left", padx=(0, 2))

        if help_text:
            tk.Label(
                row,
                text=help_text,
                anchor="w",
                bg=c["BG_MAIN"],
                fg=c["FG_DIM"],
                font=("Microsoft YaHei", 7),
            ).pack(side="left", fill="x", expand=True)

        btn_frame = tk.Frame(row, bg=c["BG_MAIN"])
        btn_frame.pack(side="right")

        start_btn = self._create_button(
            btn_frame, "启动", lambda n=name: self._start(n), width=4
        )
        start_btn.pack(side="left", padx=(0, 2))
        stop_btn = self._create_button(
            btn_frame, "停止", lambda n=name: self._stop(n), width=4
        )
        stop_btn.pack(side="left", padx=(0, 2))
        self._create_button(
            btn_frame, "日志", lambda n=name: self._show_log(n), width=4
        ).pack(side="left")

        self.row_widgets[name] = {
            "status_var": status_var,
            "status_lbl": status_lbl,
            "start_btn": start_btn,
            "stop_btn": stop_btn,
        }

    # ---------- 主题切换与置顶/透明度 ----------
    def _toggle_theme(self) -> None:
        self.theme_name = "dark" if self.theme_name == "light" else "light"
        self.colors = THEMES[self.theme_name]

        if self.mini_window is not None and self.mini_window.winfo_exists():
            self._close_floating_view(restore_main=False)
        self.mini_window = None
        self.mini_hud_widgets = None
        self._close_log_window()

        self.root.configure(bg=self.colors["BG_MAIN"])
        self.root.attributes("-alpha", 1.0)
        for w in self.root.winfo_children():
            try:
                w.destroy()
            except Exception:
                pass

        self.hud_card_widgets = None
        self._build_ui()

        if self.is_topmost:
            self.root.attributes("-topmost", True)

        self._last_statuses.clear()

        # 优先用 pending 数据，避免"旧数据 → 新数据"跳变
        init_text = (
            self._last_trace
            if self._last_trace is not None
            else self.current_trace_text
        )
        if init_text:
            self._render_dashboard(init_text, force=True)
            if self._last_trace is not None:
                self._last_trace = None
        else:
            self._clear_trace_view()

        self._poll_status()
        self.root.after(100, lambda: self.root.attributes("-alpha", self.opacity))

    def _toggle_topmost(self) -> None:
        self.is_topmost = not self.is_topmost
        self.root.attributes("-topmost", self.is_topmost)
        self.btn_topmost.config(text="📌 取消置顶" if self.is_topmost else "📌 置顶")

    def _toggle_opacity(self) -> None:
        for threshold in (1.0, 0.8, 0.6, 0.4, 0.3):
            if self.opacity >= threshold:
                self.opacity = {1.0: 0.8, 0.8: 0.6, 0.6: 0.4, 0.4: 0.3, 0.3: 0.15}[
                    threshold
                ]
                break
        else:
            self.opacity = 1.0

        self.root.attributes("-alpha", self.opacity)
        if self.mini_window is not None and self.mini_window.winfo_exists():
            try:
                self.mini_window.attributes("-alpha", self.opacity)
            except Exception:
                pass
        self.btn_opacity.config(text=f"🔮 {int(self.opacity * 100)}%")

    # ---------- 悬浮视图 ----------
    def _toggle_floating_view(self) -> None:
        if self.mini_window is not None and self.mini_window.winfo_exists():
            self._close_floating_view()
        else:
            self._open_floating_view()

    def _open_floating_view(self) -> None:
        if self.mini_window is not None and self.mini_window.winfo_exists():
            return

        c = self.colors

        sw = self.root.winfo_screenwidth()
        sh = self.root.winfo_screenheight()

        try:
            rx = self.root.winfo_x()
            ry = self.root.winfo_y()
            if not (0 <= rx < sw and 0 <= ry < sh):
                raise ValueError("invalid root position")
        except Exception:
            rx, ry = max(0, (sw - 480) // 2), max(0, (sh - 480) // 2)

        x = max(0, min(rx + 20, sw - 420))
        y = max(0, min(ry + 20, sh - 160))

        win = FloatingWindow(
            self.root,
            geometry=f"400x130+{x}+{y}",
            opacity=self.opacity,
            bg=c["BORDER"],
        )

        container = tk.Frame(win, bg=c["BG_PANEL"], padx=2, pady=2)
        container.pack(fill="both", expand=True)

        hud = self._build_hud_card(container, enable_path_click=False)
        hud["card"].pack(fill="both", expand=True)

        self.mini_hud_widgets = hud
        self.mini_window = win

        # 拖动 + 双击检测
        drag = {
            "offset_x": 0,
            "offset_y": 0,
            "start_x": 0,
            "start_y": 0,
            "active": False,
            "moved": False,
        }
        last_click = {"t": 0.0, "x": 0, "y": 0}
        DRAG_THRESHOLD = 3
        DOUBLE_CLICK_INTERVAL = 0.35
        DOUBLE_CLICK_DISTANCE = 8

        def on_press(e):
            drag["offset_x"] = e.x_root - win.winfo_x()
            drag["offset_y"] = e.y_root - win.winfo_y()
            drag["start_x"] = e.x_root
            drag["start_y"] = e.y_root
            drag["moved"] = False
            drag["active"] = True

        def on_drag(e):
            if not drag["active"]:
                return
            if (
                abs(e.x_root - drag["start_x"]) > DRAG_THRESHOLD
                or abs(e.y_root - drag["start_y"]) > DRAG_THRESHOLD
            ):
                drag["moved"] = True
            if drag["moved"]:
                nx = max(-380, min(e.x_root - drag["offset_x"], sw - 20))
                ny = max(0, min(e.y_root - drag["offset_y"], sh - 20))
                win.geometry(f"+{nx}+{ny}")

        def on_release(e):
            if not drag["active"]:
                return
            drag["active"] = False
            if drag["moved"]:
                return

            now = time.monotonic()
            if (
                now - last_click["t"] < DOUBLE_CLICK_INTERVAL
                and abs(e.x_root - last_click["x"]) < DOUBLE_CLICK_DISTANCE
                and abs(e.y_root - last_click["y"]) < DOUBLE_CLICK_DISTANCE
            ):
                last_click["t"] = 0.0
                self._close_floating_view()
            else:
                last_click["t"] = now
                last_click["x"] = e.x_root
                last_click["y"] = e.y_root

        win.bind("<ButtonPress-1>", on_press)
        win.bind("<B1-Motion>", on_drag)
        win.bind("<ButtonRelease-1>", on_release)

        # ============ 右键菜单（含监听控制）============
        START_LBL = "▶ 开始监听"
        STOP_LBL = "■ 停止监听"

        menu = tk.Menu(win, tearoff=0)

        def refresh_menu_state() -> None:
            """在菜单弹出前动态刷新监听/停止按钮的可用性。"""
            running = self.runners["trace_mem"].is_running()
            try:
                menu.entryconfig(START_LBL, state="disabled" if running else "normal")
                menu.entryconfig(STOP_LBL, state="normal" if running else "disabled")
            except tk.TclError:
                pass

        menu.add_command(label=START_LBL, command=self._mini_start_trace)
        menu.add_command(label=STOP_LBL, command=self._mini_stop_trace)
        menu.add_separator()
        menu.add_command(label="恢复主窗口", command=self._close_floating_view)
        menu.add_separator()
        menu.add_command(label="退出", command=self._on_close)
        menu.configure(postcommand=refresh_menu_state)

        def show_menu(e):
            try:
                menu.tk_popup(e.x_root, e.y_root)
            finally:
                menu.grab_release()

        win.bind("<Button-3>", show_menu)

        # 优先 pending 数据；若 pending 无效（如 $ 开头的命令行回显），
        # 用已渲染数据兜底，保证悬浮窗立即显示正确内容
        if self._last_trace is not None:
            self._render_dashboard(self._last_trace, force=True)
            self._last_trace = None
        if self.current_trace_text:
            self._render_dashboard(self.current_trace_text, force=True)

        self.root.withdraw()

    def _mini_start_trace(self) -> None:
        """悬浮窗：启动内存追踪。"""
        path = self._ensure_smtk(parent=self.mini_window or self.root)
        if path is None:
            return
        runner = self.runners["trace_mem"]
        if runner.is_running():
            return
        self._clear_trace_view()
        if not runner.start(path):
            messagebox.showerror(
                "启动失败",
                "无法启动 smtk trace --mem。\n请打开日志窗口查看详细信息。",
                parent=self.mini_window or self.root,
            )

    def _mini_stop_trace(self) -> None:
        """悬浮窗：停止内存追踪（保留最后显示的内容）。"""
        runner = self.runners["trace_mem"]
        if runner.is_running():
            runner.stop()

    def _close_floating_view(self, restore_main: bool = True) -> None:
        if self.mini_window is not None:
            try:
                self.mini_window.destroy()
            except Exception:
                pass
        self.mini_window = None
        self.mini_hud_widgets = None
        if restore_main:
            try:
                self.root.deiconify()
                self.root.lift()
            except Exception:
                pass

    # ---------- 状态更新 ----------
    def _poll_status(self) -> None:
        if self._poll_status_id is not None:
            try:
                self.root.after_cancel(self._poll_status_id)
            except Exception:
                pass
            self._poll_status_id = None

        for name, runner in self.runners.items():
            widgets = self.row_widgets.get(name)
            if widgets is None:
                continue

            running = runner.is_running()
            current_status = runner.status()

            if self._last_statuses.get(name) != current_status:
                self._last_statuses[name] = current_status
                widgets["status_var"].set(current_status)

                if running:
                    widgets["status_lbl"].config(fg=self.colors["STATUS_RUNNING"])
                    widgets["start_btn"].config(state="disabled")
                    widgets["stop_btn"].config(state="normal")
                else:
                    widgets["status_lbl"].config(fg=self.colors["FG_DIM"])
                    widgets["start_btn"].config(state="normal")
                    widgets["stop_btn"].config(state="disabled")

        self._poll_status_id = self.root.after(500, self._poll_status)

    # ---------- 操作逻辑 ----------
    def _check_smtk_on_startup(self) -> None:
        self.smtk_path = _resolve_smtk()
        if self.smtk_path is None:
            messagebox.showerror(
                "找不到 smtk",
                "PATH 中未找到 `smtk` 可执行文件。\n请确认 smtk 安装目录已加入系统 PATH。",
            )

    def _ensure_smtk(self, parent=None) -> str | None:
        if self.smtk_path is None:
            self.smtk_path = _resolve_smtk()
        if self.smtk_path is None:
            messagebox.showerror(
                "找不到 smtk",
                "请确认 smtk 已在 PATH 中。",
                parent=parent or self.root,
            )
            return None
        return self.smtk_path

    def _start(self, name: str) -> None:
        path = self._ensure_smtk()
        if path is None:
            return
        runner = self.runners[name]
        if name == CUSTOM_NAME:
            text = self.custom_var.get().strip()
            if not text:
                messagebox.showinfo("自定义命令", "请输入命令参数，例如 time list")
                return
            try:
                runner.args = shlex.split(text)
            except ValueError as e:
                messagebox.showerror("参数错误", str(e))
                return
            runner.stop()
        elif name == "trace_mem":
            self._clear_trace_view()

        runner.start(path)

    def _stop(self, name: str) -> None:
        runner = self.runners[name]
        if not runner.is_running():
            return

        if name == "time_watch":
            if not messagebox.askyesno(
                "停止托盘备份",
                "将发送关闭信号，等待正在进行的备份完成后安全退出。\n"
                "超时（5 分钟）后会强制终止。\n\n继续安全关闭？",
            ):
                return
            # 发 UDP 信号，让 Watcher 自己优雅退出
            runner.signal_shutdown()

            # 后台线程等待进程退出，超时强杀
            def _wait_and_force():
                try:
                    runner.proc.wait(timeout=310)
                except subprocess.TimeoutExpired:
                    LOG.put((name, "[超时] 关闭超时，强制终止\n"))
                    runner.stop(timeout=10)

            threading.Thread(
                target=_wait_and_force,
                name=f"wait-{name}",
                daemon=True,
            ).start()
            return

        self.runners[name].stop()

    def _start_all(self) -> None:
        path = self._ensure_smtk()
        if path is None:
            return
        for name, runner in self.runners.items():
            if name == CUSTOM_NAME:
                continue
            if not runner.is_running():
                if name == "trace_mem":
                    self._clear_trace_view()
                runner.start(path)

    def _stop_all(self) -> None:
        tw = self.runners.get("time_watch")

        for name, runner in self.runners.items():
            if not runner.is_running():
                continue
            if name == "time_watch":
                # UDP信号 + 后台等待，不弹确认框
                runner.signal_shutdown()
            else:
                runner.stop()

        # 后台等 time_watch 优雅退出
        if tw is not None and tw.is_running():

            def _wait_tw():
                try:
                    tw.proc.wait(timeout=310)
                except subprocess.TimeoutExpired:
                    tw.stop(timeout=10)

            threading.Thread(target=_wait_tw, daemon=True).start()

    def _clear_trace_view(self) -> None:
        self._last_trace = None
        self.current_trace_text = None
        self.current_path = ""
        color = self.colors["TYPE_COLORS"]["UNKNOWN"]
        for hud in (self.hud_card_widgets, self.mini_hud_widgets):
            if hud is None:
                continue
            try:
                hud["no_val"].config(text="-")
                hud["pos_val"].config(text="-")
                hud["type"].config(text="UNKNOWN", bg=color)
                hud["title"].config(text="等待数据...")
                hud["path"].config(text="")
            except tk.TclError:
                pass

    def _on_path_clicked(self, event) -> None:
        if not self.current_path:
            return
        try:
            os.startfile(self.current_path)
        except Exception as e:
            messagebox.showerror(
                "打开失败", f"无法打开:\n{self.current_path}\n\n错误: {e}"
            )

    # ---------- 日志与仪表盘渲染 ----------
    def _drain_logs(self) -> None:
        if self._drain_logs_id is not None:
            try:
                self.root.after_cancel(self._drain_logs_id)
            except Exception:
                pass
            self._drain_logs_id = None

        try:
            while True:
                name, text = LOG.get_nowait()
                buf = self.log_buffer.setdefault(name, [])
                buf.append(text)
                if len(buf) > 2000:
                    del buf[: len(buf) - 2000]

                view = self.log_views.get(name)
                if view is not None:
                    try:
                        view.configure(state="normal")
                        view.insert("end", text)
                        view.see("end")
                        view.configure(state="disabled")
                    except tk.TclError:
                        pass

                if name == "trace_mem":
                    self._last_trace = text
        except queue.Empty:
            pass
        except Exception as e:
            if sys.stderr is not None:
                print(f"[日志刷新异常] {e}", file=sys.stderr)

        self._drain_logs_id = self.root.after(100, self._drain_logs)

    def _poll_trace(self) -> None:
        if self._poll_trace_id is not None:
            try:
                self.root.after_cancel(self._poll_trace_id)
            except Exception:
                pass
            self._poll_trace_id = None

        if self._last_trace is not None:
            self._render_dashboard(self._last_trace)
            self._last_trace = None

        self._poll_trace_id = self.root.after(200, self._poll_trace)

    def _render_dashboard(self, text: str, force: bool = False) -> None:
        text = text.replace("\r\n", "\n").replace("\r", "\n").strip()
        if not text or text.startswith("$"):
            return
        if text == self.current_trace_text and not force:
            return
        self.current_trace_text = text

        m_no = re.search(r"\[No\.\s*(\d+)\]", text)
        m_type = re.search(r"\[Type:\s*([A-Z_]+)\]", text)
        m_title = re.search(r"\[Title:\s*(.*?)\]", text)
        m_pos = re.search(r"\[Position:\s*(\d+)\]", text)
        m_path = re.search(r"\[Path:\s*(.*?)(?:\s*\(file:///.*?\))?\]", text)

        no_str = m_no.group(1) if m_no else "-"
        pos_str = m_pos.group(1) if m_pos else "-"
        type_str = m_type.group(1) if m_type else "UNKNOWN"
        color = self.colors["TYPE_COLORS"].get(
            type_str, self.colors["TYPE_COLORS"]["UNKNOWN"]
        )
        title_str = m_title.group(1) if m_title else "无标题"
        path_str = m_path.group(1).strip() if m_path else ""
        self.current_path = path_str

        for hud in (self.hud_card_widgets, self.mini_hud_widgets):
            if hud is None:
                continue
            self._apply_trace_to_hud(
                hud, no_str, pos_str, type_str, color, title_str, path_str
            )

    def _apply_trace_to_hud(
        self, hud: dict, no_str, pos_str, type_str, color, title_str, path_str
    ) -> None:
        try:
            if hud["no_val"].cget("text") != no_str:
                hud["no_val"].config(text=no_str)
            if hud["pos_val"].cget("text") != pos_str:
                hud["pos_val"].config(text=pos_str)
            if hud["type"].cget("text") != type_str or hud["type"].cget("bg") != color:
                hud["type"].config(text=type_str, bg=color)
            if hud["title"].cget("text") != title_str:
                hud["title"].config(text=title_str)
            if hud["path"].cget("text") != path_str:
                hud["path"].config(text=path_str)
        except tk.TclError:
            pass

    # ---------- 日志窗口 ----------
    def _open_log_window(self, focus: str | None = None) -> None:
        if self.log_window is not None and self.log_window.winfo_exists():
            self.log_window.lift()
            if focus and self.log_notebook is not None:
                idx = list(self.runners.keys()).index(focus)
                self.log_notebook.select(idx)
            return

        c = self.colors
        win = tk.Toplevel(self.root)
        win.title("smtk 命令日志")
        win.geometry("650x350")
        win.configure(bg=c["BG_MAIN"])
        self.log_window = win

        nb = ttk.Notebook(win)
        nb.pack(fill="both", expand=True, padx=8, pady=8)
        self.log_notebook = nb

        for name, runner in self.runners.items():
            frame = tk.Frame(nb, bg=c["BG_MAIN"])
            nb.add(frame, text=runner.label)
            view = scrolledtext.ScrolledText(
                frame,
                wrap="word",
                state="disabled",
                font=("Consolas", 9),
                bg=c["BG_PANEL"],
                fg=c["FG_MAIN"],
                insertbackground=c["FG_MAIN"],
            )
            view.pack(fill="both", expand=True)
            for text in self.log_buffer.get(name, []):
                view.configure(state="normal")
                view.insert("end", text)
                view.configure(state="disabled")
            self.log_views[name] = view

        if focus:
            idx = list(self.runners.keys()).index(focus)
            nb.select(idx)

        win.protocol("WM_DELETE_WINDOW", self._close_log_window)

    def _close_log_window(self) -> None:
        if self.log_window is not None:
            try:
                self.log_window.destroy()
            except Exception:
                pass
        self.log_window = None
        self.log_notebook = None
        self.log_views.clear()

    def _show_log(self, name: str) -> None:
        self._open_log_window(focus=name)

    # ---------- 退出 ----------
    def _on_close(self) -> None:
        was_mini = self.mini_window is not None and self.mini_window.winfo_exists()
        parent = self.mini_window if was_mini else self.root

        running = [r.label for r in self.runners.values() if r.is_running()]
        if running:
            msg = "以下命令仍在运行：\n  " + "\n  ".join(running) + "\n\n停止并退出？"
            try:
                resp = messagebox.askyesno("确认退出", msg, parent=parent)
            except tk.TclError:
                resp = messagebox.askyesno("确认退出", msg, parent=self.root)
            if not resp:
                return
            # time_watch 走 UDP 信号，其余直接 stop
            tw = self.runners.get("time_watch")
            for name, r in self.runners.items():
                if r.is_running():
                    if name == "time_watch":
                        r.signal_shutdown()
                    else:
                        r.stop()
            # 后台等 time_watch 优雅退出
            if tw is not None and tw.is_running():

                def _wait_tw():
                    try:
                        tw.proc.wait(timeout=310)
                    except subprocess.TimeoutExpired:
                        tw.stop(timeout=10)

                threading.Thread(target=_wait_tw, daemon=True).start()

        for attr in ("_poll_status_id", "_poll_trace_id", "_drain_logs_id"):
            aid = getattr(self, attr, None)
            if aid is not None:
                try:
                    self.root.after_cancel(aid)
                except Exception:
                    pass
                setattr(self, attr, None)

        self._save_config()
        if self.mini_window is not None:
            try:
                self.mini_window.destroy()
            except Exception:
                pass
            self.mini_window = None
        self.root.destroy()


def main() -> None:
    _enable_dpi_awareness()
    if not _ensure_single_instance():
        sys.exit(0)
    root = tk.Tk()
    LauncherApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()

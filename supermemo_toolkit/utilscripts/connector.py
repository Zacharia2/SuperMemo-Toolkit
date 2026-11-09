"""SuperMemo 连接器（全局单例）。

职责：只负责与 TElWind 建立/维护连接，并一次性缓存进程信息。
不弹窗、不重试、不做业务判断；所有失败通过 last_error / 返回值暴露。

语义速查：
  supermemo.snapshot             只读缓存，绝不重连（廉价，循环里用）
  supermemo.ensure_snapshot()    必要时重连一次，返回最新快照（昂贵）
  supermemo.refresh()            强制丢弃缓存后重连
  supermemo.wait_until_running() 阻塞等待启动，支持 stop_event / stop_check
  supermemo.identity             (pid, process_start_ts)，判缓存有效性的唯一依据
"""

from __future__ import annotations

import os
import threading
import time
import warnings
from dataclasses import dataclass

import pywintypes
import win32api
import win32con
import win32gui
import win32process
from pywinauto.application import Application
from pywinauto.findwindows import ElementNotFoundError

warnings.filterwarnings("ignore", message=".*32-bit application should be automated.*")


class SuperMemoNotAvailable(RuntimeError):
    """SuperMemo 进程未启动或不可连接。"""


def get_file_string_info(path, key):
    try:
        translations = win32api.GetFileVersionInfo(path, r"\VarFileInfo\Translation")
        lang, codepage = translations[0]
        sub_block = f"\\StringFileInfo\\{lang:04x}{codepage:04x}\\{key}"
        file_description: str = win32api.GetFileVersionInfo(path, sub_block)
        return file_description.strip().lower()
    except Exception:  # noqa: BLE001
        return None


def compute_sm_ver(file_path):
    product_version = get_file_string_info(file_path, "ProductVersion")
    file_version = get_file_string_info(file_path, "FileVersion")
    file_description = get_file_string_info(file_path, "FileDescription")
    # 15 FileVersionInfo = None
    # 16 ProductVersion = 1.0.0.0、 FileVersion = 1.0.0.0 仅两项。
    if product_version is None and file_version is None and file_description is None:
        return "sm15"
    if (
        product_version == "1.0.0.0"
        and file_version == "1.0.0.0"
        and file_description is None
    ):
        return "sm16"
    if product_version == "17.0":
        if (
            get_file_string_info(file_path, "OriginalFilename") == "sm17.exe"
            and file_version == "17.0.0.0"
            and file_description is None
        ):
            return "sm17"
        if (
            get_file_string_info(file_path, "OriginalFilename") == "sm17.exe"
            and file_version == "17.0.0.0"
            and file_description == "sm18"
        ):
            return "sm18"
    if (
        product_version == "19.0"
        and file_version == "19.0.0.0"
        and file_description == "sm19"
    ):
        return "sm19"

    # 默认情况sm20及最新版本
    return file_description


@dataclass(frozen=True)
class SuperMemoSnapshot:
    """一次成功连接得到的全部信息。不可变、跨线程安全。

    判断「是否同一进程实例」靠 (pid, process_start_ts)：
      - 同 PID 重启 → process_start_ts 必变
      - 不重启但 refresh() → 两者不变（缓存仍有效）
    """

    app: Application
    pid: int
    process_name: str
    exe_path: str
    bitness: int
    sm_ver: str
    telwind_hwnd: int
    process_start_ts: float

    @property
    def identity(self) -> tuple[int, float]:
        return (self.pid, self.process_start_ts)


class SuperMemoConnector:
    _instance: SuperMemoConnector | None = None
    _instance_lock = threading.Lock()

    def __new__(cls):
        if cls._instance is None:
            with cls._instance_lock:
                if cls._instance is None:
                    inst = super().__new__(cls)
                    inst._initialized = False
                    cls._instance = inst
        return cls._instance

    def __init__(self):
        if getattr(self, "_initialized", False):
            return
        with self._instance_lock:
            if getattr(self, "_initialized", False):
                return
            self._mutex = threading.RLock()
            self._snapshot: SuperMemoSnapshot | None = None
            self._last_error: BaseException | None = None
            self._initialized = True

    # ------------------------------------------------------------------
    # 快照获取
    # ------------------------------------------------------------------
    @property
    def snapshot(self) -> SuperMemoSnapshot | None:
        """只读缓存。进程死/窗口销毁/从未连接 → None。绝不重连。"""
        snap = self._snapshot
        if snap is None:
            return None
        if not self._snapshot_alive(snap):
            return None
        return snap

    def ensure_snapshot(self) -> SuperMemoSnapshot | None:
        """必要时重连一次，返回最新快照。初始化 / 按钮点击用。

        Bug B 修复：_do_connect 成功后再次走 snapshot 属性做一次 liveness 检查，
        避免在「刚连上即退出」的微窗口期返回已失效的 snapshot。
        """
        with self._mutex:
            snap = self.snapshot
            if snap is not None:
                return snap
            if self._do_connect():
                return self.snapshot  # ← 二次检查
            return None

    @property
    def identity(self) -> tuple[int, float] | None:
        """缓存的身份指纹。进程死 → None。用 snapshot（会 liveness 检查）。"""
        s = self.snapshot
        return s.identity if s else None

    @property
    def last_error(self) -> BaseException | None:
        return self._last_error

    # ------------------------------------------------------------------
    # 常用字段
    # ------------------------------------------------------------------
    @property
    def app(self) -> Application | None:
        s = self.snapshot
        return s.app if s else None

    @property
    def pid(self) -> int | None:
        s = self.snapshot
        return s.pid if s else None

    @property
    def process_name(self) -> str | None:
        s = self.snapshot
        return s.process_name if s else None

    @property
    def exe_path(self) -> str | None:
        s = self.snapshot
        return s.exe_path if s else None

    @property
    def bitness(self) -> int | None:
        s = self.snapshot
        return s.bitness if s else None

    @property
    def sm_ver(self) -> str | None:
        s = self.snapshot
        return s.sm_ver if s else None

    @property
    def telwind_hwnd(self) -> int | None:
        s = self.snapshot
        return s.telwind_hwnd if s else None

    @property
    def process_start_ts(self) -> float | None:
        s = self.snapshot
        return s.process_start_ts if s else None

    # ------------------------------------------------------------------
    # 状态判定 / 连接控制
    # ------------------------------------------------------------------

    def refresh(self, raise_on_error: bool = False) -> bool:
        with self._mutex:
            self._snapshot = None
            return self._do_connect(raise_on_error=raise_on_error)

    def wait_until_running(
        self,
        poll_interval: float = 2.0,
        stop_check=None,
        stop_event: threading.Event | None = None,
    ) -> bool:
        """阻塞直到 SuperMemo 启动，或收到停止信号。

        每次循环都检查 stop_check / stop_event，保证
        后台线程能被 stop_trace() 立即唤醒，不会卡在 sleep(2)。
        """
        while True:
            if self.ensure_snapshot():
                return True
            if stop_check is not None and stop_check():
                return False
            if stop_event is not None:
                if stop_event.wait(poll_interval):
                    return False
            else:
                time.sleep(poll_interval)

    # ------------------------------------------------------------------
    # 便捷方法
    # ------------------------------------------------------------------
    def window_text(self) -> str:
        """读取 TElWind 窗口标题。廉价（GetWindowText）。"""
        s = self.snapshot
        if s is None:
            return ""
        try:
            return win32gui.GetWindowText(s.telwind_hwnd)
        except Exception:
            return ""

    # ------------------------------------------------------------------
    # 内部
    # ------------------------------------------------------------------
    @staticmethod
    def _snapshot_alive(snap: SuperMemoSnapshot) -> bool:
        try:
            if not snap.app.is_process_running():
                return False
        except Exception:
            return False
        try:
            return bool(win32gui.IsWindow(snap.telwind_hwnd))
        except Exception:
            return False

    def _do_connect(self, raise_on_error: bool = False) -> bool:
        """仅在 _mutex 内调用。成功则写入 self._snapshot。"""
        self._last_error = None
        try:
            app = Application(backend="win32").connect(
                class_name="TElWind", visible_only=False
            )
            pid = app.process
            h = win32api.OpenProcess(
                win32con.PROCESS_QUERY_INFORMATION | win32con.PROCESS_VM_READ,
                False,
                pid,
            )
            try:
                file_path = win32process.GetModuleFileNameEx(h, 0)
                if not file_path or not os.path.isfile(file_path):
                    raise RuntimeError(
                        f"无法获取有效的 SuperMemo 可执行文件路径（pid={pid}）"
                    )
                start_ts = win32process.GetProcessTimes(h)["CreationTime"].timestamp()
            finally:
                win32api.CloseHandle(h)

            telwind_hwnd = app.window(class_name="TElWind").handle
            bitness = 64 if app.is64bit() else 32
            sm_ver = compute_sm_ver(file_path)

            self._snapshot = SuperMemoSnapshot(
                app=app,
                pid=pid,
                process_name=os.path.basename(file_path),
                exe_path=file_path,
                bitness=bitness,
                sm_ver=sm_ver,
                telwind_hwnd=telwind_hwnd,
                process_start_ts=start_ts,
            )
            return True

        except pywintypes.error as e:
            if e.winerror == 5:
                self._last_error = PermissionError(
                    "无法访问 SuperMemo 进程（可能以管理员运行）。"
                    "请尝试以管理员身份启动本工具。"
                )
            else:
                self._last_error = e
            self._snapshot = None
            if raise_on_error:
                raise self._last_error
            return False

        except ElementNotFoundError as e:
            self._last_error = e
            self._snapshot = None
            if raise_on_error:
                raise
            return False

        except Exception as e:
            self._last_error = e
            self._snapshot = None
            if raise_on_error:
                raise
            return False


supermemo = SuperMemoConnector()

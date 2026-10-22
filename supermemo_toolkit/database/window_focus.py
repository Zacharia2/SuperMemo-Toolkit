import atexit
import ctypes
import threading
import time
from ctypes import wintypes

import win32api
import win32con
import win32gui
import win32process

# ---------- ctypes 前置声明 ----------
_user32 = ctypes.WinDLL("user32", use_last_error=True)
_kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)

_HKPROC = ctypes.WINFUNCTYPE(
    wintypes.LPARAM, ctypes.c_int, wintypes.WPARAM, wintypes.LPARAM
)

_user32.SetWindowsHookExW.argtypes = [
    ctypes.c_int,
    ctypes.c_void_p,
    wintypes.HINSTANCE,
    wintypes.DWORD,
]
_user32.SetWindowsHookExW.restype = wintypes.HHOOK
_user32.UnhookWindowsHookEx.argtypes = [wintypes.HHOOK]
_user32.CallNextHookEx.argtypes = [
    wintypes.HHOOK,
    ctypes.c_int,
    wintypes.WPARAM,
    wintypes.LPARAM,
]
_user32.CallNextHookEx.restype = wintypes.LPARAM
_user32.GetMessageW.argtypes = [
    ctypes.c_void_p,
    wintypes.HWND,
    ctypes.c_uint,
    ctypes.c_uint,
]
_user32.GetMessageW.restype = wintypes.BOOL
_user32.TranslateMessage.argtypes = [ctypes.c_void_p]
_user32.TranslateMessage.restype = wintypes.BOOL
_user32.DispatchMessageW.argtypes = [ctypes.c_void_p]
_user32.DispatchMessageW.restype = wintypes.LPARAM
_user32.AllowSetForegroundWindow.argtypes = [ctypes.c_int]
_user32.AllowSetForegroundWindow.restype = wintypes.BOOL
_user32.PostThreadMessageW.argtypes = [
    wintypes.DWORD,
    ctypes.c_uint,
    wintypes.WPARAM,
    wintypes.LPARAM,
]
_user32.PostThreadMessageW.restype = wintypes.BOOL
_user32.SwitchToThisWindow.argtypes = [wintypes.HWND, wintypes.BOOL]
_user32.SwitchToThisWindow.restype = None
_user32.SendInput.argtypes = [ctypes.c_uint, ctypes.c_void_p, ctypes.c_int]
_user32.SendInput.restype = ctypes.c_uint

WH_KEYBOARD_LL = 13
WM_QUIT = 0x0012
ASFW_ANY = -1
_INPUT_KEYBOARD = 1
KEYEVENTF_KEYUP = 0x0002

# ULONG_PTR 是平台相关的，wintypes 没有直接提供
ULONG_PTR = (
    ctypes.c_ulong if ctypes.sizeof(ctypes.c_void_p) == 4 else ctypes.c_ulonglong
)


# ---------- SendInput 结构体 ----------
class _MOUSEINPUT(ctypes.Structure):
    _fields_ = [
        ("dx", wintypes.LONG),
        ("dy", wintypes.LONG),
        ("mouseData", wintypes.DWORD),
        ("dwFlags", wintypes.DWORD),
        ("time", wintypes.DWORD),
        ("dwExtraInfo", ULONG_PTR),
    ]


class _HARDWAREINPUT(ctypes.Structure):
    _fields_ = [
        ("uMsg", wintypes.DWORD),
        ("wParamL", wintypes.WORD),
        ("wParamH", wintypes.WORD),
    ]


class _KEYBDINPUT(ctypes.Structure):
    _fields_ = [
        ("wVk", wintypes.WORD),
        ("wScan", wintypes.WORD),
        ("dwFlags", wintypes.DWORD),
        ("time", wintypes.DWORD),
        ("dwExtraInfo", ULONG_PTR),
    ]


class _INPUT_UNION(ctypes.Union):
    _fields_ = [("ki", _KEYBDINPUT), ("mi", _MOUSEINPUT), ("hi", _HARDWAREINPUT)]


class _INPUT(ctypes.Structure):
    _fields_ = [("type", wintypes.DWORD), ("u", _INPUT_UNION)]


# ---------- MapVirtualKeyW（VK -> 扫描码） ----------
_user32.MapVirtualKeyW.argtypes = [wintypes.UINT, wintypes.UINT]
_user32.MapVirtualKeyW.restype = wintypes.UINT

MAPVK_VK_TO_VSC = 0


def _key_input(vk: int, up: bool = False) -> _INPUT:
    """构造单个键盘 INPUT。

    同时填 wVk 和 wScan：
      - 不设 KEYEVENTF_SCANCODE，系统优先用 wVk；wScan 作为兜底，
        某些 VCL/Delphi 路径会直接读扫描码。
      - wVk 与 wScan 均为 0 时才是"纯扫描码模式"，这里不用。
    """
    inp = _INPUT()
    inp.type = _INPUT_KEYBOARD
    inp.u.ki.wVk = vk
    inp.u.ki.wScan = _user32.MapVirtualKeyW(vk, MAPVK_VK_TO_VSC)
    inp.u.ki.dwFlags = KEYEVENTF_KEYUP if up else 0
    inp.u.ki.time = 0
    inp.u.ki.dwExtraInfo = 0
    return inp


def _send_inputs(inputs: list[_INPUT]) -> bool:
    """统一投递键盘 INPUT 序列。

    cbSize 必须是单个 INPUT 的大小（Win32 约定），
    不是整个数组的字节数——否则 SendInput 立刻返回 87。
    """
    n = len(inputs)
    if n == 0:
        return True
    arr = (_INPUT * n)(*inputs)
    sent = _user32.SendInput(
        n,
        ctypes.byref(arr),
        ctypes.sizeof(_INPUT),  # ← 关键：单个结构体大小
    )
    return sent == n


def _send_alt() -> bool:
    """原子化 Alt 点击；返回 True 表示输入被接受。"""
    return _send_inputs(
        [
            _key_input(0x12),  # VK_MENU down
            _key_input(0x12, up=True),  # VK_MENU up
        ]
    )


def send_vk(
    vk: int, *, ctrl: bool = False, shift: bool = False, alt: bool = False
) -> bool:
    """SendInput 发送单键 + 修饰键组合。调用前需确保目标窗口在前台。"""
    mods: list[int] = []
    if ctrl:
        mods.append(0x11)  # VK_CONTROL
    if shift:
        mods.append(0x10)  # VK_SHIFT
    if alt:
        mods.append(0x12)  # VK_MENU

    seq: list[_INPUT] = [_key_input(m) for m in mods]
    seq.append(_key_input(vk))
    seq.append(_key_input(vk, up=True))
    seq.extend(_key_input(m, up=True) for m in reversed(mods))
    return _send_inputs(seq)


# ---------- 钩子管理器 ----------
class _ForegroundHook:
    def __init__(self, idle_ttl=0.5):
        self._lock = threading.RLock()
        self._refs = 0
        self._hhk = None
        self._proc = _HKPROC(self._callback)  # 一次性创建，永不重建
        self._tid = None
        self._thread = None
        self._ok = False
        self._idle_ttl = idle_ttl
        self._timer = None

    def _run(self):
        self._tid = _kernel32.GetCurrentThreadId()
        hhk = _user32.SetWindowsHookExW(WH_KEYBOARD_LL, self._proc, None, 0)
        if not hhk:
            return
        with self._lock:
            if not self._ok:  # acquire 已超时回滚 → 自裁
                _user32.UnhookWindowsHookEx(hhk)
                return
            self._hhk = hhk
        msg = wintypes.MSG()
        while True:
            if _user32.GetMessageW(ctypes.byref(msg), None, 0, 0) <= 0:
                break
            _user32.TranslateMessage(ctypes.byref(msg))
            _user32.DispatchMessageW(ctypes.byref(msg))

    @staticmethod
    def _callback(code, wParam, lParam):
        return _user32.CallNextHookEx(None, code, wParam, lParam)

    def _cancel_timer(self):
        if self._timer is not None:
            self._timer.cancel()
            self._timer = None

    def _do_release(self):
        """锁内改状态，锁外做系统调用。"""
        with self._lock:
            if self._refs != 0 or not self._ok:
                return
            self._timer = None
            self._ok = False
            hhk, self._hhk = self._hhk, None
            tid = self._tid
        if tid:
            try:
                _user32.PostThreadMessageW(tid, WM_QUIT, 0, 0)
            except Exception:
                pass
        if hhk:
            _user32.UnhookWindowsHookEx(hhk)

    def acquire(self) -> bool:
        with self._lock:
            self._refs += 1
            if self._refs == 1:
                self._cancel_timer()
                # 旧线程还活着且钩子有效 → 直接复用，不起新线程
                if self._hhk and self._thread and self._thread.is_alive():
                    return True
                self._ok = True
                self._thread = threading.Thread(target=self._run, daemon=True)
                self._thread.start()
                deadline = time.perf_counter() + 0.3
                while self._hhk is None and time.perf_counter() < deadline:
                    time.sleep(0.005)
                if not self._hhk:
                    self._ok = False
                    self._refs = 0
                    return False
            return bool(self._hhk)

    def release(self):
        with self._lock:
            if self._refs == 0:
                return
            self._refs -= 1
            if self._refs == 0 and self._ok:
                if self._idle_ttl > 0:
                    self._timer = threading.Timer(self._idle_ttl, self._do_release)
                    self._timer.daemon = True
                    self._timer.start()
                else:
                    self._do_release()

    def force_release(self):
        with self._lock:
            self._refs = 0
            self._cancel_timer()
        self._do_release()  # 锁外调用，避免 Unhook 阻塞持锁


_HOOK = _ForegroundHook()
atexit.register(_HOOK.force_release)


# ---------- 主函数 ----------
def _try_set_foreground(hwnd):
    try:
        win32gui.SetForegroundWindow(hwnd)
        return win32gui.GetForegroundWindow() == hwnd
    except Exception:
        return False


def activate_window(hwnd, fast_only=False):
    """
    模拟 AHK WinActivate：短时钩子 + 多重降级。
    fast_only=True 跳过钩子与 Alt 技巧，仅做重试 + SwitchToThisWindow。

    一票否决：
      - 目标调用了 LockSetForegroundWindow（极少见）
      - 目标进程以管理员运行而本进程未提权（UIPI 静默拦截）
    """
    if not hwnd or not win32gui.IsWindow(hwnd):
        return False
    if not win32gui.IsWindowEnabled(hwnd):
        return False

    try:
        _user32.AllowSetForegroundWindow(ASFW_ANY)
    except Exception:
        pass

    try:
        if win32gui.IsIconic(hwnd):
            win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)
            time.sleep(0.05)
        elif not win32gui.IsWindowVisible(hwnd):
            win32gui.ShowWindow(hwnd, win32con.SW_SHOWNORMAL)
            time.sleep(0.05)
    except Exception:
        pass

    hooked = False
    if not fast_only:
        hooked = _HOOK.acquire()

    try:
        for _ in range(6):
            if _try_set_foreground(hwnd):
                return True
            time.sleep(0.01)

        if not fast_only and _send_alt():
            time.sleep(0.03)
            if _try_set_foreground(hwnd):
                return True

        fg = win32gui.GetForegroundWindow()
        cur_tid = win32api.GetCurrentThreadId()
        attached = False
        if fg and fg != hwnd:
            fg_tid = win32process.GetWindowThreadProcessId(fg)[0]
            if fg_tid and fg_tid != cur_tid:
                try:
                    win32process.AttachThreadInput(fg_tid, cur_tid, True)
                    attached = True
                    if _try_set_foreground(hwnd):
                        return True
                except Exception:
                    attached = False
                finally:
                    if attached:
                        try:
                            win32process.AttachThreadInput(fg_tid, cur_tid, False)
                        except Exception:
                            pass

        try:
            _user32.SwitchToThisWindow(hwnd, True)
            time.sleep(0.05)
            if win32gui.GetForegroundWindow() == hwnd:
                return True
        except Exception:
            pass

        return False
    finally:
        if hooked:
            _HOOK.release()


def activate_window_or_bring_to_top(hwnd):
    if activate_window(hwnd):
        return True
    try:
        win32gui.SetWindowPos(
            hwnd,
            win32con.HWND_TOP,
            0,
            0,
            0,
            0,
            win32con.SWP_NOMOVE | win32con.SWP_NOSIZE | win32con.SWP_NOACTIVATE,
        )
        win32gui.FlashWindow(hwnd, True)
    except Exception:
        pass
    return False


if __name__ == "__main__":
    import warnings

    from pywinauto.application import Application

    warnings.filterwarnings(
        "ignore", message=".*32-bit application should be automated.*"
    )
    app = Application(backend="win32").connect(class_name="TElWind")
    activate_window(app.window(class_name="TElWind").handle)

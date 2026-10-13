"""向 SuperMemo（Delphi/VCL）进程发送 WM_COMMAND 菜单命令。"""

import ctypes
import os
import sys
from ctypes import wintypes

from win32con import (
    PROCESS_QUERY_LIMITED_INFORMATION,
    SMTO_ABORTIFHUNG,
    WM_COMMAND,
)

# ── 应用级配置 ──────────────────────────────────────────────────────
MESSAGE_TIMEOUT_MS = 500
DEBUG = os.environ.get("SM_AUTO_DEBUG", "").lower() in ("1", "true", "yes", "on")

# ctypes.wintypes 不提供指针宽度整数，手动补上
DWORD_PTR = ctypes.c_size_t  # 无符号，指针宽度
LRESULT = ctypes.c_ssize_t  # 有符号，指针宽度

# ── Win32 原型 ──────────────────────────────────────────────────────
_u32 = ctypes.WinDLL("user32", use_last_error=True)
_k32 = ctypes.WinDLL("kernel32", use_last_error=True)

_WNDENUMPROC = ctypes.WINFUNCTYPE(wintypes.BOOL, wintypes.HWND, wintypes.LPARAM)

_u32.GetClassNameW.argtypes = (wintypes.HWND, wintypes.LPWSTR, ctypes.c_int)
_u32.GetClassNameW.restype = ctypes.c_int

_u32.GetWindowThreadProcessId.argtypes = (wintypes.HWND, ctypes.POINTER(wintypes.DWORD))
_u32.GetWindowThreadProcessId.restype = wintypes.DWORD

_u32.EnumWindows.argtypes = (_WNDENUMPROC, wintypes.LPARAM)
_u32.EnumWindows.restype = wintypes.BOOL

_u32.SendMessageTimeoutW.argtypes = (
    wintypes.HWND,
    wintypes.UINT,
    wintypes.WPARAM,
    wintypes.LPARAM,
    wintypes.UINT,
    wintypes.UINT,
    ctypes.POINTER(DWORD_PTR),
)
_u32.SendMessageTimeoutW.restype = LRESULT

_k32.OpenProcess.argtypes = (wintypes.DWORD, wintypes.BOOL, wintypes.DWORD)
_k32.OpenProcess.restype = wintypes.HANDLE

_k32.QueryFullProcessImageNameW.argtypes = (
    wintypes.HANDLE,
    wintypes.DWORD,
    wintypes.LPWSTR,
    ctypes.POINTER(wintypes.DWORD),
)
_k32.QueryFullProcessImageNameW.restype = wintypes.BOOL

_k32.CloseHandle.argtypes = (wintypes.HANDLE,)
_k32.CloseHandle.restype = wintypes.BOOL

_k32.SetLastError.argtypes = (wintypes.DWORD,)
_k32.SetLastError.restype = None


# ── 查询原语 ────────────────────────────────────────────────────────
def _class_name(hwnd):
    """窗口类名；失败返回空串。"""
    buf = ctypes.create_unicode_buffer(256)
    n = _u32.GetClassNameW(hwnd, buf, len(buf))
    return buf.value if n else ""


def _process_name_by_pid(pid):
    """按 PID 查可执行文件名（小写）；失败返回空串。"""
    handle = _k32.OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, False, pid)
    if not handle:
        return ""

    try:
        buf = ctypes.create_unicode_buffer(32768)
        size = wintypes.DWORD(len(buf))
        if _k32.QueryFullProcessImageNameW(handle, 0, buf, ctypes.byref(size)):
            return os.path.basename(buf.value).lower()
    finally:
        _k32.CloseHandle(handle)
    return ""


def _find_windows(class_name, process_name):
    """按 (窗口类名, 进程名) 筛选顶层窗口。

    返回所有匹配窗口的句柄——同一进程的多个同类窗口都会被收集，
    调用方对每个窗口各发一次 WM_COMMAND。
    """
    hits = []
    names = {}  # pid -> 进程名，缓存，避免同一进程重复 OpenProcess

    @_WNDENUMPROC
    def _visit(hwnd, _):
        if _class_name(hwnd) != class_name:
            return True

        pid = wintypes.DWORD()
        if not _u32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid)) or not pid.value:
            return True

        if pid.value not in names:
            names[pid.value] = _process_name_by_pid(pid.value)

        if names[pid.value] == process_name:
            hits.append(hwnd)

        return True

    _u32.EnumWindows(_visit, 0)
    return hits


# ── 发送命令 ────────────────────────────────────────────────────────
def send_menu_command(hwnd, menu_id):
    """向 hwnd 发送 WM_COMMAND；成功返回 True。

    SendMessageTimeoutW 返回的 LRESULT 恰是处理函数的返回值，
    WM_COMMAND 通常返回 0，故"ret==0"既可能是失败，也可能是成功。
    用调用前清零的 LastError 兜底区分。
    """
    result = DWORD_PTR()

    _k32.SetLastError(0)
    ret = _u32.SendMessageTimeoutW(
        hwnd,
        WM_COMMAND,
        menu_id,
        0,
        SMTO_ABORTIFHUNG,
        MESSAGE_TIMEOUT_MS,
        ctypes.byref(result),
    )
    ok = bool(ret) or ctypes.get_last_error() == 0

    if not ok and DEBUG:
        print(
            f"[Debug] 句柄 {hwnd:#x} 发送菜单 ID {menu_id} 失败 "
            f"(lasterr={ctypes.get_last_error()})",
            file=sys.stderr,
        )
    return ok


def trigger_menu_bar(menu_id, hwnd):
    """触发菜单栏菜单项（显式给主窗口句柄）。"""
    if not hwnd:
        print("[Error] trigger_menu_bar 需要有效的 hWnd", file=sys.stderr)
        return False
    print(f"向主窗口 {hwnd:#x} 发送菜单 ID {menu_id} ({menu_id:#x})")
    return send_menu_command(hwnd, menu_id)


def trigger_right_click_menu(
    menu_id, process_name="sm20p33.exe", class_name="TPUtilWindow"
):
    """通过 VCL 隐藏消息窗口（TPUtilWindow）转发右键菜单命令。

    同一进程存在多个同类窗口时，向每个窗口各投递一次。
    """
    windows = _find_windows(class_name, process_name.lower())
    if not windows:
        print(f"[Warning] 未找到 {process_name} 的 {class_name} 窗口", file=sys.stderr)
        return False

    sent = sum(send_menu_command(hwnd, menu_id) for hwnd in windows)
    if not sent:
        print(
            "[Warning] 已匹配到目标窗口，但发送消息均失败。"
            "若目标进程以管理员身份运行，请以管理员身份运行本脚本。",
            file=sys.stderr,
        )
        return False

    print(f"已向 {sent}/{len(windows)} 个匹配窗口发送菜单 ID {menu_id}")
    return True


if __name__ == "__main__":
    trigger_right_click_menu(1016)

"""
沿进程树查找"属于本命令窗口家族"的可聚焦窗口
================================================

从 start_pid（默认当前进程）出发，沿父进程链上溯，
返回第一个拥有"可承载前台焦点的顶层窗口"的祖先进程的窗口句柄。

"可承载前台焦点"（近似 Alt+Tab 循环判据）：
  · IsWindow / IsWindowVisible / IsWindowEnabled 全真
  · 无 WS_EX_NOACTIVATE（结构上拒绝激活）
  · 非 WS_EX_TOOLWINDOW（除非叠加 WS_EX_APPWINDOW）
  · 无 owner（附属窗口不参与前台焦点循环）

Win32 边界
----------
Windows Terminal / VS Code 集成终端为单进程多窗口模型，
从某个标签页中的进程上溯只能拿到宿主的某个窗口，
无法精确到"用户当前所在的标签页"。
若链上无合格窗口，返回 None。

依赖 pywin32（仅常量），API 调用全部走 ctypes。
"""

from __future__ import annotations

import ctypes
import ctypes.wintypes as wt
import time
from collections import defaultdict
from collections.abc import Iterator

from win32con import (
    GW_OWNER,
    GWL_EXSTYLE,
    MAX_PATH,
    WS_EX_APPWINDOW,
    WS_EX_NOACTIVATE,
    WS_EX_TOOLWINDOW,
)

from supermemo_toolkit.database.window_focus import activate_window

# ═══════════════════════════════════════════════════════════════
# 1. Win32 绑定（一次声明，签名一眼可读）
# ═══════════════════════════════════════════════════════════════

WNDENUMPROC = ctypes.WINFUNCTYPE(wt.BOOL, wt.HWND, ctypes.c_size_t)

_u32 = ctypes.WinDLL("user32", use_last_error=True)
_k32 = ctypes.WinDLL("kernel32", use_last_error=True)


def _api(lib, name: str, *argtypes, ret=wt.BOOL):
    fn = getattr(lib, name)
    fn.argtypes, fn.restype = list(argtypes), ret
    return fn


# ── 窗口 ──
EnumWindows = _api(_u32, "EnumWindows", WNDENUMPROC, ctypes.c_size_t)
IsWindow = _api(_u32, "IsWindow", wt.HWND)
IsWindowVisible = _api(_u32, "IsWindowVisible", wt.HWND)
IsWindowEnabled = _api(_u32, "IsWindowEnabled", wt.HWND)
GetWindowLong = _api(_u32, "GetWindowLongW", wt.HWND, ctypes.c_int, ret=ctypes.c_long)
GetWindow = _api(_u32, "GetWindow", wt.HWND, ctypes.c_uint, ret=wt.HWND)
GetWindowThreadProcessId = _api(
    _u32,
    "GetWindowThreadProcessId",
    wt.HWND,
    ctypes.POINTER(ctypes.c_ulong),
    ret=ctypes.c_ulong,
)
GetClassName = _api(
    _u32, "GetClassNameW", wt.HWND, wt.LPWSTR, ctypes.c_int, ret=ctypes.c_int
)
GetWindowText = _api(
    _u32, "GetWindowTextW", wt.HWND, wt.LPWSTR, ctypes.c_int, ret=ctypes.c_int
)

# ── 进程 ──
GetCurrentProcessId = _api(_k32, "GetCurrentProcessId", ret=ctypes.c_ulong)
CreateToolhelp32Snapshot = _api(
    _k32, "CreateToolhelp32Snapshot", ctypes.c_ulong, ctypes.c_ulong, ret=wt.HANDLE
)
CloseHandle = _api(_k32, "CloseHandle", wt.HANDLE)


# ═══════════════════════════════════════════════════════════════
# 2. 进程快照：一次枚举，返回 pid → (parent_pid, exe_lower)
# ═══════════════════════════════════════════════════════════════


class _PE32(ctypes.Structure):
    _fields_ = [
        ("dwSize", ctypes.c_ulong),
        ("cntUsage", ctypes.c_ulong),
        ("th32ProcessID", ctypes.c_ulong),
        ("th32DefaultHeapID", ctypes.c_size_t),
        ("th32ModuleID", ctypes.c_ulong),
        ("cntThreads", ctypes.c_ulong),
        ("th32ParentProcessID", ctypes.c_ulong),
        ("pcPriClassBase", ctypes.c_long),
        ("dwFlags", ctypes.c_ulong),
        ("szExeFile", ctypes.c_wchar * MAX_PATH),
    ]


_Process32FirstW = _api(_k32, "Process32FirstW", wt.HANDLE, ctypes.POINTER(_PE32))
_Process32NextW = _api(_k32, "Process32NextW", wt.HANDLE, ctypes.POINTER(_PE32))

_TH32CS_SNAPPROCESS = 0x0002
_INVALID_HANDLE = ctypes.c_void_p(-1).value


def _process_snapshot() -> dict[int, tuple[int, str]]:
    """{pid: (parent_pid, exe_name.lower())}。"""
    snap = CreateToolhelp32Snapshot(_TH32CS_SNAPPROCESS, 0)
    if not snap or snap == _INVALID_HANDLE:
        return {}
    pe = _PE32()
    pe.dwSize = ctypes.sizeof(_PE32)
    table: dict[int, tuple[int, str]] = {}
    try:
        ok = _Process32FirstW(snap, ctypes.byref(pe))
        while ok:
            table[pe.th32ProcessID] = (pe.th32ParentProcessID, pe.szExeFile.lower())
            ok = _Process32NextW(snap, ctypes.byref(pe))
    finally:
        CloseHandle(snap)
    return table


def _name_of(pid: int) -> str:
    return _process_snapshot().get(pid, (0, ""))[1]


# ═══════════════════════════════════════════════════════════════
# 3. 窗口查询
# ═══════════════════════════════════════════════════════════════


def _pid_of(hwnd: int) -> int:
    pid = ctypes.c_ulong()
    GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
    return pid.value


def _class_of(hwnd: int) -> str:
    buf = ctypes.create_unicode_buffer(256)
    GetClassName(hwnd, buf, len(buf))
    return buf.value


def _title_of(hwnd: int) -> str:
    buf = ctypes.create_unicode_buffer(512)
    GetWindowText(hwnd, buf, len(buf))
    return buf.value


def is_focusable_top_window(hwnd: int) -> bool:
    """可见、启用、非拒激活、非纯工具窗口、无 owner —— 近似 Alt+Tab 判据。"""
    if not (IsWindow(hwnd) and IsWindowVisible(hwnd) and IsWindowEnabled(hwnd)):
        return False
    ex = GetWindowLong(hwnd, GWL_EXSTYLE)
    return (
        not (ex & WS_EX_NOACTIVATE)
        and not ((ex & WS_EX_TOOLWINDOW) and not (ex & WS_EX_APPWINDOW))
        and not GetWindow(hwnd, GW_OWNER)
    )


def _focusable_by_pid() -> dict[int, list[int]]:
    """{pid: [hwnd, ...]}，按 Z 序（最顶者在前）。"""
    out: dict[int, list[int]] = defaultdict(list)

    def cb(hwnd, _):
        if is_focusable_top_window(hwnd):
            out[_pid_of(hwnd)].append(hwnd)
        return True

    EnumWindows(WNDENUMPROC(cb), 0)
    return out


# ═══════════════════════════════════════════════════════════════
# 4. 进程树：祖先链作为生成器
# ═══════════════════════════════════════════════════════════════


def _ancestors(start: int, table: dict[int, tuple[int, str]]) -> Iterator[int]:
    """从 start 到根的进程链（去环）。"""
    seen: set[int] = set()
    pid = start
    while pid and pid not in seen:
        seen.add(pid)
        yield pid
        pid = table.get(pid, (0, ""))[0]


# ═══════════════════════════════════════════════════════════════
# 5. 高层入口
# ═══════════════════════════════════════════════════════════════


def find_origin_window(start_pid: int | None = None) -> int | None:
    """沿进程树上溯，返回第一个拥有可聚焦顶层窗口的祖先进程的 hwnd。"""
    table = _process_snapshot()
    windows = _focusable_by_pid()
    start = GetCurrentProcessId() if start_pid is None else start_pid
    return next(
        (windows[pid][0] for pid in _ancestors(start, table) if windows.get(pid)),
        None,
    )


def find_ancestor_chain(
    start_pid: int | None = None,
) -> list[tuple[int, str, int | None]]:
    """调试用：(pid, exe_name, first_focusable_hwnd | None) 的完整上溯链。"""
    table = _process_snapshot()
    windows = _focusable_by_pid()
    start = GetCurrentProcessId() if start_pid is None else start_pid
    return [
        (pid, table.get(pid, (0, ""))[1], (windows.get(pid) or [None])[0])
        for pid in _ancestors(start, table)
    ]


def describe(hwnd: int) -> str:
    """单行描述：hwnd、pid、进程名、类名、标题。"""
    if not hwnd:
        return "<null>"
    pid = _pid_of(hwnd)
    return (
        f"hwnd=0x{hwnd:08X} pid={pid} exe={_name_of(pid)!r} "
        f"class={_class_of(hwnd)!r} title={_title_of(hwnd)!r}"
    )


# ═══════════════════════════════════════════════════════════════
# 6. 演示
# ═══════════════════════════════════════════════════════════════

if __name__ == "__main__":
    pid = GetCurrentProcessId()
    print(f"当前进程 PID: {pid}  名称: {_name_of(pid)!r}\n")

    print("进程树上溯链：")
    for p, name, hwnd in find_ancestor_chain():
        mark = "★" if hwnd else " "
        tail = f"  → {describe(hwnd)}" if hwnd else ""
        print(f"  {mark} pid={p:>7} {name}{tail}")

    hwnd = find_origin_window()
    if hwnd is None:
        print("\n结果：未找到可聚焦的祖先窗口。")
    else:
        print(f"\n结果：{describe(hwnd)}")
        time.sleep(3)
        activate_window(hwnd)

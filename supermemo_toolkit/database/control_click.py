"""
Python 版 ControlClick —— ctypes 消息 + win32con 常量
=====================================================

等价于 AHK：
    ControlClick, ClassNN, ahk_exe exe_name,,,, NA Xx Yy

约束：
- 只发鼠标消息，从不主动激活窗口。
- 返回值真实反映成败。
- clicks=N 由 _events 唯一定义；按钮由 _BUTTONS 唯一定义。
- 需要 Python 3.10+（PEP 604 的 X | None 与内建泛型）。
- 依赖 pywin32，但仅使用 win32con 常量表；消息收发全部走 ctypes。

AHK 兼容性
----------
ControlClick 的 ClickCount 参数语义是"点击次数"，每次点击 = 一次
DOWN + UP 循环，不合成 WM_*BUTTONDBLCLK。本模块的 clicks 参数
严格对齐此语义。

真正的双击（触发控件的 OnDblClick / WM_LBUTTONDBLCLK 处理）需要
额外的 double_click=True 参数，此时消息序列的最后一次点击被扩展为：
    DOWN + UP + DBLCLK + UP
等价于用户真实双击产生的系统消息序列。

NA（无激活）
------------
对应 AHK 原脚本的两处机制：

  第 1 层  消息投递路径本身不调用任何激活 API
           （SetForegroundWindow / SetActiveWindow / SetFocus /
             BringWindowToTop / ShowWindow），只走 PostMessageW 或
           SendMessageTimeoutW。这一层是必要条件，零成本。

  第 2 层  no_activate=True 时（默认），在消息投递期间把当前前台窗口
           临时设为 WS_EX_TOPMOST，投递完毕后撤销。这就是 AHK 原脚本
           的 WinSet AlwaysOnTop 技巧：
               即使目标程序在响应消息时抢焦点，被置顶的前台窗口仍在
               视觉最上层，用户感知不到切换。

           关键：不修改目标窗口的任何状态。曾试过给目标窗口加
           WS_EX_NOACTIVATE，但这是错误方向：
             a) MSDN 明确此样式只在窗口创建时生效，运行时追加无效；
             b) 追加操作会触发目标程序的 WM_STYLECHANGING/CHANGED，
                Delphi/VCL 的响应可能反而激活自己。

Win32 的边界：AlwaysOnTop 只保证视觉遮挡，不保证 GetForegroundWindow
的返回值不变。如果目标程序的窗口过程在响应消息时主动调用
SetForegroundWindow，消息投递方无法阻止。AHK 的 NA 本质相同。
"""

import ctypes
import ctypes.wintypes as wt
import re
import time
from collections.abc import Callable, Generator, Iterator
from contextlib import contextmanager, nullcontext
from dataclasses import dataclass
from enum import Enum
from functools import partial

from win32con import (
    # 窗口状态
    GWL_EXSTYLE,
    HWND_NOTOPMOST,
    HWND_TOPMOST,
    # 进程枚举
    MAX_PATH,
    # 消息
    MK_LBUTTON,
    MK_MBUTTON,
    MK_RBUTTON,
    SMTO_NORMAL,
    SWP_NOACTIVATE,
    SWP_NOMOVE,
    SWP_NOSIZE,
    WM_LBUTTONDBLCLK,
    WM_LBUTTONDOWN,
    WM_LBUTTONUP,
    WM_MBUTTONDBLCLK,
    WM_MBUTTONDOWN,
    WM_MBUTTONUP,
    WM_MOUSEMOVE,
    WM_RBUTTONDBLCLK,
    WM_RBUTTONDOWN,
    WM_RBUTTONUP,
    WS_EX_TOPMOST,
)

# ═══════════════════════════════════════════════════════════════
# 1. Win32 函数绑定
# ═══════════════════════════════════════════════════════════════

WPARAM = LPARAM = ctypes.c_size_t
WNDENUMPROC = ctypes.WINFUNCTYPE(wt.BOOL, wt.HWND, LPARAM)

user32 = ctypes.WinDLL("user32", use_last_error=True)
kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)


def _bind(lib, name, argtypes, restype):
    fn = getattr(lib, name)
    fn.argtypes = argtypes
    fn.restype = restype
    return fn


_bu = partial(_bind, user32)
_bk = partial(_bind, kernel32)

# ── 枚举 / 查询 ──
_EnumWindows = _bu("EnumWindows", [WNDENUMPROC, LPARAM], wt.BOOL)
_EnumChildWindows = _bu("EnumChildWindows", [wt.HWND, WNDENUMPROC, LPARAM], wt.BOOL)
_IsWindow = _bu("IsWindow", [wt.HWND], wt.BOOL)
_IsWindowVisible = _bu("IsWindowVisible", [wt.HWND], wt.BOOL)
_GetClassNameW = _bu("GetClassNameW", [wt.HWND, wt.LPWSTR, ctypes.c_int], ctypes.c_int)
_GetWindowThreadProcessId = _bu(
    "GetWindowThreadProcessId",
    [wt.HWND, ctypes.POINTER(ctypes.c_ulong)],
    ctypes.c_ulong,
)

# ── 消息投递 ──
_PostMessageW = _bu("PostMessageW", [wt.HWND, ctypes.c_uint, WPARAM, LPARAM], wt.BOOL)
_SendMessageTimeoutW = _bu(
    "SendMessageTimeoutW",
    [
        wt.HWND,
        ctypes.c_uint,
        WPARAM,
        LPARAM,
        ctypes.c_uint,
        ctypes.c_uint,
        ctypes.POINTER(ctypes.c_size_t),
    ],
    ctypes.c_size_t,
)

# ── NA 保护层（AlwaysOnTop 技巧）──
_GetForegroundWindow = _bu("GetForegroundWindow", [], wt.HWND)
_GetWindowLongW = _bu("GetWindowLongW", [wt.HWND, ctypes.c_int], ctypes.c_long)
_SetWindowPos = _bu(
    "SetWindowPos",
    [
        wt.HWND,
        wt.HWND,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_int,
        ctypes.c_uint,
    ],
    wt.BOOL,
)

# ═══════════════════════════════════════════════════════════════
# 2. 进程枚举（Toolhelp32）
# ═══════════════════════════════════════════════════════════════


class _PROCESSENTRY32W(ctypes.Structure):
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


_CreateToolhelp32Snapshot = _bk(
    "CreateToolhelp32Snapshot", [ctypes.c_ulong, ctypes.c_ulong], wt.HANDLE
)
_Process32FirstW = _bk(
    "Process32FirstW", [wt.HANDLE, ctypes.POINTER(_PROCESSENTRY32W)], wt.BOOL
)
_Process32NextW = _bk(
    "Process32NextW", [wt.HANDLE, ctypes.POINTER(_PROCESSENTRY32W)], wt.BOOL
)
_CloseHandle = _bk("CloseHandle", [wt.HANDLE], wt.BOOL)

# 本地定义：TH32CS_SNAPPROCESS 不在 win32con 里。
TH32CS_SNAPPROCESS = 0x00000002

# 本地定义：pywin32 的 INVALID_HANDLE_VALUE 是有符号 -1，
# 而 ctypes 的 HANDLE（c_void_p）需要的是无符号全 1 位模式。
_INVALID_HANDLE = ctypes.c_void_p(-1).value


def _iter_process_names() -> Iterator[tuple[int, str]]:
    """产生 (pid, exe_name_lower) 对，遍历系统所有进程。"""
    snap = _CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0)
    if not snap or snap == _INVALID_HANDLE:
        return
    pe = _PROCESSENTRY32W()
    pe.dwSize = ctypes.sizeof(_PROCESSENTRY32W)
    try:
        ok = _Process32FirstW(snap, ctypes.byref(pe))
        while ok:
            yield pe.th32ProcessID, pe.szExeFile.lower()
            ok = _Process32NextW(snap, ctypes.byref(pe))
    finally:
        _CloseHandle(snap)


def _pids_of(exe_name: str) -> set[int]:
    target = exe_name.lower()
    return {pid for pid, name in _iter_process_names() if name == target}


# ═══════════════════════════════════════════════════════════════
# 3. 类型、常量与按钮表
# ═══════════════════════════════════════════════════════════════


class Button(Enum):
    LEFT = "left"
    RIGHT = "right"
    MIDDLE = "middle"


class SendMode(Enum):
    POST = "post"
    SEND_TIMEOUT = "send_timeout"


@dataclass(frozen=True)
class _ButtonSpec:
    down: int
    up: int
    dblclk: int
    mk: int


# 三键的完整信息 —— 唯一的按钮真相源
_BUTTONS: dict[Button, _ButtonSpec] = {
    Button.LEFT: _ButtonSpec(
        WM_LBUTTONDOWN, WM_LBUTTONUP, WM_LBUTTONDBLCLK, MK_LBUTTON
    ),
    Button.RIGHT: _ButtonSpec(
        WM_RBUTTONDOWN, WM_RBUTTONUP, WM_RBUTTONDBLCLK, MK_RBUTTON
    ),
    Button.MIDDLE: _ButtonSpec(
        WM_MBUTTONDOWN, WM_MBUTTONUP, WM_MBUTTONDBLCLK, MK_MBUTTON
    ),
}

# SetWindowPos：只改 Z 序，不动位置尺寸，不激活。
_SWP_ONLY_Z = SWP_NOMOVE | SWP_NOSIZE | SWP_NOACTIVATE

# 消息间隔
_POST_GAP = 0.005  # PostMessage 路径：让消息队列有时间消化
_SEND_GAP = 0.0  # SendMessageTimeout 本身已同步等待


# ═══════════════════════════════════════════════════════════════
# 4. 消息发送（分派表，无 if）
# ═══════════════════════════════════════════════════════════════

_SenderFn = Callable[[int, int, int, int, int], bool]


def _post(hwnd, msg, wp, lp, timeout_ms):
    _PostMessageW(hwnd, msg, wp, lp)
    return True


def _send_timeout(hwnd, msg, wp, lp, timeout_ms):
    r = ctypes.c_size_t()
    return bool(
        _SendMessageTimeoutW(
            hwnd, msg, wp, lp, SMTO_NORMAL, timeout_ms, ctypes.byref(r)
        )
    )


_SENDERS: dict[SendMode, _SenderFn] = {
    SendMode.POST: _post,
    SendMode.SEND_TIMEOUT: _send_timeout,
}


# ═══════════════════════════════════════════════════════════════
# 5. NA 上下文管理器（AlwaysOnTop 技巧）
# ═══════════════════════════════════════════════════════════════


@contextmanager
def _pin_topmost(hwnd: int) -> Generator[None, None, None]:
    """
    临时把窗口置顶（若已置顶则跳过），退出时恢复。

    只做一件事：给 hwnd 加 WS_EX_TOPMOST 视觉层级，退出时撤销。
    不激活、不移动、不调整大小（SWP_NOACTIVATE | NOMOVE | NOSIZE）。
    """
    if not hwnd or not _IsWindow(hwnd):
        yield
        return

    was_topmost = bool(_GetWindowLongW(hwnd, GWL_EXSTYLE) & WS_EX_TOPMOST)
    if not was_topmost:
        _SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, 0, _SWP_ONLY_Z)
    try:
        yield
    finally:
        if not was_topmost:
            _SetWindowPos(hwnd, HWND_NOTOPMOST, 0, 0, 0, 0, _SWP_ONLY_Z)


@contextmanager
def _no_activate(_hwnd_control: int) -> Generator[None, None, None]:
    """
    AHK 的 AlwaysOnTop 技巧：

    投递消息期间，把当前前台窗口临时设为 WS_EX_TOPMOST。这样即使目标
    程序在响应消息时抢焦点，前台窗口仍在视觉最上层，用户感知不到切换。

    注意：
      - 只操作当前前台窗口，不修改目标窗口的任何状态。
      - 这层保护仅保证视觉遮挡，不保证 GetForegroundWindow 的返回值不变。
    """
    fg = _GetForegroundWindow()
    with _pin_topmost(fg) if fg else nullcontext():
        yield


# ═══════════════════════════════════════════════════════════════
# 6. 核心原语
# ═══════════════════════════════════════════════════════════════


def _make_lparam(x: int, y: int) -> int:
    return (y & 0xFFFF) << 16 | (x & 0xFFFF)


def _events(
    button: Button,
    clicks: int,
    double_click: bool,
) -> Iterator[tuple[int, int]]:
    """
    产出 (msg, wparam) 序列。

    clicks 严格匹配 AHK ControlClick 的 ClickCount：
        clicks=N → N 次独立的单击循环（每次 DOWN + UP），不合成 DBLCLK。

    double_click=True 时，最后一次点击被扩展为真正的双击：
        DOWN + UP + DBLCLK + UP —— 与系统真实双击产生的消息序列一致。

    完整序列（以左键为例）：
        MOVE + (DOWN + UP) × (clicks-1) + DOWN + UP [+ DBLCLK + UP]
    """
    b = _BUTTONS[button]
    yield WM_MOUSEMOVE, 0
    for _ in range(clicks - 1):
        yield b.down, b.mk
        yield b.up, 0
    # 最后一次点击（clicks ≥ 1 由 click() 保证）
    yield b.down, b.mk
    yield b.up, 0
    if double_click:
        yield b.dblclk, b.mk
        yield b.up, 0


def click(
    hwnd: int,
    x: int,
    y: int,
    *,
    button: Button = Button.LEFT,
    clicks: int = 1,
    double_click: bool = False,
    mode: SendMode = SendMode.POST,
    timeout_ms: int = 1000,
    no_activate: bool = True,
) -> bool:
    """
    向控件句柄发送点击。

    clicks       —— 点击次数，等价 AHK ControlClick 的 ClickCount。
                    每次点击 = 一次 DOWN + UP 循环，不合成 DBLCLK。
    double_click —— 为 True 时，最后一次点击扩展为真正的双击。
    no_activate  —— 为 True（默认）时，在消息投递期间把当前前台窗口
                    临时置顶（AHK AlwaysOnTop 技巧），退出时撤销。
    """
    if clicks < 1:
        raise ValueError(f"clicks 必须 ≥ 1，实际 {clicks}")
    if not _IsWindow(hwnd):
        return False

    ctx = _no_activate(hwnd) if no_activate else nullcontext()
    send = _SENDERS[mode]
    lp = _make_lparam(x, y)
    gap = _POST_GAP if mode is SendMode.POST else _SEND_GAP

    results = []
    with ctx:
        for msg, wp in _events(button, clicks, double_click):
            results.append(send(hwnd, msg, wp, lp, timeout_ms))
            if gap:
                time.sleep(gap)
    return all(results)


# ═══════════════════════════════════════════════════════════════
# 7. ClassNN 与句柄原语
# ═══════════════════════════════════════════════════════════════


def parse_classnn(classnn: str) -> tuple[str, int]:
    """TToolBar2 → ('TToolBar', 2)；无数字 → index=1；类名为空 → ValueError。"""
    m = re.match(r"^(.*?)(\d*)$", classnn)
    class_name = m.group(1) or classnn
    if not class_name:
        raise ValueError(f"ClassNN '{classnn}' 解析后类名为空")
    return class_name, int(m.group(2) or 1)


@dataclass(frozen=True)
class ControlRef:
    hwnd: int
    class_name: str
    index: int


def _class_of(hwnd: int) -> str:
    buf = ctypes.create_unicode_buffer(256)
    _GetClassNameW(hwnd, buf, len(buf))
    return buf.value


def _pid_of(hwnd: int) -> int:
    pid = ctypes.c_ulong()
    _GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
    return pid.value


def _nth(enum_call, predicate: Callable[[int], bool], n: int) -> int | None:
    """
    枚举窗口，返回第 n 个（1-based）满足 predicate 的句柄。
    enum_call(proc, lParam) —— 兼容 EnumWindows 与 partial(EnumChildWindows, parent)。
    """
    found: list[int] = []

    def cb(hwnd, _):
        if predicate(hwnd):
            found.append(hwnd)
            if len(found) >= n:
                return False  # 收集够了，提前停止
        return True

    enum_call(WNDENUMPROC(cb), 0)
    return found[n - 1] if len(found) >= n else None


# ═══════════════════════════════════════════════════════════════
# 8. 查找
# ═══════════════════════════════════════════════════════════════


def find_window_by_exe(exe_name: str, window_class: str | None = None) -> int | None:
    """按 exe 名 + 可选窗口类名（大小写不敏感）找第一个可见顶层窗口。"""
    pids = _pids_of(exe_name)
    if not pids:
        return None
    want = window_class.lower() if window_class else None

    def match(hwnd: int) -> bool:
        return (
            _pid_of(hwnd) in pids
            and bool(_IsWindowVisible(hwnd))
            and (want is None or _class_of(hwnd).lower() == want)
        )

    return _nth(_EnumWindows, match, 1)


def find_control(parent: int, classnn: str) -> ControlRef | None:
    """按 ClassNN 在 parent 的子窗口中查找控件。"""
    class_name, index = parse_classnn(classnn)
    hwnd = _nth(
        partial(_EnumChildWindows, parent),
        lambda h: _class_of(h) == class_name,
        index,
    )
    return ControlRef(hwnd, class_name, index) if hwnd is not None else None


# ═══════════════════════════════════════════════════════════════
# 9. 高层入口
# ═══════════════════════════════════════════════════════════════


def control_click_by_classnn(
    exe_name: str,
    classnn: str,
    x: int,
    y: int,
    *,
    button: Button = Button.LEFT,
    clicks: int = 1,
    double_click: bool = False,
    mode: SendMode = SendMode.POST,
    timeout_ms: int = 1000,
    no_activate: bool = True,
    window_class: str | None = None,
    hwnd_parent: int | None = None,
) -> tuple[bool, ControlRef | None]:
    """
    完整等价于：
        ControlClick, ClassNN, ahk_exe exe_name,,,, NA Xx Yy

    额外扩展：
        double_click=True → 消息序列的最后一次点击为真正的双击
                            （DOWN + UP + DBLCLK + UP）。

    返回 (成功与否, ControlRef)。失败时 hwnd 为 None。
    """
    if hwnd_parent is not None and not _IsWindow(hwnd_parent):
        return False, None

    if hwnd_parent is None:
        hwnd_parent = find_window_by_exe(exe_name, window_class)
        if hwnd_parent is None:
            return False, None

    ref = find_control(hwnd_parent, classnn)
    if ref is None:
        return False, None

    ok = click(
        ref.hwnd,
        x,
        y,
        button=button,
        clicks=clicks,
        double_click=double_click,
        mode=mode,
        timeout_ms=timeout_ms,
        no_activate=no_activate,
    )
    return ok, ref


# ═══════════════════════════════════════════════════════════════
# 10. 示例
# ═══════════════════════════════════════════════════════════════

if __name__ == "__main__":
    # 单击
    ok, ref = control_click_by_classnn(
        exe_name="sm20p33.exe",
        window_class="TElWind",
        classnn="TToolBar1",
        x=42,
        y=20,
    )
    print("single click:", ok, ref)

    # 双击
    # ok, ref = control_click_by_classnn(
    #     exe_name="sm20p33.exe",
    #     window_class="TElWind",
    #     classnn="TToolBar1",
    #     x=42,
    #     y=20,
    #     double_click=True,
    # )
    # print("double click:", ok, ref)

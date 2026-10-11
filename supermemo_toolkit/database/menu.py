import ctypes
import ctypes.wintypes
import os
import time

import win32con
import win32gui
import win32process

# ============================================================
# 第一部分：菜单栏触发
# 对应 AHK 代码:
#   DetectHiddenWindows, On
#   SendMessage,0x111,%menuID%,0,,ahk_id %hWnd%
# ============================================================


def trigger_menu_bar(menuID, hWnd):
    """触发菜单栏菜单项
    参数:
        menuID: 菜单项ID (整数)，如在 SuperMemo 菜单中看到的 ID (例如 980)
        hWnd:   窗口句柄 (整数)，SuperMemo 主窗口句柄
    说明:
        AHK 中 DetectHiddenWindows, On 在 Python 中无需特殊处理，
        win32gui.SendMessage 天然支持向隐藏窗口发送消息。
        0x111 即 WM_COMMAND 消息。
    """
    win32gui.SendMessage(hWnd, win32con.WM_COMMAND, menuID, 0)


# ============================================================
# 第二部分：右键菜单触发
# 对应 AHK 代码:
#   DetectHiddenWindows, On
#   WinGet, vWinList, List, ahk_class TPUtilWindow
#   Loop, %vWinList%
#   {
#   hWnd := vWinList%A_Index%
#   WinGet, vWinProcess, ProcessName, ahk_id %hWnd%
#   if (vWinProcess = "sm18.exe")
#   SendMessage,0x111,%menuID%,0,,ahk_id %hWnd%
#   Sleep 1
#   }
#   Return
# ============================================================


def _get_process_name_from_hwnd(hWnd):
    """通过窗口句柄获取进程名
    对应 AHK: WinGet, vWinProcess, ProcessName, ahk_id %hWnd%
    """
    try:
        pid = win32process.GetWindowThreadProcessId(hWnd)[1]
        # 优先使用 psutil（更简洁可靠）
        try:
            import psutil

            return psutil.Process(pid).name()
        except ImportError:
            # fallback: 使用 ctypes 调用 Windows API QueryFullProcessImageNameW
            kernel32 = ctypes.windll.kernel32
            PROCESS_QUERY_INFORMATION = 0x0400
            PROCESS_VM_READ = 0x0010
            handle = kernel32.OpenProcess(
                PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, False, pid
            )
            if not handle:
                return ""
            try:
                buffer = ctypes.create_unicode_buffer(260)
                size = ctypes.c_ulong(260)
                result = kernel32.QueryFullProcessImageNameW(
                    handle, 0, buffer, ctypes.byref(size)
                )
                if result:
                    return os.path.basename(buffer.value)
            finally:
                kernel32.CloseHandle(handle)
    except:
        pass
    return ""


def trigger_right_click_menu(menuID):
    """触发右键菜单项（通过枚举 TPUtilWindow 窗口）
    参数:
        menuID: 菜单项ID (整数)
    说明:
        原理是嗅探 TPUtilWindow（一个隐藏窗口，负责处理 SM 的菜单项消息），
        遍历所有该类窗口，找到 sm18.exe 进程对应的窗口并发送消息。
        对应 AHK:
          WinGet, vWinList, List, ahk_class TPUtilWindow
          Loop, %vWinList% { ... }
    """
    # 枚举所有 TPUtilWindow 类名的窗口
    window_list = []

    def enum_callback(hWnd, lParam):
        try:
            class_name = win32gui.GetClassName(hWnd)
            if class_name == "TPUtilWindow":
                lParam.append(hWnd)
        except:
            pass
        return True

    win32gui.EnumWindows(enum_callback, window_list)

    for hWnd in window_list:
        vWinProcess = _get_process_name_from_hwnd(hWnd)
        if vWinProcess == "sm20p33.exe":
            win32gui.SendMessage(hWnd, win32con.WM_COMMAND, menuID, 0)
            time.sleep(0.001)  # 对应 AHK: Sleep 1


# ============================================================
# 第三部分：菜单项ID查询工具
# 对应 AHK 代码块3（完整的菜单项信息查询脚本）
# ============================================================

# --- Windows API 常量 ---
WM_COMMAND = 0x0111  # 对应 AHK SendMessage 中的 0x111

# --- 菜单项状态常量（与 AHK 中定义一致）---
MFS_ENABLED = 0  # 0x0000
MFS_CHECKED = 0x0008  # 8
MFS_DEFAULT = 0x1000  # 4096
MFS_DISABLED = 0x0002  # 2
MFS_GRAYED = 0x0001  # 1
MFS_HILITE = 0x0080  # 128  (Highlight)

# --- MIIM 常量（GetMenuItemInfo 的 fMask）---
MIIM_TYPE = 0x0010  # 获取 fType
MIIM_STRING = 0x0040  # 获取 dwTypeData
MIIM_STATE = 0x0001  # 获取 fState
MIIM_ID = 0x0002  # 获取 wID


# --- MENUITEMINFO 结构体 ---
# 对应 AHK 注释中的 C 结构体定义:
#   typedef struct tagMENUITEMINFO {
#     UINT    cbSize;
#     UINT    fMask;
#     UINT    fType;
#     UINT    fState;
#     UINT    wID;
#     HMENU   hSubMenu;
#     HBITMAP hbmpChecked;
#     HBITMAP hbmpUnchecked;
#     ULONG_PTR dwItemData;
#     LPTSTR  dwTypeData;
#     UINT    cch;
#     HBITMAP hbmpItem;
#   } MENUITEMINFO, *LPMENUITEMINFO;
class MENUITEMINFO(ctypes.Structure):
    _fields_ = [
        ("cbSize", ctypes.c_uint),
        ("fMask", ctypes.c_uint),
        ("fType", ctypes.c_uint),
        ("fState", ctypes.c_uint),
        ("wID", ctypes.c_uint),
        ("hSubMenu", ctypes.c_void_p),
        ("hbmpChecked", ctypes.c_void_p),
        ("hbmpUnchecked", ctypes.c_void_p),
        ("dwItemData", ctypes.c_void_p),
        ("dwTypeData", ctypes.c_char_p),
        ("cch", ctypes.c_uint),
        ("hbmpItem", ctypes.c_void_p),
    ]


def _get_menu_handle(hWnd):
    """从窗口获取菜单句柄
    对应 AHK: SendMessage, 0x01E1, , , , ahk_id %hWnd%
    errorlevel 即返回的菜单句柄
    """
    return win32gui.SendMessage(hWnd, 0x01E1)


def get_context_menu_count(hWnd):
    """获取菜单项数量
    对应 AHK GetContextMenuCount 函数
    """
    # 检查窗口类名是否为 #32768（弹出菜单）
    window_class = win32gui.GetClassName(hWnd)
    if window_class != "#32768":
        return 0

    hMenu = _get_menu_handle(hWnd)
    if not hMenu:
        return 0

    # DllCall("GetMenuItemCount", Ptr, hMenu)
    count = ctypes.windll.user32.GetMenuItemCount(hMenu)
    return count


def get_context_menu_state(hWnd, position):
    """获取菜单项状态
    对应 AHK GetContextMenuState 函数
    返回: 状态位掩码（如 MFS_HILITE），失败返回 -1
    """
    window_class = win32gui.GetClassName(hWnd)
    if window_class != "#32768":
        return -1

    hMenu = _get_menu_handle(hWnd)
    if not hMenu:
        return -1

    # VarSetCapacity(MenuItemInfo, 60, 0)  -> 用 ctypes 创建结构体
    menu_item = MENUITEMINFO()
    # NumPut(A_PtrSize=8?80:48, MenuItemInfo, 0, "UInt")
    menu_item.cbSize = ctypes.sizeof(MENUITEMINFO)
    # NumPut(1, MenuItemInfo, 4, "UInt")   -> fMask = MIIM_STATE (1)
    menu_item.fMask = MIIM_STATE

    # DllCall("user32.dll\GetMenuItemInfo", Ptr,hMenu, UInt,Position, Int,1, Ptr,&MenuItemInfo)
    result = ctypes.windll.user32.GetMenuItemInfoW(
        hMenu, position, True, ctypes.byref(menu_item)
    )

    # InfoResError := errorlevel
    # LastErrorRes := DllCall("GetLastError", UInt)
    if not result:
        return -1
    if ctypes.windll.kernel32.GetLastError() != 0:
        return -1

    # GetMenuItemInfoRes := NumGet(MenuItemInfo, 12, "UInt")  -> fState 在偏移12
    return menu_item.fState


def get_context_menu_id(hWnd, position):
    """获取菜单项ID
    对应 AHK GetContextMenuID 函数
    返回: 菜单项ID，失败返回 -1
    """
    window_class = win32gui.GetClassName(hWnd)
    if window_class != "#32768":
        return -1

    hMenu = _get_menu_handle(hWnd)
    if not hMenu:
        return -1

    # DllCall("user32.dll\GetMenuItemID", Ptr,hMenu, Int,Position, UInt)
    menu_id = ctypes.windll.user32.GetMenuItemID(hMenu, position)

    InfoResError = not menu_id if menu_id else True  # 简化判断
    LastErrorRes = ctypes.windll.kernel32.GetLastError()
    if InfoResError or LastErrorRes != 0:
        return -1

    return menu_id


def get_context_menu_text(hWnd, position):
    """获取菜单项文本
    对应 AHK GetContextMenuText 函数
    返回: 菜单项文本字符串，失败返回 -1
    """
    window_class = win32gui.GetClassName(hWnd)
    if window_class != "#32768":
        return -1

    hMenu = _get_menu_handle(hWnd)
    if not hMenu:
        return ""

    # 第一次调用：获取所需缓冲区大小
    menu_item = MENUITEMINFO()
    menu_item.cbSize = ctypes.sizeof(MENUITEMINFO)
    # NumPut(64, MenuItemInfo, 4, "UInt")  -> fMask = MIIM_STRING (0x40 = 64)
    menu_item.fMask = MIIM_STRING
    menu_item.cch = 0

    result = ctypes.windll.user32.GetMenuItemInfoW(
        hMenu, position, True, ctypes.byref(menu_item)
    )
    if not result:
        return ""

    # 获取字符串大小
    text_length = menu_item.cch
    if text_length == 0:
        return "{Empty String}"

    # +2 用于安全（对应 AHK: GetMenuItemInfoRes += 2）
    text_length += 2
    popup_text = ctypes.create_unicode_buffer(text_length)

    # 第二次调用：获取文本内容
    menu_item = MENUITEMINFO()
    menu_item.cbSize = ctypes.sizeof(MENUITEMINFO)
    menu_item.fMask = MIIM_STRING
    menu_item.cch = text_length
    # NumPut(&PopupText, MenuItemInfo, A_PtrSize=8?56:36, "Ptr")
    # dwTypeData 字段对应指针位置
    menu_item.dwTypeData = popup_text

    result = ctypes.windll.user32.GetMenuItemInfoW(
        hMenu, position, True, ctypes.byref(menu_item)
    )
    if not result:
        return ""

    if ctypes.windll.kernel32.GetLastError() != 0:
        return ""

    return popup_text.value


def get_menu_state_description(state):
    """将菜单项状态位转换为描述字符串
    对应 AHK Demo 标签中拼接 CurrentText 的逻辑
    """
    descriptions = []
    if state & MFS_ENABLED:
        descriptions.append("Enabled")
    if state & MFS_CHECKED:
        descriptions.append("Checked")
    if state & MFS_DEFAULT:
        descriptions.append("Default")
    if state & MFS_DISABLED:
        descriptions.append("Disabled")
    if state & MFS_GRAYED:
        descriptions.append("Grayed")
    if state & MFS_HILITE:
        descriptions.append("Highlight")
    return " ".join(descriptions) if descriptions else "None"


def query_menu_at_cursor():
    """查询鼠标当前位置窗口下的菜单项信息
    对应 AHK Demo 标签的功能（一次性查询版本）

    使用方法:
        1. 在 SuperMemo 中打开右键菜单（不要点击任何选项）
        2. 将鼠标悬停在某个菜单项上
        3. 运行此函数
        4. 查看输出的文本、ID 和状态信息
    """
    # MouseGetPos 等价: 获取鼠标屏幕坐标
    point = ctypes.wintypes.POINT()
    ctypes.windll.user32.GetCursorPos(ctypes.byref(point))

    # 获取鼠标下的窗口句柄
    hWnd = ctypes.windll.user32.WindowFromPoint(point)

    # 获取窗口类名
    window_class = win32gui.GetClassName(hWnd)

    if window_class != "#32768":
        print(f"鼠标下不是弹出菜单窗口 (class='{window_class}', 需要 '#32768')")
        return

    # GetContextMenuCount
    menu_count = get_context_menu_count(hWnd)
    if menu_count < 1:
        print("没有菜单项")
        return

    print(f"\n=== 菜单项信息 (共 {menu_count} 项) ===")
    print("-" * 70)

    # 对应 AHK: loop, %ContextMenCnt% { ... }
    # 第一轮：读取状态
    state_list = []
    for i in range(menu_count):
        is_enabled = get_context_menu_state(hWnd, i)
        state_list.append(is_enabled)

    # 第二轮：读取文本和ID
    for i in range(menu_count):
        # 状态描述
        is_enabled = state_list[i]
        state_desc = (
            get_menu_state_description(is_enabled) if is_enabled >= 0 else "Unknown"
        )

        # 文本和ID
        text = get_context_menu_text(hWnd, i)
        menu_id = get_context_menu_id(hWnd, i)

        print(
            f"  [{i + 1}] Text: {text:<30s} | ID: {menu_id:<6d} | State: {state_desc}"
        )

    print("-" * 70)


# ============================================================
# 连续监控版本（对应 AHK SetTimer, Demo, 500）
# 每500ms自动查询一次鼠标位置的菜单信息
# ============================================================


def demo_loop_continuous():
    """连续监控鼠标位置的菜单项（每500ms更新）
    对应 AHK:
        #Persistent
        SetTimer, Demo, 500
        return
    按 Ctrl+C 停止
    """
    print("=" * 60)
    print(" 连续监控模式启动 (按 Ctrl+C 停止)")
    print(" 将鼠标移动到 SuperMemo 的右键菜单上查看信息")
    print("=" * 60)
    print()

    try:
        while True:
            query_menu_at_cursor()
            time.sleep(0.5)  # 对应 AHK SetTimer 的 500ms
    except KeyboardInterrupt:
        print("\n监控已停止")


# ============================================================
# 入口
# ============================================================

if __name__ == "__main__":
    # demo_loop_continuous()
    trigger_right_click_menu(1016)
    # print("=" * 60)
    # print(" SuperMemo 后台触发菜单 - Python 版本")
    # print(" 原文: https://zhuanlan.zhihu.com/p/412553730")
    # print("=" * 60)
    # print()
    # print("可用功能:")
    # print("  1. trigger_menu_bar(menuID, hWnd)      - 触发菜单栏菜单项")
    # print("  2. trigger_right_click_menu(menuID)    - 触发右键菜单项")
    # print("  3. query_menu_at_cursor()              - 一次性查询菜单项ID")
    # print("  4. demo_loop_continuous()              - 连续监控模式")
    # print()
    # print("依赖安装: pip install pywin32 psutil")

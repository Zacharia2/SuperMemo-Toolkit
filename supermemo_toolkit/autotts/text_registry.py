"""
通过窗口句柄获取 SuperMemo 中 IE 控件的 HTML 文档对象
最小化实现，无额外依赖（仅需 pywin32）
"""

import win32gui
import win32con
import pythoncom
import win32com.client
import logging
import win32process
import win32api
import os
import struct
from collections import namedtuple
from pywinauto.application import Application

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def get_process_path(pid):
    """通过 PID 获取进程的可执行文件完整路径（尽量兼容不同 Windows 版本）"""
    try:
        h_process = win32api.OpenProcess(
            win32con.PROCESS_QUERY_INFORMATION | win32con.PROCESS_VM_READ, False, pid
        )
        path = win32process.GetModuleFileNameEx(h_process, 0)
        win32api.CloseHandle(h_process)
        return path
    except Exception:
        return None


def get_ancestor_classes(hwnd):
    """获取窗口及其所有祖先的类名列表（从自身到根）"""
    classes = []
    current = hwnd
    while current:
        try:
            classes.append(win32gui.GetClassName(current))
            current = win32gui.GetParent(current)
        except Exception:
            break
    return classes


def find_ie_server_flexible(process_path, root_class, required_ancestor_class):
    """
    在指定进程的顶层 root_class 窗口中，查找 Internet Explorer_Server，
    且其祖先链中必须包含 required_ancestor_class（不一定是直接父窗口）。
    返回第一个匹配的句柄，若未找到返回 None。
    """
    # 1. 获取目标进程的所有 PID
    target_pids = set()
    for pid in win32process.EnumProcesses():
        exe_path = get_process_path(pid)
        if exe_path and exe_path.lower() == process_path.lower():
            target_pids.add(pid)
    if not target_pids:
        return None

    # 2. 枚举顶层窗口，找到属于目标进程且类名为 root_class 的窗口
    root_windows = []

    def enum_top_callback(hwnd, results):
        try:
            _, pid = win32process.GetWindowThreadProcessId(hwnd)
            if pid in target_pids and win32gui.GetClassName(hwnd) == root_class:
                results.append(hwnd)
        except Exception:
            pass
        return True

    win32gui.EnumWindows(enum_top_callback, root_windows)
    if not root_windows:
        return None

    # 3. 在每个顶层窗口下递归查找 Internet Explorer_Server，并检查祖先
    for root_hwnd in root_windows:

        def enum_child_callback(child, _):
            if win32gui.GetClassName(child) == "Internet Explorer_Server":
                ancestors = get_ancestor_classes(child)
                if required_ancestor_class in ancestors:
                    # 找到匹配的 IE Server，通过非局部变量返回
                    result.append(child)
                    return False  # 停止枚举
            return True

        result = []
        win32gui.EnumChildWindows(root_hwnd, enum_child_callback, None)
        if result:
            return result[0]

    return None


def get_html_doc_from_hwnd(hwnd):
    """从 Internet Explorer_Server 窗口句柄获取 IHTMLDocument2 对象"""
    if not hwnd:
        logger.warning("hwnd is None")
        return None

    try:
        msg = win32gui.RegisterWindowMessage("WM_HTML_GETOBJECT")
        result, lpdwResult = win32gui.SendMessageTimeout(
            hwnd, msg, 0, 0, win32con.SMTO_ABORTIFHUNG, 1000
        )
        if not result or not lpdwResult:
            logger.warning(
                f"SendMessageTimeout 失败，hwnd={hwnd:#x}, result={result}, lpdwResult={lpdwResult}"
            )
            return None

        ob = pythoncom.ObjectFromLresult(lpdwResult, pythoncom.IID_IDispatch, 0)
        doc = win32com.client.Dispatch(ob)
        return doc

    except Exception as e:
        logger.exception(f"获取文档对象失败: {e}")
        return None


def safe_com_initialize():
    """
    安全初始化 COM 为多线程模型（COINIT_MULTITHREADED）。
    返回 (是否由本函数成功初始化)，用于配对 CoUninitialize。
    """
    try:
        pythoncom.CoInitializeEx(0)  # 0 = COINIT_MULTITHREADED
        return True
    except pythoncom.com_error as e:
        # 如果已经以不同模型初始化，则不再重复初始化
        if e.hresult == pythoncom.RPC_E_CHANGED_MODE:
            logger.debug("COM 已以其他模型初始化，跳过 CoInitialize")
            return False
        else:
            raise


def get_supermemo_html_doc_by_win32(app=None):
    """
    主函数：获取 SuperMemo 中 IE 控件的 HTML 文档对象。
    参数 app 可选，若提供则为已连接的 pywinauto Application 对象。
    """
    need_uninit = False
    try:
        # 安全初始化 COM
        need_uninit = safe_com_initialize()

        # 获取 SuperMemo 主窗口的 Application 对象
        if app is None:
            app = Application(backend="win32").connect(class_name="TElWind")

        # 获取进程路径
        exe_path = get_process_path(app.process)
        if not exe_path:
            logger.error("无法获取 SuperMemo 进程路径")
            return None

        # 灵活查找 IE Server 窗口（祖先链中需包含 TScrollBox）
        hwnd = find_ie_server_flexible(
            process_path=exe_path,
            root_class="TElWind",
            required_ancestor_class="TScrollBox",
        )

        if not hwnd:
            logger.warning("未找到 Internet Explorer_Server 窗口")
            return None

        doc = get_html_doc_from_hwnd(hwnd)
        if doc:
            content: str = doc.body.innerText
            if "#SuperMemo Reference" in content:
                content = content.split("#SuperMemo Reference")[0].strip()
            else:
                content = content.strip()
            return content
        return None

    finally:
        if need_uninit:
            pythoncom.CoUninitialize()


# 字节序：小端，格式字符串对应字段顺序
# https://github.com/supermemo/SuperMemoAssistant/blob/develop/src/Core/SuperMemoAssistant.Core/SuperMemo/SuperMemo17/Files/RegMemElem17.cs
# 01000000 0300 00000000 01000000 19000000 01000000 00000000 00000000
# 01000000 03 00 00000000 01000000 19000000 01000000 00000000 00000000
# 元素id和membersindex的桥梁呢？只能从ElementInfo.dat获得了
# lst 行号1522 (members index)，内容是元素id
# prt 行号1522 (members index)，内容是 members的行号
# members 行号6461 (Pos)，内容是 member(UseCount=1, LinkType=2, RtxId=0, RtxOffset=6832362, RtxLength=10625, XX=2613, SlotId=1846, Empty=0, Reserved=0)
member_fmt = struct.Struct("<IHIIIIII")
c_member = namedtuple(
    "member",
    [
        "UseCount",  # uint32, offset 0 没问题
        "LinkType",  # uint16, offset 4 没问题
        "unknown1",  # uint32, offset 6
        "RtxOffset",  # uint32, offset 10
        "RtxLength",  # uint32, offset 14
        "LstRelated",  # uint32, offset 18
        "SlotId",  # uint32, offset 22 没问题
        "unknown2",  # uint32, offset 26
    ],
)


def parse_text_registry_member(data: bytes) -> c_member:
    if len(data) != 30:
        raise ValueError(f"数据长度必须是 30 字节，实际为 {len(data)} 字节")
    unpacked = member_fmt.unpack(data)
    return c_member(*unpacked)


def get_element_path_by_slot(slot: int, system_dir: str, extension: str = "HTM") -> str:
    base = [10, 300, 9000, 270000, 8100000]
    limit = [10, 310, 9310, 279310, 8379310]

    # 确定目录级数 i（满足 slot <= limit[i] 的最小 i）
    i = 0
    while i < len(limit) and slot > limit[i]:
        i += 1

    if i == 0:
        dirs = []  # 无子目录
    else:
        rem = slot - limit[i - 1]  # 减去上一级的累计上限
        dirs = []
        for j in range(i, 0, -1):  # 从高位到低位生成目录数字
            b = base[j - 1]
            digit = (rem - 1) // b + 1
            rem -= b * (digit - 1)
            dirs.append(str(digit))

    path_parts = [system_dir, "elements"] + dirs + [f"{slot}.{extension}"]
    return "\\".join(path_parts)


def get_slot(element_id: int, system_dir: str) -> int:
    ptr_file = os.path.join(system_dir, "registry", "Text.ptr")
    mem_file = os.path.join(system_dir, "registry", "Text.mem")

    # 检查两个文件是否都存在
    if not (os.path.exists(ptr_file) and os.path.exists(mem_file)):
        return 0

    with open(ptr_file, "rb") as f:
        ptr_data = f.read()
    with open(mem_file, "rb") as f:
        mem_data = f.read()

    # 验证数据长度
    if len(ptr_data) % 4 != 0 or len(mem_data) % 30 != 0:
        return 0

    num_members = len(ptr_data) // 4

    # 一次性解包所有指针（1-based 元组）
    ptrs = (None, *struct.unpack(f"<{num_members}I", ptr_data))

    # 构建 members 列表，索引0占位，使后续使用1-based索引方便
    members = (
        None,
        *[c_member(*fields) for fields in member_fmt.iter_unpack(mem_data)],
    )

    # 检查 element_id 是否在有效范围内
    if not (1 <= element_id <= num_members):
        return 0

    mem_index = ptrs[element_id]  # 获取内存索引（1-based）
    # 检查内存索引是否有效
    if not (1 <= mem_index < len(members)):
        return 0
    a = members[mem_index].SlotId
    return a


def get_element_path(element_id: int, system_dir: str) -> str:
    slot = get_slot(element_id, system_dir)
    print(f"Element ID {element_id} 对应的 Slot ID 是 {slot}")
    return get_element_path_by_slot(slot, system_dir)


if __name__ == "__main__":
    system = r"D:\SuperMemo\systems\Reading-And-Review"
    ptr_file = os.path.join(system, "registry", "Text.ptr")
    mem_file = os.path.join(system, "registry", "Text.mem")

    # print(get_element_path_by_slot(593, system))
    # print(get_element_path(1105, system))
    # result = get_supermemo_html_doc_by_win32()
    # if result:
    #     print(result)
    # else:
    #     print("未能获取到内容")

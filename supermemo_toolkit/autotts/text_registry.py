"""
通过窗口句柄获取 SuperMemo 中 IE 控件的 HTML 文档对象
最小化实现，无额外依赖（仅需 pywin32）
"""

import logging
import os
import struct
from collections import namedtuple
from enum import IntEnum

import pythoncom
import win32api
import win32com.client
import win32con
import win32gui
import win32process
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


def get_ihtmldocument2(hwnd):
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

        object = pythoncom.ObjectFromLresult(lpdwResult, pythoncom.IID_IDispatch, 0)
        ihtmldocument2 = win32com.client.Dispatch(object)
        return ihtmldocument2

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


def get_supermemo_ie_document(app=None):
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

        htmldocument2 = get_ihtmldocument2(hwnd)
        if htmldocument2:
            logger.info("成功获取 HTML 文档对象")
            return htmldocument2
        return None

    finally:
        if need_uninit:
            pythoncom.CoUninitialize()


# from functools import singledispatch
# @singledispatch
# def get_supermemo_html(app=None):
#     pass
# 需要具体类型才能用singledispatch
# @get_supermemo_html.register
def get_supermemo_html(ie_document) -> str:
    if ie_document is None:
        return ""
    content: str = ie_document.body.innerText
    if "#SuperMemo Reference" in content:
        content = content.split("#SuperMemo Reference")[0].strip()
    else:
        content = content.strip()
    return content


def get_supermemo_html_path(ie_document):
    # TODO
    # Element#33-Component#1.htm存在，但是修改他不会修改内容。

    # IE 组件
    # doc.URLUnencoded = "file:///D:/SuperMemo/systems/Maths/temp/Element#33-Component#1.htm"
    # doc.url = "file://D:\\SuperMemo\\systems\\Maths\\temp\\Element#33-Component#1.htm"
    # IHTMLDocument2 提供 url 属性，返回文档的完整 URL（例如 file:///C:/.../doc.html 或 http://...）。

    # WV 组件来说：
    # // type 为 page 的 url
    # // http://localhost:19222/json
    # document.URL = 'file:///D:/supermemo/systems/foreign%20columns/elements/1/12.PDF'
    # document.URL = 'file:///D:/supermemo/systems/foreign columns/temp/Element#132-Component#2.htm'
    # [
    # {
    #     "description": "",
    #     "devtoolsFrontendUrl": "https://aka.ms/docs-landing-page/serve_rev/@2db6d3cb8b2da04832d959ec60c40e1ced3363d1/inspector.html?ws=localhost:19222/devtools/page/B221BA11595FF85E39939AF8C3BBC2C8",
    #     "id": "B221BA11595FF85E39939AF8C3BBC2C8",
    #     "title": "Element#132-Component#2.htm",
    #     "type": "page",
    #     "url": "file:///D:/supermemo/systems/foreign columns/temp/Element#132-Component#2.htm",
    #     "webSocketDebuggerUrl": "ws://localhost:19222/devtools/page/B221BA11595FF85E39939AF8C3BBC2C8"
    # },
    # {
    #     "description": "",
    #     "devtoolsFrontendUrl": "https://aka.ms/docs-landing-page/serve_rev/@2db6d3cb8b2da04832d959ec60c40e1ced3363d1/inspector.html?ws=localhost:19222/devtools/page/BB88AEA6ADAFF6DE1DFF1A8CE07DA2DD",
    #     "id": "BB88AEA6ADAFF6DE1DFF1A8CE07DA2DD",
    #     "title": "Element#132-Component#1.htm",
    #     "type": "page",
    #     "url": "file:///D:/supermemo/systems/foreign columns/temp/Element#132-Component#1.htm",
    #     "webSocketDebuggerUrl": "ws://localhost:19222/devtools/page/BB88AEA6ADAFF6DE1DFF1A8CE07DA2DD"
    # }
    # ]

    if ie_document is None:
        return None
    url = ie_document.url
    if url.startswith("file://"):
        import urllib.request
        from urllib.parse import urlparse

        return urllib.request.url2pathname(urlparse(url).path)
    return url  # 非 file 协议时返回原始 URL


# ===========================================================================


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


# 字节序：小端，格式字符串对应字段顺序
# https://github.com/supermemo/SuperMemoAssistant/blob/develop/src/Core/SuperMemoAssistant.Core/SuperMemo/SuperMemo17/Files/RegMemElem17.cs
# 01000000 0300 00000000 01000000 19000000 01000000 00000000 00000000
# 01000000 03 00 00000000 01000000 19000000 01000000 00000000 00000000
# 元素id和membersindex的桥梁呢？只能从ElementInfo.dat获得了
# lst 行号1522 (members index)，内容是元素id
# prt 行号1522 (members index)，内容是 members的行号
# members 行号6461 (Pos)，内容是 member(UseCount=1, LinkType=2, RtxId=0, RtxOffset=6832362, RtxLength=10625, XX=2613, SlotId=1846, Empty=0, Reserved=0)
# Text.rtx (原始文本存储)
# 格式: [UTF-8文本] + [null终止符] + [4B自身ID] + [1B类型标记]
# 示例: 知识树标题文本 + 00（\0） + 03 00 00 00 + 01
# 这样知道元素id就知道了知识树的文本标题了。CTRL+N粘贴就会产生53字节的02放在两条数据中间。
member_fmt = struct.Struct("<IHIIIIII")
Member = namedtuple(
    "Member",
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


def parse_member(data: bytes) -> Member:
    if len(data) != 30:
        raise ValueError(f"数据长度必须是 30 字节，实际为 {len(data)} 字节")
    unpacked = member_fmt.unpack(data)
    return Member(*unpacked)


def get_slot(member_id: int, system_dir: str) -> int:
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

    # 构建 members 列表（1-based 元组）
    members = (
        None,
        *[Member(*fields) for fields in member_fmt.iter_unpack(mem_data)],
    )

    # 检查 element_id 是否在有效范围内
    if not (1 <= member_id <= num_members):
        return 0

    member_position = ptrs[member_id]  # 获取内存索引（1-based）
    # 检查内存索引是否有效
    if not (1 <= member_position < len(members)):
        return 0
    slot = members[member_position].SlotId
    return slot


def get_element_path(element_id: int, system_dir: str) -> str:
    slot = get_slot(element_id, system_dir)
    print(f"Element ID {element_id} 对应的 Slot ID 是 {slot}")
    return get_element_path_by_slot(slot, system_dir)


# ===========================================================================

# 组件类型头 -> (长度, 名称)
COMPONENT_TYPES = {
    7181: (29, "HTML"),
    7184: (29, "WebView"),
    8704: (35, "Text"),  # NoFile，直接存文本注册表
    7436: (30, "RTF"),
    8705: (35, "Spelling"),
    6402: (26, "Image"),
    12291: (49, "Sound"),
    7940: (32, "Video"),
    6917: (28, "ShapeEllipse"),
    6918: (28, "ShapeRect"),
    6919: (28, "ShapeRoundedRect"),
}


# RegistryLinkType 表示链接类型
class RegistryLinkType(IntEnum):
    DELETED = 0
    RTF = 1
    FILE_AND_RTX = 2
    RTX = 3
    FILE = 5


class ElementType(IntEnum):
    TOPIC = 0  # 主题/文章
    ITEM = 1  # 项目（问答/填空）
    TASK = 2  # 任务
    TEMPLATE = 3  # 模板
    CONCEPT_GROUP = 4  # 概念组


class ElementStatus(IntEnum):
    PENDING = 0  # 不在学习队列，等待处理
    MEMORIZED = 1  # 在学习队列，会按时复习
    DISMISSED = 2  # 遗忘：既不在学习队列也不在待处理队列
    DELETED = 3  # 已删除（仅占位）


def parse_elinfo(file_path):
    """解析 ElementInfo.dat，返回记录列表（包含 index, element_id, element_type, componPos）"""
    results = []
    index = 0

    RECORD_SIZE = 118
    RECORD_STRUC = struct.Struct("< B B I I 108x")

    with open(file_path, "rb") as f:
        while True:
            data = f.read(RECORD_SIZE)
            if len(data) < RECORD_SIZE:
                break
            unpacked = RECORD_STRUC.unpack(data[: RECORD_STRUC.size])
            element_type = unpacked[0]  # 0: Topic, 1: Item, 4: Concept
            componPos = unpacked[3]
            # 转换为有符号整数（componPos 可为 -1）
            if componPos >= 2**31:
                componPos -= 2**32
            results.append(
                {
                    "index": index,
                    "element_id": index + 1,
                    "element_type": element_type,
                    "componPos": componPos,
                }
            )
            index += 1
    return results


def get_registry_id_from_compon(compon_path, compon_pos):
    """
    根据 componPos（组件组起始偏移）从 compon.dat 中解析组件组，
    找到类型为 0x0D1C 的 HTML 组件，并返回其 registryId。
    若失败或找不到，则返回 None。
    """
    if compon_pos == -1:
        return None

    try:
        with open(compon_path, "rb") as f:
            f.seek(compon_pos)

            # 1. 读取组头（11字节）
            header_data = f.read(11)
            if len(header_data) < 11:
                return None

            # 解析组头字段
            skip_offset = struct.unpack("<H", header_data[9:11])[
                0
            ]  # 到第一个组件的偏移

            # 2. 定位到第一个组件
            first_comp_offset = compon_pos + 11 + skip_offset
            f.seek(first_comp_offset)

            # 读取组件类型
            type_data = f.read(2)
            if len(type_data) < 2:
                return None
            comp_type = struct.unpack("<H", type_data)[0]

            if comp_type == 7181:  # HTML 组件
                # 组件数据长度固定为 29 字节 (InfComponentsHtml17)
                # 读取组件数据（也可直接 seek 到 registryId 位置）
                f.seek(first_comp_offset + 2 + 18)  # 类型后 + 偏移18
                reg_id_data = f.read(4)
                if len(reg_id_data) == 4:
                    registry_id = struct.unpack("<i", reg_id_data)[0]
                    return registry_id
                else:
                    return None
            if comp_type == 7184:  # WV 组件
                # 组件数据长度固定为 29 字节 (InfComponentsHtml17)
                # 读取组件数据（也可直接 seek 到 registryId 位置）
                f.seek(first_comp_offset + 2 + 18)  # 类型后 + 偏移18
                reg_id_data = f.read(4)
                if len(reg_id_data) == 4:
                    registry_id = struct.unpack("<i", reg_id_data)[0]
                    return registry_id
                else:
                    return None

            return None
    except (OSError, IOError):
        return None


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


if __name__ == "__main__":
    # 请根据实际路径修改
    elinfo_path = r"D:\SuperMemo\systems\Reading-And-Review\info\ElementInfo.dat"
    compon_path = r"D:\SuperMemo\systems\Reading-And-Review\info\compon.dat"  # 假设 compon.dat 在同一 systems 目录下
    max_records = 50

    records = parse_elinfo(elinfo_path)
    line = []
    line.append(f"共加载 {len(records)} 条 ElementInfo 记录，测试前 {max_records} 条\n")
    line.append("ID\tregistryId")
    for rec in records:
        reg_id = get_registry_id_from_compon(compon_path, rec["componPos"])
        if reg_id is not None:
            line.append(f"{rec['element_id']}\t{str(reg_id)}")
        else:
            line.append(f"{rec['element_id']}\t{'None'}")
    with open("compon_path.txt", "w", encoding="utf-8") as f:
        f.write("\n".join(line))
    print("测试完成，结果已写入 compon_path.txt")

    # https://github.com/supermemo/SuperMemoAssistant/blob/develop/src/Core/SuperMemoAssistant.Core/SuperMemo/SuperMemo17/Files/InfComponentsElem17.cs
    # ElementInfo.dat，行号下标就是元素id，删除和添加元素不会行号下标都不会变。

    # 组头标记,组长度,未知数据,组件数量,跳过偏移
    # 31D4     5700   00000000 01       2B00
    # 11字节组件组文件头，一个组件组对应一个元素，一个组件组有多个组件

    # 类型头 7181 0x1C0D, 小端：0x0D1C, struct.unpack('<H', data)
    # 组件类型0d1c, 跟上29个固定长度字节，其中 [18，21] 的四个字节是 Pos
    # 0d1c 00 6800 cf00 e225 5d24 ff 0000000000 01 0000 5b070000 00000000000000
    # 101c 00 5700 7800 7b25 6c25 ff 0000000000 01 0000 6f070000 00000000000000
    # HTM和WV一模一样
    # 已知 componPos 偏移
    # 直接打开 compon.dat 文件，定位到 componPos 偏移。
    # 验证组件组头 31D4，读取 length、compCount 等字段。
    # 循环读取组件，对每个组件：
    # 读取 2 字节类型头。
    # 如果是目标类型（7181、8704 或 7184），则读取对应的固定结构体（例如 InfComponentsHtml17 或 InfComponentsText17），提取 registryId 及其他所需字段，然后立即返回。
    # 如果不是目标类型，则根据该类型的结构体大小跳过该组件（因为结构体长度固定，可直接 Seek 跳过）。
    # 如果循环结束仍未找到，返回空。

    # 跑通了！根本性是文本注册表的Pos在每打开一个元素会因某种情况变动。
    # 可能是看过之后就会变动，然后被更新到组件文件中。
    # 但是当前浏览的元素的文本注册表的Pos，也会随后更新到compon的reg_id里面。
    # 步骤，我想跳转到id，然后执行脚本看Pos.然后在跳id,在执行脚本看Pos,结果上一次的pos已经变了。
    # 原来的pos已经删除，新的pos可以正常访问，而且访问到的内容是正确的。
    # 结论是POS是动态的，在每次切换后就会动态更新到新值。而这个新值是可以在组件文件中访问到。
    # 元素Id也是动态的原来。不过没关系，每次获取即可。

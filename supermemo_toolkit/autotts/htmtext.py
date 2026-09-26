"""
通过窗口句柄获取 SuperMemo 中 IE 控件的 HTML 文档对象
最小化实现，无额外依赖（仅需 pywin32）
"""

import logging

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

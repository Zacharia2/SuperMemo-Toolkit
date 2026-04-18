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


if __name__ == "__main__":
    result = get_supermemo_html_doc_by_win32()
    if result:
        print(result)
    else:
        print("未能获取到内容")

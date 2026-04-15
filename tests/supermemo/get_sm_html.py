"""
通过窗口句柄获取 SuperMemo 中 IE 控件的 HTML 文档对象
最小化实现，无额外依赖（仅需 pywin32）
"""

import win32gui
import win32con
import pythoncom
import win32com.client
import logging

logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


def get_html_doc_from_hwnd(hwnd):
    """从 Internet Explorer_Server 窗口句柄获取 IHTMLDocument2 对象"""
    try:
        # 1. 获取系统预定义的消息 ID：WM_HTML_GETOBJECT
        msg = win32gui.RegisterWindowMessage("WM_HTML_GETOBJECT")

        # 2. 向目标窗口发送消息，得到 LRESULT（包装的 COM 指针）
        result, lpdwResult = win32gui.SendMessageTimeout(
            hwnd, msg, 0, 0, win32con.SMTO_ABORTIFHUNG, 1000
        )
        if not lpdwResult:
            logger.warning(f"SendMessageTimeout 失败，hwnd={hwnd:#x}")
            return None

        # 3. 将 LRESULT 解码为 IDispatch 接口对象
        ob = pythoncom.ObjectFromLresult(lpdwResult, pythoncom.IID_IDispatch, 0)

        # 4. 包装成可用的 Dispatch 对象（自动支持 IHTMLDocument2 接口）
        doc = win32com.client.Dispatch(ob)
        return doc

    except Exception as e:
        logger.exception(f"获取文档对象失败: {e}")
        return None


def find_ie_server_windows(hwnd_parent=None):
    """递归查找指定父窗口下的所有 Internet Explorer_Server 子窗口"""
    windows = []

    def enum_child(hwnd, _):
        if win32gui.GetClassName(hwnd) == "Internet Explorer_Server":
            windows.append(hwnd)
        # 继续递归查找更深层的子窗口
        win32gui.EnumChildWindows(hwnd, enum_child, None)
        return True

    win32gui.EnumChildWindows(hwnd_parent, enum_child, None)
    return windows


if __name__ == "__main__":
    # 设置 COM 多线程模型（必须在 CoInitialize 之前）
    import sys

    sys.coinit_flags = 0  # COINIT_MULTITHREADED
    pythoncom.CoInitialize()

    try:
        # 查找所有 Internet Explorer_Server 窗口（不限定进程，简单粗暴）
        all_ie_windows = find_ie_server_windows()
        logger.info(f"共找到 {len(all_ie_windows)} 个 Internet Explorer_Server 窗口")

        for hwnd in all_ie_windows:
            doc = get_html_doc_from_hwnd(hwnd)
            if doc:
                logger.info(f"成功获取文档，标题: {doc.title}")
                # 打印 body 前 200 个字符
                body_preview = doc.body.innerText[:200].replace("\n", " ")
                logger.info(f"Body 预览: {body_preview}...")
                break  # 找到第一个可用的就退出
        else:
            logger.warning("未找到可用的 HTML 文档对象")

    finally:
        pythoncom.CoUninitialize()

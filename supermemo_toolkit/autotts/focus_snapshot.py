"""
焦点快照：在代码块执行期间临时改变窗口焦点，退出后自动恢复原焦点。
"""

import ctypes
from ctypes import wintypes

user32 = ctypes.windll.user32

# 函数原型
_GetForegroundWindow = user32.GetForegroundWindow
_GetForegroundWindow.argtypes = []
_GetForegroundWindow.restype = wintypes.HWND

_SetForegroundWindow = user32.SetForegroundWindow
_SetForegroundWindow.argtypes = [wintypes.HWND]
_SetForegroundWindow.restype = wintypes.BOOL


class FocusSnapshot:
    """焦点快照上下文管理器，退出时自动恢复原前台窗口"""

    def __init__(self, use_dispatcher: bool = False):
        """
        Args:
            use_dispatcher: 是否在 UI 线程上执行恢复（Python 中通常不需要，
                            保留参数仅为与 C# 版本接口一致）
        """
        self.use_dispatcher = use_dispatcher
        self._hwnd = None

    def __enter__(self):
        # 记录当前前台窗口句柄
        self._hwnd = _GetForegroundWindow()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        if self._hwnd:
            try:
                if self.use_dispatcher:
                    # 模拟在 UI 线程执行：使用 tkinter 或 PyQt 的 invokeLater
                    # 简单起见，这里直接调用，因为 SetForegroundWindow 本身会处理线程
                    pass
                _SetForegroundWindow(self._hwnd)
            except Exception as e:
                print(f"恢复窗口焦点失败 (hwnd={self._hwnd:#x}): {e}")
        return False  # 不抑制异常


# 使用示例
if __name__ == "__main__":
    import time

    # 假设我们打开记事本并等待一下
    import subprocess

    subprocess.Popen("notepad.exe")
    time.sleep(1)

    # 使用焦点快照
    with FocusSnapshot():
        print("临时改变焦点：打开计算器")
        subprocess.Popen("calc.exe")
        time.sleep(2)  # 模拟操作
        print("即将退出 with 块，焦点应恢复到之前的窗口（记事本）")

    time.sleep(1)
    print("焦点已恢复")

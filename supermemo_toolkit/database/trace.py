import ctypes
import os
import time
from collections.abc import Callable
from tkinter import messagebox

import win32api
import win32con
import win32process
from pywinauto.application import Application
from pywinauto.findwindows import ElementNotFoundError

from supermemo_toolkit.database.element_no import ElementNo
from supermemo_toolkit.database.registry import TextRegistry
from supermemo_toolkit.utilscripts import config as smtk_config

# 常量定义
GENERIC_READ = 0x80000000
GENERIC_WRITE = 0x40000000
FILE_SHARE_NONE = 0x00000000  # 关键：不允许任何共享
OPEN_EXISTING = 3
INVALID_HANDLE_VALUE = -1

kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)


def is_kno_locked_ctypes(filepath):
    """
    使用 CreateFileW 以 FILE_SHARE_NONE 模式打开文件来检测锁定状态。
    """
    # 尝试以“独占”方式打开文件：请求读权限，且不允许任何共享
    handle = kernel32.CreateFileW(
        filepath,
        GENERIC_READ,  # 请求读权限
        FILE_SHARE_NONE,  # 不允许其他进程共享
        None,  # 默认安全属性
        OPEN_EXISTING,  # 文件必须存在
        0,  # 默认标志
        None,  # 无模板文件
    )

    if handle == INVALID_HANDLE_VALUE:
        error_code = ctypes.get_last_error()
        # ERROR_SHARING_VIOLATION = 32
        if error_code == 32:  # noqa: SIM103
            # print(f"[ctypes] 文件 {filepath} 已被独占锁定。")
            return True
        else:
            # print(f"[ctypes] 打开文件失败，错误码: {error_code}")
            return False
    else:
        # 成功打开，立即关闭句柄
        kernel32.CloseHandle(handle)
        # print(f"[ctypes] 文件 {filepath} 未被独占锁定。")
        return False


def get_active_kno_path():
    smtk_config_file_path = os.path.join(smtk_config.get_config_dir(), "conf.json")
    sm_location: str = smtk_config.get_config().get(smtk_config.PROGRAM).lower()

    conf_dict = smtk_config.read_config(smtk_config_file_path)
    kno_list = []
    ""
    if smtk_config.KNOS in conf_dict and len(conf_dict[smtk_config.KNOS]) > 0:
        kno_list = []
        for x in [x.values() for x in conf_dict[smtk_config.KNOS]]:
            kno_list.extend(x)
        kno_list = [os.path.normpath(x + ".kno").lower() for x in kno_list]
    col_list = [
        os.path.normpath(os.path.join(sm_location, "systems", y + ".kno").lower())
        for y in [x for x in smtk_config.get_collections_primaryStorage(sm_location)]
    ]
    all_kno_path: list[str] = kno_list + col_list
    for kno_path in all_kno_path:
        if is_kno_locked_ctypes(kno_path):
            return kno_path.removesuffix(".kno")
    return None


def trace(callback: Callable[[int, TextRegistry], any]):
    try:
        app = Application(backend="win32").connect(class_name="TElWind")
        h = win32api.OpenProcess(
            win32con.PROCESS_QUERY_INFORMATION | win32con.PROCESS_VM_READ,
            False,
            app.process,
        )
        arch = 64 if app.is64bit() else 32
        try:
            exe_full_name = os.path.basename(win32process.GetModuleFileNameEx(h, 0))
        finally:
            win32api.CloseHandle(h)

    except Exception as e:  # noqa: BLE001
        if isinstance(e, ElementNotFoundError):
            messagebox.showerror("错误", "SuperMemo 可能未启动\n" + str(e))
        else:
            messagebox.showerror("错误", e)
        return

    active_kno_path = get_active_kno_path()
    if active_kno_path == None:
        return
    reg = TextRegistry(active_kno_path)

    reader = ElementNo(exe_full_name, arch)
    try:
        if not reader.attach():
            print("[ElementNo] 附加进程失败")
            return

        if not reader.locate():
            print("[ElementNo] 扫描失败，未找到有效特征码")
            return

        last_id = None
        while True:
            elem_id = reader.read_id()
            if elem_id is not None and elem_id != last_id:
                last_id = elem_id
                callback(elem_id, reg)
            time.sleep(0.1)
    finally:
        reader.detach()


if __name__ == "__main__":
    # 仅需提供：sm_location，并且打开程序

    def work(id, currEl):
        currEl.refresh(element_id=id)
        print(
            f"[Registry] [No. {id}] Title:{currEl.eTitle[:12]} Path:{currEl.eComponents[1].mPath}"
        )

    trace(work)

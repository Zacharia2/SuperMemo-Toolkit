import ctypes
import os
import re
import struct
import sys
import time
import warnings
from ctypes import wintypes
from tkinter import messagebox

import pymem
import pymem.process
import win32api
import win32con
import win32process
from pywinauto.application import Application
from pywinauto.findwindows import ElementNotFoundError

from supermemo_toolkit.database.element_no import compute_sm_ver

ForceReloading_64 = re.compile(
    # .text	00401000	1000
    # # sm20p33.exe
    # 0x1E26EE1BAB0 这个重启软件会变。
    # + 0x1C4D = 1E26EE1D6FD，ForceReloading
    # + 0x2555 = 1E26EE1E005，MustReloadComponents
    # CE：sm20p33.exe+B42A1B
    # rb"\x48\x8B\x85.{4}"  # mov rax, [rbp+disp32]
    rb"\xC6\x80(.{4})\x01"  # mov byte [rax+1C4Dh], 1 hex:1C4D=int:7245
    rb"\x48\x8B\x8D.{4}"  # mov rcx, [rbp+disp32]
    rb"\xE8.{4}"  # call rel32
    rb"\x48\x0F\xB6\x85.{4}",  # movzx rax, byte ptr [rbp+disp32]
    re.DOTALL,
)
ForceReloading_32 = re.compile(
    # sm18m TElWind_MIEditFileClick->sub_ACE720
    # sm19.1p TElWind_MIEditFileClick->sub_B0E168  00B0E337
    # mov     eax, [ebp+TElWind_Self]
    # mov     byte ptr [eax+0E4Fh], 1
    # mov     eax, [ebp+var_10]
    # call    sub_B50988
    # mov     al, [ebp+var_9]
    # rb"\x8B\x45.{1}"  # mov eax, [ebp+disp8]
    rb"\xC6\x80(.{4})\x01"  # mov byte [eax+disp32], 1
    rb"\x8B\x45.{1}"  # mov eax, [ebp+disp8]
    rb"\xE8.{4}"  # call rel32
    rb"\x8A\x45.{1}",  # mov al, [ebp+disp8]
    re.DOTALL,
)


TElWind_Self_64 = re.compile(
    # TElWind_MIComponentMenuClick CE：sm20p33.exe+B13094
    rb"\x48\x8B\x05(.{4})"  # mov rax, cs:TElWind_Self
    rb"\x48\x0F\xB6\x90.{4}"  # movzx rdx, byte ptr [rax+23EBh] ; Byte_CompNo
    rb"\x4D\x33\xC0",  # xor r8, r8 ; Integer_X
    # xor r9, r9 ; Integer_Y
    # call TElWind_OpenComponentMenu
    re.DOTALL,
)

TElWind_Self_32 = re.compile(
    # TElWind_MIComponentMenuClick
    # push    0               ; Integer_Y
    # mov     eax, ds:TElWind_Self
    # mov     dl, [eax+1265h] ; Byte_CompNo
    # xor     ecx, ecx        ; Integer_X
    # mov     eax, [ebp+TElWind_Self] ; TElWind_Self
    # call    TElWind_OpenComponentMenu
    rb"\xA1(.{4})"  # mov eax, ds:TElWind_Self   (5 字节, 绝对地址)
    rb"\x8A\x90.{4}",  # mov dl, byte ptr [eax+1265h]
    re.DOTALL,
)

_FORCE_RELOADING_SCAN_CONFIG = {
    (32, "sm17"): (TElWind_Self_32, ForceReloading_32),
    (32, "sm18"): (TElWind_Self_32, ForceReloading_32),
    (32, "sm19"): (TElWind_Self_32, ForceReloading_32),
    (64, "sm20"): (TElWind_Self_64, ForceReloading_64),
}


# 定义 MEMORY_BASIC_INFORMATION 结构体
class MEMORY_BASIC_INFORMATION(ctypes.Structure):
    _fields_ = [
        ("BaseAddress", ctypes.c_void_p),
        ("AllocationBase", ctypes.c_void_p),
        ("AllocationProtect", wintypes.DWORD),
        ("RegionSize", ctypes.c_size_t),
        ("State", wintypes.DWORD),
        ("Protect", wintypes.DWORD),
        ("Type", wintypes.DWORD),
    ]


kernel32 = ctypes.WinDLL("kernel32", use_last_error=True)
kernel32.VirtualQueryEx.argtypes = [
    wintypes.HANDLE,
    ctypes.c_void_p,
    ctypes.POINTER(MEMORY_BASIC_INFORMATION),
    ctypes.c_size_t,
]
kernel32.VirtualQueryEx.restype = ctypes.c_size_t


class ForceReload:
    """适配sm17、sm18、sm19、sm20"""

    def __init__(self):
        file_path, app = self._get_exe_info()
        self.process_name = os.path.basename(file_path)
        self.sm_ver: str = compute_sm_ver(file_path)
        self.sm_arch: int = 64 if app.is64bit() else 32
        self.handle = app.window(class_name="TElWind").handle
        self.py_mem: pymem.Pymem = None
        self.base = 0
        self.force_addr = None  # 缓存下来，只扫一次

    def _scan_aob_execute_read_only(self, pattern, is_offset=False):
        """
        只在可执行段 EXECUTE_READ 里扫描特征码，返回所有候选全局变量地址。
        条件: MEM_COMMIT + EXECUTE_READ，且非 PAGE_GUARD。
        """
        process_handle = self.py_mem.process_handle
        mbi = MEMORY_BASIC_INFORMATION()
        address = self.base
        end_address = self.base + self.module_size

        MOV_RAX_RIP_LEN = 7  # 48 8B 05 + disp32  RIP 相对寻址

        candidates = []

        while address < end_address:
            ret = kernel32.VirtualQueryEx(
                process_handle,
                ctypes.c_void_p(address),
                ctypes.byref(mbi),
                ctypes.sizeof(mbi),
            )
            if ret == 0:
                break

            # 只扫已提交且可执行的页
            is_scannable_code = (
                mbi.State == win32con.MEM_COMMIT
                and (mbi.Protect & win32con.PAGE_EXECUTE_READ)
                and not (mbi.Protect & win32con.PAGE_GUARD)
            )
            if is_scannable_code:
                try:
                    data = self.py_mem.read_bytes(mbi.BaseAddress, mbi.RegionSize)
                    for match in re.finditer(pattern, data):
                        if not is_offset:
                            if self.sm_arch == 64:
                                instr_addr = mbi.BaseAddress + match.start()
                                disp = struct.unpack("<i", match.group(1))[0]  # 有符号!
                                # 相对寻址
                                global_var_addr = instr_addr + MOV_RAX_RIP_LEN + disp
                            elif self.sm_arch == 32:
                                global_var_addr = struct.unpack("<I", match.group(1))[0]
                            else:
                                continue
                        else:
                            global_var_addr = struct.unpack("<i", match.group(1))[0]

                        # 去重，避免同一地址重复加入
                        if global_var_addr not in candidates:
                            candidates.append(global_var_addr)
                        # print(len(data) / 1024**2)
                except Exception:  # noqa: BLE001, S110
                    pass

            if mbi.RegionSize == 0:
                break
            address = mbi.BaseAddress + mbi.RegionSize

        return candidates

    def _is_reasonable_offset(self, ptr_addr):
        """验证指针是否指向一个合理的主对象"""
        return 0 <= ptr_addr < 65535

    def attach(self):
        try:
            self.py_mem = pymem.Pymem(self.process_name)
            module = pymem.process.module_from_name(
                self.py_mem.process_handle, self.process_name
            )
            self.base = module.lpBaseOfDll
            self.module_size = module.SizeOfImage
            return True
        except Exception:
            return False

    def detach(self):
        if self.py_mem:
            try:
                self.py_mem.close_process()
            except Exception:  # noqa: BLE001, S110
                pass
            self.py_mem = None

    def locate(self):
        """扫描一次定位全局变量地址，后续直接复用"""
        cfg = _FORCE_RELOADING_SCAN_CONFIG.get((self.sm_arch, self.sm_ver))
        if not cfg:
            return False

        telwind_pattern, force_pattern = cfg
        telwind_candidates = self._scan_aob_execute_read_only(telwind_pattern)
        force_candidates = self._scan_aob_execute_read_only(force_pattern, True)

        if len(telwind_candidates) != 1 or len(force_candidates) != 1:
            return False

        if self.sm_arch == 64:
            telwind_addr = self.py_mem.read_longlong(telwind_candidates[0])
        elif self.sm_arch == 32:
            telwind_addr = self.py_mem.read_uint(telwind_candidates[0])
        if self._is_reasonable_offset(force_candidates[0]):
            self.force_addr = telwind_addr + force_candidates[0]
            return True
        return False

    def read_force_reloading(self):
        if self.force_addr is None:
            return None
        try:
            return bool(self.py_mem.read_bool(self.force_addr))
        except Exception:
            return None

    def set_force_reloading(self):
        if self.force_addr is None:
            return False
        try:
            self.py_mem.write_bool(self.force_addr, True)
            return self.read_force_reloading() is True
        except Exception:
            return False

    def activate_window(self):
        # 仅需设置ForceReloading = 1就可以，然后让主窗口获得焦点即可
        # 仅这些就可以实现消费ForceReloading。需要先设置ForceReloading在发消息才可以
        hwnd = self.handle
        user32 = ctypes.WinDLL("user32", use_last_error=True)
        # 声明函数参数类型，避免 64 位下句柄被截断
        user32.ShowWindow.argtypes = [wintypes.HWND, ctypes.c_int]
        user32.ShowWindow.restype = wintypes.BOOL

        user32.PostMessageW.argtypes = [
            wintypes.HWND,
            wintypes.UINT,
            wintypes.WPARAM,
            wintypes.LPARAM,
        ]
        user32.PostMessageW.restype = wintypes.BOOL

        user32.FindWindowW.argtypes = [wintypes.LPCWSTR, wintypes.LPCWSTR]
        user32.FindWindowW.restype = wintypes.HWND
        if not hwnd:
            return False

        user32.ShowWindow(hwnd, win32con.SW_RESTORE)
        user32.PostMessageW(hwnd, win32con.WM_NULL, 0, 0)
        user32.PostMessageW(hwnd, win32con.WM_NULL, 0, 0)
        user32.PostMessageW(hwnd, win32con.WM_ACTIVATE, win32con.WA_ACTIVE, 0)
        return True

    def _get_exe_info(self):
        try:
            warnings.filterwarnings(
                "ignore", message=".*32-bit application should be automated.*"
            )
            app = Application(backend="win32").connect(class_name="TElWind")
            h = win32api.OpenProcess(
                win32con.PROCESS_QUERY_INFORMATION | win32con.PROCESS_VM_READ,
                False,
                app.process,
            )

            try:
                file_path = win32process.GetModuleFileNameEx(h, 0)
                return (file_path, app)
            finally:
                win32api.CloseHandle(h)

        except Exception as e:  # noqa: BLE001
            if isinstance(e, ElementNotFoundError):
                messagebox.showerror("错误", "SuperMemo 可能未启动\n" + str(e))
            else:
                messagebox.showerror("错误", e)
            sys.exit()

    def __enter__(self):
        print("__enter__")
        self.set_force_reloading()
        return self

    def __exit__(self, exc_type, exc, tb):
        print("__exit__")
        self.activate_window()


if __name__ == "__main__":
    reader = ForceReload()
    try:
        if not reader.attach():
            print("[ForceReload] 附加进程失败")
            sys.exit()

        if not reader.locate():
            print("[ForceReload] 扫描失败，未找到有效特征码")
            sys.exit()
        with reader:
            pass
        while True:
            print(time.asctime(), "ForceReloading::", reader.read_force_reloading())
            time.sleep(1)
            # reader.set_force_reloading()
    finally:
        reader.detach()

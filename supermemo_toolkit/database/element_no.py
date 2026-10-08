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
from watchdog.events import FileSystemEventHandler

_OFF_SM15_16 = rb"\xBC\x03\x00\x00"
_OFF_SM17 = rb"\xC4\x03\x00\x00"
_OFF_SM18_19 = rb"\xF4\x03\x00\x00"
_OFF_SM20 = rb"\x90\x07\x00\x00"


def _CFG_32(off: bytes):
    return (
        re.compile(
            rb"\xA1(?P<ptr>.{4})"  # mov eax, [abs32]
            rb"\x8B\x55."  # mov edx, [ebp+disp8]
            rb"\x89\x90(?P<off>" + off + rb")",  # mov [eax+off], edx
            re.DOTALL,
        ),
        0x7FFFFFFF,
    )


def _CFG_64(off: bytes):
    return (
        re.compile(
            rb"\x48\x8B\x05(?P<ptr>.{4})"  # mov rax, [rip+disp32]
            rb"\x8B\x8D.{4}"  # mov ecx, [rbp+disp32]
            rb"\x89\x88(?P<off>" + off + rb")",  # mov [rax+off], ecx
            re.DOTALL,
        ),
        0x00007FFFFFFFFFFF,
    )


# 15只有HTMFile.htm 、 16及以后版本从有Element#29-Component#1.htm
_PTR_SCAN_CONFIG = {
    (32, "sm15"): _CFG_32(_OFF_SM15_16),
    (32, "sm16"): _CFG_32(_OFF_SM15_16),
    (32, "sm17"): _CFG_32(_OFF_SM17),
    (32, "sm18"): _CFG_32(_OFF_SM18_19),
    (32, "sm19"): _CFG_32(_OFF_SM18_19),
    (64, "sm20"): _CFG_64(_OFF_SM20),
}


def get_file_string_info(path, key):
    try:
        translations = win32api.GetFileVersionInfo(path, r"\VarFileInfo\Translation")
        lang, codepage = translations[0]
        sub_block = f"\\StringFileInfo\\{lang:04x}{codepage:04x}\\{key}"
        file_description: str = win32api.GetFileVersionInfo(path, sub_block)
        return file_description.strip().lower()
    except Exception:
        return None


def compute_sm_ver(file_path):
    product_version = get_file_string_info(file_path, "ProductVersion")
    file_version = get_file_string_info(file_path, "FileVersion")
    file_description = get_file_string_info(file_path, "FileDescription")
    # 15 FileVersionInfo = None
    # 16 ProductVersion = 1.0.0.0、 FileVersion = 1.0.0.0 仅两项。
    if product_version is None and file_version is None and file_description is None:
        return "sm15"
    if (
        product_version == "1.0.0.0"
        and file_version == "1.0.0.0"
        and file_description is None
    ):
        return "sm16"
    if product_version == "17.0":
        if (
            get_file_string_info(file_path, "OriginalFilename") == "sm17.exe"
            and file_version == "17.0.0.0"
            and file_description is None
        ):
            return "sm17"
        if (
            get_file_string_info(file_path, "OriginalFilename") == "sm17.exe"
            and file_version == "17.0.0.0"
            and file_description == "sm18"
        ):
            return "sm18"
    if (
        product_version == "19.0"
        and file_version == "19.0.0.0"
        and file_description == "sm19"
    ):
        return "sm19"

    # 默认情况sm20及最新版本
    return file_description


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


class ElementNo:
    """适配sm15、sm16、sm17、sm18、sm19、sm20"""

    def __init__(self, file_path, arch):
        self.process_name = os.path.basename(file_path)
        self.sm_ver: str = compute_sm_ver(file_path)
        self.sm_arch: int = arch
        self.py_mem: pymem.Pymem = None
        self.base = 0
        self.global_ptr_addr = None  # 缓存下来，只扫一次
        self.ptr_offset = 0
        self.max_ptr = 0

    def _scan_aob_execute_read_only(self, pattern):
        """
        只在可执行段 EXECUTE_READ 里扫描特征码，返回所有候选全局变量地址。
        条件: MEM_COMMIT + EXECUTE_READ，且非 PAGE_GUARD。
        """
        process_handle = self.py_mem.process_handle
        mbi = MEMORY_BASIC_INFORMATION()
        address = self.base
        end_address = self.base + self.module_size

        MEM_COMMIT = 0x1000
        EXECUTE_READ = 0x20
        PAGE_GUARD = 0x100

        candidates = {}

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
            if (
                mbi.State == MEM_COMMIT
                and (mbi.Protect & EXECUTE_READ)
                and not (mbi.Protect & PAGE_GUARD)
            ):
                try:
                    data = self.py_mem.read_bytes(mbi.BaseAddress, mbi.RegionSize)
                    for match in re.finditer(pattern, data):
                        instr_addr = mbi.BaseAddress + match.start()
                        if self.sm_arch == 64:
                            global_var_addr = (
                                instr_addr
                                + 7
                                + struct.unpack("<i", match.group("ptr"))[0]
                            )
                            ptr_offset = struct.unpack("<i", match.group("off"))[0]
                        elif self.sm_arch == 32:
                            global_var_addr = struct.unpack("<I", match.group("ptr"))[0]
                            ptr_offset = struct.unpack("<I", match.group("off"))[0]
                        else:
                            continue

                        # 去重，避免同一地址重复加入
                        if global_var_addr not in candidates:
                            candidates[global_var_addr] = ptr_offset
                        # print(len(data) / 1024**2)
                except Exception:  # noqa: BLE001, S110
                    pass

            if mbi.RegionSize == 0:
                break
            address = mbi.BaseAddress + mbi.RegionSize

        return candidates

    def _validate_object(self, obj_addr):
        """验证指针是否指向一个合理的主对象"""
        if not (0x10000 <= obj_addr < self.max_ptr):
            return False
        if obj_addr % 4 != 0:  # 指针对齐
            return False
        try:
            # 读取 ID，判断是否合理
            eid = self.py_mem.read_uint(obj_addr + self.ptr_offset)
            return ElementNo.is_valid_eid(eid)
        except Exception:
            return False

    @staticmethod
    def is_valid_eid(eid):
        return 0 < eid < 0x7FFFFFFF

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
        cfg = _PTR_SCAN_CONFIG.get((self.sm_arch, self.sm_ver))
        if not cfg:
            return False

        pattern, self.max_ptr = cfg
        candidates = self._scan_aob_execute_read_only(pattern)

        if len(candidates) == 0:
            return False

        for global_var_addr in candidates:
            self.ptr_offset = candidates[global_var_addr]
            try:
                # 校验：读一下对象是否合理
                if self.sm_arch == 64:
                    obj = self.py_mem.read_ulonglong(global_var_addr)
                elif self.sm_arch == 32:
                    obj = self.py_mem.read_uint(global_var_addr)
                else:
                    continue
            except Exception:  # noqa: BLE001, S112
                continue

            if self._validate_object(obj):
                self.global_ptr_addr = global_var_addr
                return True

        # 所有候选都验证失败
        return False

    def read_id(self):
        if self.global_ptr_addr is None:
            return None
        try:
            if self.sm_arch == 64:
                obj = self.py_mem.read_ulonglong(self.global_ptr_addr)
            elif self.sm_arch == 32:
                obj = self.py_mem.read_uint(self.global_ptr_addr)
            if not self._validate_object(obj):
                return None
            return self.py_mem.read_uint(obj + self.ptr_offset)
        except Exception:
            return None


class TempHandler(FileSystemEventHandler):
    """适配sm18、sm19、sm20"""

    PATTERN = re.compile(r"Element#(\d+)-Component#\d+\.htm$", re.IGNORECASE)

    def __init__(self, temp_dir, callback, session_start):
        self.temp_dir = temp_dir
        self.callback = callback
        self.session_start = session_start
        self.seen = {}  # filename -> mtime
        self._init_seen()

    def _init_seen(self):
        """启动时记录所有已有文件的 mtime，并识别当前元素"""
        latest_file = None
        latest_mtime = 0
        try:
            for name in os.listdir(self.temp_dir):
                if not self.PATTERN.search(name):
                    continue
                path = os.path.join(self.temp_dir, name)
                try:
                    mtime = os.path.getmtime(path)
                except OSError:
                    continue
                self.seen[name] = mtime
                if mtime > self.session_start and mtime > latest_mtime:
                    latest_mtime = mtime
                    latest_file = name
        except FileNotFoundError:
            pass

        # 启动时主动识别一次：取 mtime 最新的文件作为当前元素
        if latest_file:
            m = self.PATTERN.search(latest_file)
            self.callback(int(m.group(1)))

    def _process(self, path):
        if not path:
            return
        name = os.path.basename(path)
        if not self.PATTERN.search(name):
            return
        try:
            mtime = os.path.getmtime(path)
        except OSError:
            return
        old = self.seen.get(name)
        # 文件名已存在且 mtime 没变 → 忽略
        if old is not None and mtime <= old:
            return
        # mtime小于启动时间 → 忽略
        if mtime <= self.session_start:
            return
        # 新文件或 mtime 更新 → 触发
        self.seen[name] = mtime
        m = self.PATTERN.search(name)
        self.callback(int(m.group(1)))

    def on_created(self, event):
        if not event.is_directory:
            self._process(event.src_path)

    def on_modified(self, event):
        if not event.is_directory:
            self._process(event.src_path)

    def on_moved(self, event):
        if not event.is_directory:
            self._process(event.dest_path)


if __name__ == "__main__":
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
        arch = 64 if app.is64bit() else 32
        try:
            file_path = win32process.GetModuleFileNameEx(h, 0)
        finally:
            win32api.CloseHandle(h)

    except Exception as e:  # noqa: BLE001
        if isinstance(e, ElementNotFoundError):
            messagebox.showerror("错误", "SuperMemo 可能未启动\n" + str(e))
        else:
            messagebox.showerror("错误", e)
        sys.exit()

    reader = ElementNo(file_path, arch)
    try:
        if not reader.attach():
            print("[ElementNo] 附加进程失败")
            sys.exit()

        if not reader.locate():
            print("[ElementNo] 扫描失败，未找到有效特征码")
            sys.exit()

        last_id = None
        while True:
            if not app.is_process_running():
                break

            elem_id = reader.read_id()
            if elem_id is not None and elem_id != last_id:
                last_id = elem_id
                print(f"[ElementNo] [No. {elem_id}] ")
            time.sleep(0.1)
    finally:
        reader.detach()

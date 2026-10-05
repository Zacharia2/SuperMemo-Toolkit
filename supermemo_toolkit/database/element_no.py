import ctypes
import re
import struct
from ctypes import wintypes

import pymem
import pymem.process

PTR_SCAN_CONFIG = {
    64: (
        re.compile(
            rb"\x48\x8B\x05([\x00-\xFF]{4})\x8B\x8D[\x00-\xFF]{4}\x89\x88\x90\x07\x00\x00",
        ),
        0x790,
        0x00007FFFFFFFFFFF,
    ),
    32: (
        re.compile(
            rb"\xA1([\x00-\xFF]{4})\x8B\x55[\x00-\xFF]\x89\x90\xF4\x03\x00\x00",
        ),
        0x3F4,
        0x7FFFFFFF,
    ),
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


def scan_aob_execute_read_only(pm, base_address, module_size, pattern, arch):
    """
    只在可执行段EXECUTE_READ里扫描特征码。条件: MEM_COMMIT + EXECUTE_READ
    """
    process_handle = pm.process_handle
    mbi = MEMORY_BASIC_INFORMATION()
    address = base_address
    end_address = base_address + module_size

    MEM_COMMIT = 0x1000
    EXECUTE_READ = 0x20
    PAGE_GUARD = 0x100

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
                data = pm.read_bytes(mbi.BaseAddress, mbi.RegionSize)
                for match in re.finditer(pattern, data):
                    instr_addr = mbi.BaseAddress + match.start()
                    if arch == 64:
                        rel_bytes = match.group(1)
                        rel_offset = struct.unpack("<i", rel_bytes)[0]
                        global_var_addr = instr_addr + 7 + rel_offset
                    elif arch == 32:
                        abs_bytes = match.group(1)
                        global_var_addr = struct.unpack("<I", abs_bytes)[0]
                    return global_var_addr
            except Exception:  # noqa: BLE001, S110
                pass

        if mbi.RegionSize == 0:
            break
        address = mbi.BaseAddress + mbi.RegionSize

    return None


def validate_object(pm, obj_addr, ptr_offset, max_ptr):
    """验证指针是否指向一个合理的主对象"""
    if not (0x10000 <= obj_addr < max_ptr):
        return False
    try:
        # 读取 ID，判断是否合理
        eid = pm.read_uint(obj_addr + ptr_offset)
        return eid < 0x7FFFFFFF
    except Exception:
        return False


class ElementNo:
    def __init__(self, process_name, arch):
        self.process_name = process_name
        self.arch = arch
        self.py_mem = None
        self.base = 0
        self.global_ptr_addr = None  # 缓存下来，只扫一次
        self.ptr_offset = 0
        self.max_ptr = 0

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
        pattern, self.ptr_offset, self.max_ptr = PTR_SCAN_CONFIG.get(self.arch)
        addr = scan_aob_execute_read_only(
            self.py_mem, self.base, self.module_size, pattern, self.arch
        )
        if not addr:
            return False

        # 校验：读一下对象是否合理
        if self.arch == 64:
            obj = self.py_mem.read_ulonglong(addr)
        elif self.arch == 32:
            obj = self.py_mem.read_uint(addr)

        if not validate_object(self.py_mem, obj, self.ptr_offset, self.max_ptr):
            return False

        self.global_ptr_addr = addr
        return True

    def read_id(self):
        if self.global_ptr_addr is None:
            return None
        try:
            if self.arch == 64:
                obj = self.py_mem.read_ulonglong(self.global_ptr_addr)
            elif self.arch == 32:
                obj = self.py_mem.read_uint(self.global_ptr_addr)
            if not (0x10000 <= obj < self.max_ptr):
                return None
            return self.py_mem.read_uint(obj + self.ptr_offset)
        except Exception:
            return None

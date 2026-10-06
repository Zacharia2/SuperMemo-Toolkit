import ctypes
import os
import re
import struct
from ctypes import wintypes

import pymem
import pymem.process
import win32api
from watchdog.events import FileSystemEventHandler

# 32 位：SuperMemo 18 / 19
_CFG_32 = (
    re.compile(
        rb"\xA1([\x00-\xFF]{4})"  # mov eax, [abs32]
        rb"\x8B\x55[\x00-\xFF]"  # mov edx, [ebp+disp8]
        rb"\x89\x90\xF4\x03\x00\x00"  # mov [eax+0x3F4], edx
    ),
    0x3F4,
    0x7FFFFFFF,
)

# 64 位：SuperMemo 20
_CFG_64 = (
    re.compile(
        rb"\x48\x8B\x05([\x00-\xFF]{4})"  # mov rax, [rip+disp32]
        rb"\x8B\x8D[\x00-\xFF]{4}"  # mov ecx, [rbp+disp32]
        rb"\x89\x88\x90\x07\x00\x00"  # mov [rax+0x790], ecx
    ),
    0x790,
    0x00007FFFFFFFFFFF,
)

_PTR_SCAN_CONFIG = {
    (32, "sm18"): _CFG_32,
    (32, "sm19"): _CFG_32,
    (64, "sm20"): _CFG_64,
}


def get_file_string_info(path, key):
    try:
        translations = win32api.GetFileVersionInfo(path, r"\VarFileInfo\Translation")
        lang, codepage = translations[0]
        sub_block = f"\\StringFileInfo\\{lang:04x}{codepage:04x}\\{key}"
        return win32api.GetFileVersionInfo(path, sub_block)
    except Exception:
        return None


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
    只在可执行段 EXECUTE_READ 里扫描特征码，返回所有候选全局变量地址。
    条件: MEM_COMMIT + EXECUTE_READ，且非 PAGE_GUARD。
    """
    process_handle = pm.process_handle
    mbi = MEMORY_BASIC_INFORMATION()
    address = base_address
    end_address = base_address + module_size

    MEM_COMMIT = 0x1000
    EXECUTE_READ = 0x20
    PAGE_GUARD = 0x100

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
                    else:
                        continue

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


def validate_object(pm, obj_addr, ptr_offset, max_ptr):
    """验证指针是否指向一个合理的主对象"""
    if not (0x10000 <= obj_addr < max_ptr):
        return False
    if obj_addr % 4 != 0:  # 指针对齐
        return False
    try:
        # 读取 ID，判断是否合理
        eid = pm.read_uint(obj_addr + ptr_offset)
        return eid < 0x7FFFFFFF
    except Exception:
        return False


class ElementNo:
    def __init__(self, file_path, arch):
        self.process_name = os.path.basename(file_path)
        # sm18、sm19、sm20
        self.file_description = get_file_string_info(file_path, "FileDescription")
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
        cfg = _PTR_SCAN_CONFIG.get((self.arch, self.file_description))
        if not cfg:
            return False

        pattern, self.ptr_offset, self.max_ptr = cfg
        candidates = scan_aob_execute_read_only(
            self.py_mem, self.base, self.module_size, pattern, self.arch
        )
        if not len(candidates) > 0:
            return False

        for addr in candidates:
            try:
                # 校验：读一下对象是否合理
                if self.arch == 64:
                    obj = self.py_mem.read_ulonglong(addr)
                elif self.arch == 32:
                    obj = self.py_mem.read_uint(addr)
                else:
                    continue
            except Exception:  # noqa: BLE001, S112
                continue

            if validate_object(self.py_mem, obj, self.ptr_offset, self.max_ptr):
                self.global_ptr_addr = addr
                return True

        # 所有候选都验证失败
        return False

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


class TempHandler(FileSystemEventHandler):
    PATTERN = re.compile(r"Element#(\d+)-Component#\d+\.htm$", re.IGNORECASE)

    def __init__(self, temp_dir, callback):
        self.temp_dir = temp_dir
        self.callback = callback
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
                if mtime > latest_mtime:
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
        # 文件名已存在且 mtime 没变 → 遗留文件，忽略
        if old is not None and mtime <= old:
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

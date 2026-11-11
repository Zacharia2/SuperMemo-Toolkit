import ctypes
import logging
import os
import re
import struct
import time
from ctypes import wintypes

import pymem
import pymem.process
import win32con
from pymem.exception import MemoryReadError, ProcessError
from watchdog.events import FileSystemEventHandler

from supermemo_toolkit.utilscripts.connector import (
    SuperMemoNotAvailable,
    supermemo,
)


class MemoryScanFailed(RuntimeError):
    """pymem 附加失败或 AOB 扫描失败。"""


# 当时用的CE定位的
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
    """适配 sm15/sm16/sm17/sm18/sm19/sm20。"""

    def __init__(self, retry: int = 20):
        if supermemo.ensure_snapshot() is None:
            raise SuperMemoNotAvailable("SuperMemo 未启动")

        self._snap = None
        self._scan_failed_identity = None
        self._ever_located = False  # 本 identity 内是否成功定位过
        self.process_name = ""
        self.sm_ver = ""
        self.sm_arch = 0
        self.telwind_hwnd = None
        self.py_mem: pymem.Pymem | None = None
        self.base = 0
        self.module_size = 0
        self.global_ptr_addr = None
        self.ptr_offset = 0
        self.max_ptr = 0

        if not self._refresh(retry=retry):
            raise MemoryScanFailed("附加进程/扫描特征码失败")

    def _refresh(self, retry: int = 0) -> bool:
        """从 connector 拉取最新快照，必要时 attach / locate，维持可读状态。

        语义（配合「SM 关闭即等待、重开即重建」）：
        - snapshot 为 None：SM 已关闭 → detach，等待下次打开。
        - identity 变化：SM 重启 → detach 旧绑定，为新 identity 重建。
        - fast path：地址有效 → 直接返回。
        - 硬失败缓存：某 identity 从未定位成功且重试耗尽 → 本 identity 内不再重扫。
        - 软失败：曾定位成功但本次 locate 偶发失败 → 不缓存，下次 tick 重试。
        """
        snap = supermemo.snapshot
        if snap is None:
            # SM 已关闭：释放句柄，等待下次打开
            self.detach()
            return False

        # identity 变化（SM 重启）：释放旧绑定，下面为新 identity 重建
        if self._snap is not None and self._snap.identity != snap.identity:
            self.detach()

        # 该 identity 已判定为"扫不出来"：不再 attach，等 SM 重启
        if self._scan_failed_identity == snap.identity and self.global_ptr_addr is None:
            return False

        # fast path（identity 已在上面校验，地址必然属于当前会话）
        if self.global_ptr_addr is not None:
            return True

        # 需要 attach（首次 / detach 后 / 重建）
        if self.py_mem is None:
            self._snap = snap
            self.process_name = snap.process_name
            self.sm_ver = snap.sm_ver
            self.sm_arch = snap.bitness
            self.telwind_hwnd = snap.telwind_hwnd
            self._ever_located = False

            if not self.attach():
                self.detach()
                return False

            # attach 打开的是 snap.pid；若期间进程已重启，identity 会变
            cur = supermemo.snapshot
            if cur is None or cur.identity != self._snap.identity:
                self.detach()
                return False

        # locate
        if self.locate():
            self._ever_located = True
            self._scan_failed_identity = None
            return True

        # 曾定位成功过 → 本次偶发失败，不清地址、不缓存，下次 tick 重试
        if self._ever_located:
            return False

        # 从未成功 → 按 retry 重试（SM 可能刚启动、内存尚未就绪）
        for _ in range(retry):
            time.sleep(1.5)
            cur = supermemo.snapshot
            if cur is None or cur.identity != self._snap.identity:
                self.detach()
                return False
            if self.locate():
                self._ever_located = True
                self._scan_failed_identity = None
                return True

        # 仅当主动重试过（retry > 0）才认为是硬失败并缓存；
        # retry == 0 的调用（如 read_id）不写缓存，交给下次 tick 再试。
        if retry > 0:
            self._scan_failed_identity = snap.identity
        self.detach()
        return False

    def _scan_aob_execute_read_only(self, pattern):
        """
        只在可执行段 EXECUTE_READ 里扫描特征码，返回所有候选全局变量地址。
        条件: MEM_COMMIT + EXECUTE_READ，且非 PAGE_GUARD。
        """
        process_handle = self.py_mem.process_handle
        mbi = MEMORY_BASIC_INFORMATION()
        address = self.base
        end_address = self.base + self.module_size

        MOV_RAX_RIP_LEN = 7  # 48 8B 05 + disp32  RIP 相对寻址

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
            is_scannable_code = (
                mbi.State == win32con.MEM_COMMIT
                and (mbi.Protect & win32con.PAGE_EXECUTE_READ)
                and not (mbi.Protect & win32con.PAGE_GUARD)
            )
            if is_scannable_code:
                try:
                    data = self.py_mem.read_bytes(mbi.BaseAddress, mbi.RegionSize)
                    for match in re.finditer(pattern, data):
                        instr_addr = mbi.BaseAddress + match.start()
                        if self.sm_arch == 64:
                            # 64 位 RIP 相对寻址、目标地址计算instr + MOV_RAX_RIP_LEN + disp32（有符号）
                            # 读取全局指针 read_longlong（8 字节）
                            global_var_addr = (
                                instr_addr
                                + MOV_RAX_RIP_LEN
                                + struct.unpack("<i", match.group("ptr"))[0]
                            )
                            ptr_offset = struct.unpack("<i", match.group("off"))[0]
                        elif self.sm_arch == 32:
                            # 32 位 绝对地址、目标地址计算disp32（直接就是地址，无符号）
                            # 读取全局指针 read_uint（4 字节）
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
        except (TypeError, MemoryReadError, ProcessError):
            return False

    @staticmethod
    def is_valid_eid(eid):
        return 0 < eid < 0x7FFFFFFF

    def attach(self):
        try:
            logging.getLogger("pymem").setLevel(logging.WARNING)
            self.py_mem = pymem.Pymem(self._snap.pid)
            if self.py_mem.process_id != self._snap.pid:
                return False
            module = pymem.process.module_from_name(
                self.py_mem.process_handle, self._snap.process_name
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
        self.global_ptr_addr = None
        self._snap = None

    def locate(self):
        """扫描一次定位全局变量地址，后续直接复用"""
        self.global_ptr_addr = None  # 任何失败路径都保持 None
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

        return False

    def read_id(self):
        if not self._refresh(retry=0):
            return None
        try:
            if self.sm_arch == 64:
                obj = self.py_mem.read_ulonglong(self.global_ptr_addr)
            elif self.sm_arch == 32:
                obj = self.py_mem.read_uint(self.global_ptr_addr)
            else:
                return None
        except (TypeError, MemoryReadError, ProcessError):
            # 读全局指针本身失败 → 地址可能失效，下次 _refresh 重 locate
            self.global_ptr_addr = None
            return None

        # 对象暂时无效（如当前无元素）→ 保留地址，下次再读
        if not self._validate_object(obj):
            return None

        try:
            return self.py_mem.read_uint(obj + self.ptr_offset)
        except (TypeError, MemoryReadError, ProcessError):
            # 对象在读 eid 期间失效（元素切换）→ 保留地址，下次重读
            return None


class TempHandler(FileSystemEventHandler):
    """适配 sm18/sm19/sm20。"""

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
    reader = ElementNo()
    try:
        last_id = None
        while True:
            if supermemo.snapshot is None:
                break

            elem_id = reader.read_id()
            if elem_id is not None and elem_id != last_id:
                last_id = elem_id
                print(f"[ElementNo] [No. {elem_id}] ")
            time.sleep(0.1)
    finally:
        reader.detach()

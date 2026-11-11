import os
import sys
import time
from collections.abc import Callable
from pathlib import Path
from typing import Literal

from pywinauto.findwindows import ElementNotFoundError
from watchdog.observers import Observer

from supermemo_toolkit.database.element_no import (
    ElementNo,
    MemoryScanFailed,
    TempHandler,
)
from supermemo_toolkit.database.registry import TextRegistry
from supermemo_toolkit.utilscripts import config
from supermemo_toolkit.utilscripts.connector import SuperMemoNotAvailable, supermemo
from supermemo_toolkit.utilscripts.ulils import is_collection_active


def make_link(text: str, url: str) -> str:
    if text == "":
        return "None"
    if not sys.stdout.isatty():
        return f"{text} ({url})"
    return f"\033]8;;{url}\033\\{text}\033]8;;\033\\"


class Trace:
    def __init__(self):
        self.__stoped = False
        self.his_id = []
        self.telwind_hwnd: int | None = supermemo.telwind_hwnd
        self.app = supermemo.app

    def _get_active_kno_path(self):
        smtk_config_file_path = os.path.join(config.config_dir(), "conf.json")
        sm_location: str = config.read_smtk_conf().get(config.PROGRAM).lower()

        conf_dict = config.read_config(smtk_config_file_path)
        kno_list = []
        if config.KNOS in conf_dict and len(conf_dict[config.KNOS]) > 0:
            kno_list = []
            for x in [x.values() for x in conf_dict[config.KNOS]]:
                kno_list.extend(x)
            kno_list = [os.path.normpath(x + ".kno").lower() for x in kno_list]
        col_list = [
            os.path.normpath(os.path.join(sm_location, "systems", y + ".kno").lower())
            for y in config.get_collections_primaryStorage(sm_location)
        ]
        all_kno_path = kno_list + col_list
        for kno_path in all_kno_path:
            if is_collection_active(Path(kno_path)):
                return kno_path.removesuffix(".kno")
        return None

    def trace_with_mem(
        self, callback: Callable[[int, TextRegistry], any], watch: bool = False
    ):
        if watch:
            if getattr(self, "_watch_running", False):
                return
            self._watch_running = True

        def _track_one(active_kno_path: str, should_abort=None) -> bool:
            """追踪单个 kno。

            返回值语义：
              - True  : 回监听（watch 模式下集合失活 / 进程退出，但应继续等下一个）
              - False : 整体退出（用户停止，或非 watch 模式下进程退出）

            判定顺序（关键修复）：
              1. 用户主动停止      → 整体退出
              2. 集合失活          → 回监听
              3. SM 进程退出/重启  → watch 模式回监听；非 watch 模式整体退出

            为什么顺序很重要：
              SM 关闭时 .kno 的独占锁先释放，SuperMemo 进程完全退出稍晚，
              两者之间存在几十到几百毫秒的窗口。若先判 is_process_running()，
              就会在窗口外误判为「整体退出」。两个进程并发追踪时相位错开，
              几乎必有一个落在窗口外，表现为「一开一关就只剩一个命令还活着」。

            为什么用局部 track_identity 而非 reader._snap：
              ElementNo 在 SM 重启时会自愈（detach + 重建），其 _snap 在追踪
              期间可能被更新，无法作为「追踪起点会话」的参照；且 SM 关闭时
              _snap 会变 None，直接访问会 AttributeError。
            """
            try:
                reader = ElementNo()
            except SuperMemoNotAvailable:
                return should_abort is not None
            except MemoryScanFailed as e:
                print(f"[Trace] {e}")
                return should_abort is not None

            # 追踪开始时锁定会话身份。SM 重启（identity 变化）即退出 _track_one，
            # 由外层 watch 循环重新确定当前激活的 kno。
            track_identity = supermemo.identity

            self.telwind_hwnd = reader.telwind_hwnd
            self.app = supermemo.app
            text_reg = TextRegistry(active_kno_path)
            try:
                last_id = None
                while True:
                    # 1) 用户主动停止
                    if self.__stoped:
                        return False

                    # 2) 集合失活 → 回监听（仅 watch 模式会传 should_abort）
                    if should_abort is not None and should_abort():
                        return True

                    # 3) SM 进程退出或重启
                    cur = supermemo.snapshot
                    if cur is None or cur.identity != track_identity:
                        # watch 模式：进程没了但应继续等下一个集合 → 回监听
                        if should_abort is not None:  # noqa: SIM103
                            return True
                        # 非 watch 模式：进程没了 → 整体退出
                        return False

                    elem_id = reader.read_id()
                    if elem_id is not None and elem_id != last_id:
                        last_id = elem_id
                        text_reg.refresh(element_id=elem_id)
                        if text_reg.eId is None:
                            time.sleep(0.5)
                            # 同样的判定顺序，避免刚 sleep 完 SM 已重启/退出被误判
                            if self.__stoped:
                                return False
                            if should_abort is not None and should_abort():
                                return True
                            cur = supermemo.snapshot
                            if cur is None or cur.identity != track_identity:
                                # watch 模式：进程没了但应继续等下一个集合 → 回监听
                                if should_abort is not None:  # noqa: SIM103
                                    return True
                                # 非 watch 模式：进程没了 → 整体退出
                                return False
                        if callback(text_reg):
                            self.set_running(False)
                    time.sleep(0.1)
            finally:
                reader.detach()

        try:
            # 常规模式：取一次激活的 kno，追踪到底（不检查中途失活，与原逻辑一致）
            if not watch:
                active_kno_path = self._get_active_kno_path()
                if active_kno_path is None:
                    return
                _track_one(active_kno_path)
                return

            # 监控模式：监听 → 追踪 → 失活/切换后回到监听
            last_kno_path = None
            while not self.__stoped:
                # 如果 SM 进程没启动，先等它启动再继续
                # 把停止信号传给 wait_until_running，保证后台线程能被 stop_trace() 立即唤醒
                if not supermemo.wait_until_running(
                    stop_check=lambda: bool(self.__stoped)
                ):
                    return

                active_kno_path = self._get_active_kno_path()
                if active_kno_path is None or active_kno_path == last_kno_path:
                    time.sleep(0.5)
                    continue
                last_kno_path = active_kno_path
                kno_file = Path(active_kno_path + ".kno")

                def _kno_inactive(_f=kno_file):
                    return not is_collection_active(_f)

                if not _track_one(active_kno_path, should_abort=_kno_inactive):
                    return  # 整体退出
                last_kno_path = None  # 回监听
        finally:
            if watch:
                self._watch_running = False

    def trace_with_observer(self, callback: Callable[[int, TextRegistry], any]):
        snap = supermemo.ensure_snapshot()
        if snap is None:
            from tkinter import messagebox

            err = supermemo.last_error
            if isinstance(err, ElementNotFoundError):
                messagebox.showerror("错误", "SuperMemo 可能未启动\n" + str(err))
            else:
                messagebox.showerror("错误", str(err) if err else "无法连接 SuperMemo")
            return

        self.telwind_hwnd = snap.telwind_hwnd
        self.app = snap.app

        active_kno_path = self._get_active_kno_path()
        if active_kno_path is None:
            return
        text_reg = TextRegistry(active_kno_path)

        def on_element_changed(elem_id):
            # print(f"[TempHandler] [No. {elem_id}]")
            text_reg.refresh(element_id=elem_id)
            if text_reg.eId is None:
                time.sleep(0.5)
                if supermemo.snapshot is None:
                    return
            callback(text_reg)

        observer = Observer()
        temp_dir = os.path.join(active_kno_path, "temp")
        handler = TempHandler(temp_dir, on_element_changed, snap.process_start_ts)
        observer.schedule(handler, temp_dir, recursive=False)
        observer.start()
        try:
            while True:
                if supermemo.snapshot is None:
                    return
                if supermemo.identity != snap.identity:
                    # SuperMemo 重启（pid 复用也会被 process_start_ts 拦住）
                    return
                if self.__stoped:
                    return
                time.sleep(0.1)
        finally:
            observer.stop()
            observer.join()

    def trace_with_id(self, elem_id):
        active_kno_path = self._get_active_kno_path()
        if active_kno_path is None:
            print("没有正在活动的集合")
            return None
        text_reg = TextRegistry(active_kno_path)
        text_reg.refresh(element_id=elem_id)
        if text_reg.eId is None:
            return None
        return text_reg

    def set_running(self, running: bool = True):
        """True 表示继续运行，False 表示停止。"""
        self.__stoped = not running

    def print_info(self, mode: Literal["o", "m"] = "m", watch: bool = False):

        def _printf(text_reg: TextRegistry):
            if text_reg.eId is None:
                return

            self.his_id.append(text_reg.eId)
            path = text_reg.get_component().Path
            position = text_reg.get_component().Position

            # 把本地路径转成 file:// URL
            try:
                url = Path(path).resolve().as_uri()
            except Exception:  # noqa: BLE001
                url = path  # 如果本来就是 URL，就直接用

            path_link = make_link(path, url)

            print(
                f"[No. {text_reg.eId}] "
                f"[Type: {text_reg.eType.name}] "
                f"[Title: {text_reg.eTitle[:12].strip()}] "
                f"[Position: {position}] "
                f"[Path: {path_link}]"
            )

        if mode == "o":
            self.trace_with_observer(_printf)
        if mode == "m":
            self.trace_with_mem(_printf, watch)


if __name__ == "__main__":
    # 仅需提供：sm_location，并且打开程序
    Trace().print_info(mode="m")

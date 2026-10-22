import os
import sys
import time
import warnings
from collections.abc import Callable
from pathlib import Path
from tkinter import messagebox
from typing import Literal

import win32api
import win32con
import win32process
from pywinauto.application import Application
from pywinauto.findwindows import ElementNotFoundError
from watchdog.observers import Observer

from supermemo_toolkit.database.element_no import ElementNo, TempHandler
from supermemo_toolkit.database.registry import TextRegistry
from supermemo_toolkit.utilscripts import config
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
        self.telwind_hwnd: int | None = None

    def _get_process_start_timestamp(self, pid):
        """
        返回进程启动时间的 Unix 时间戳（浮点秒），格式同 time.time()
        """
        h = win32api.OpenProcess(win32con.PROCESS_QUERY_LIMITED_INFORMATION, False, pid)
        try:
            info = win32process.GetProcessTimes(h)
            return info["CreationTime"].timestamp()
        finally:
            win32api.CloseHandle(h)

    def _get_active_kno_path(self):
        smtk_config_file_path = os.path.join(config.config_dir(), "conf.json")
        sm_location: str = config.read_smtk_conf().get(config.PROGRAM).lower()

        conf_dict = config.read_config(smtk_config_file_path)
        kno_list = []
        ""
        if config.KNOS in conf_dict and len(conf_dict[config.KNOS]) > 0:
            kno_list = []
            for x in [x.values() for x in conf_dict[config.KNOS]]:
                kno_list.extend(x)
            kno_list = [os.path.normpath(x + ".kno").lower() for x in kno_list]
        col_list = [
            os.path.normpath(os.path.join(sm_location, "systems", y + ".kno").lower())
            for y in [x for x in config.get_collections_primaryStorage(sm_location)]
        ]
        all_kno_path: list[str] = kno_list + col_list
        for kno_path in all_kno_path:
            if is_collection_active(Path(kno_path)):
                return kno_path.removesuffix(".kno")
        return None

    def trace_with_mem(self, callback: Callable[[int, TextRegistry], any]):
        reader = ElementNo()
        self.telwind_hwnd = reader.app.window(class_name="TElWind").handle
        active_kno_path = self._get_active_kno_path()
        if active_kno_path == None:
            return
        text_reg = TextRegistry(active_kno_path)

        try:
            last_id = None
            while True:
                if not reader.app.is_process_running():
                    return
                if self.__stoped:
                    return
                elem_id = reader.read_id()
                if elem_id is not None and elem_id != last_id:
                    last_id = elem_id
                    text_reg.refresh(element_id=elem_id)
                    if text_reg.eId == None:
                        time.sleep(0.5)
                        if not reader.app.is_process_running():
                            return
                        if self.__stoped:
                            return
                    terminate = callback(text_reg)
                    if terminate == True:
                        self.set_running(False)
                time.sleep(0.1)
        finally:
            reader.detach()

    def trace_with_observer(self, callback: Callable[[int, TextRegistry], any]):
        try:
            warnings.filterwarnings(
                "ignore", message=".*32-bit application should be automated.*"
            )
            app = Application(backend="win32").connect(class_name="TElWind")
            self.telwind_hwnd = app.window(class_name="TElWind").handle
        except Exception as e:  # noqa: BLE001
            if isinstance(e, ElementNotFoundError):
                messagebox.showerror("错误", "SuperMemo 可能未启动\n" + str(e))
            else:
                messagebox.showerror("错误", e)
            return

        active_kno_path = self._get_active_kno_path()
        if active_kno_path == None:
            return
        text_reg = TextRegistry(active_kno_path)

        def on_element_changed(elem_id):
            # print(f"[TempHandler] [No. {elem_id}]")
            text_reg.refresh(element_id=elem_id)
            if text_reg.eId == None:
                time.sleep(0.5)
                if not app.is_process_running():
                    return
            callback(text_reg)

        observer = Observer()
        temp_dir = os.path.join(active_kno_path, "temp")
        handler = TempHandler(
            temp_dir, on_element_changed, self._get_process_start_timestamp(app.process)
        )
        observer.schedule(handler, temp_dir, recursive=False)
        observer.start()

        while True:
            if not app.is_process_running():
                return
            if self.__stoped:
                return
            time.sleep(0.1)

    def trace_with_id(self, elem_id):
        active_kno_path = self._get_active_kno_path()
        if active_kno_path == None:
            print("没有正在活动的集合")
            return
        text_reg = TextRegistry(active_kno_path)

        text_reg.refresh(element_id=elem_id)
        if text_reg.eId == None:
            return
        return text_reg

    def set_running(self, running: bool = True):
        """True 表示继续运行，False 表示停止。"""
        self.__stoped = not running

    def print_info(self, mode=Literal["o", "m"]):

        def _printf(text_reg: TextRegistry):
            if text_reg.eId == None:
                return

            self.his_id.append(text_reg.eId)
            path = (
                text_reg.eComponents[1].mPath if len(text_reg.eComponents) > 0 else ""
            )
            position = (
                text_reg.eComponents[1].mPosition
                if len(text_reg.eComponents) > 0
                else None
            )

            # 把本地路径转成 file:// URL
            try:
                url = Path(path).resolve().as_uri()
            except Exception:
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
            self.trace_with_mem(_printf)


if __name__ == "__main__":
    # 仅需提供：sm_location，并且打开程序
    Trace().print_info(mode="m")

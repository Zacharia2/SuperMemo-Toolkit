import sys
import threading
from typing import Callable, Dict, List


class Id:
    def __init__(self):
        self._free: set[int] = set()
        self._used: set[int] = set()

    def apply(self) -> str:
        """
        获取一个新的唯一ID。
        优先从 free_set 中复用，如果没有则生成新的最小整数。
        """
        # 1. 如果 free_set 不为空，从中取出一个 ID
        if self._free:
            tid = min(self._free)
            self._free.remove(tid)
            self._used.add(tid)
            return f"thread_{tid}"

        # 2. 如果 free_set 为空，从 0 开始查找第一个未被注册的整数
        for tid in range(sys.maxsize):
            if tid not in self._used:
                self._used.add(tid)
                return f"thread_{tid}"

        raise Exception("No available ID")

    def __release(self, tid: int) -> None:
        self._used.discard(tid)
        self._free.add(tid)

    def release(self, tid: str) -> None:
        """
        释放一个 ID，将其从已注册集合移至空闲集合。
        """
        self.__release(int(tid.split("thread_")[-1]))

    def to_array(self) -> List[int]:
        """
        返回当前已注册 ID 的列表。
        """
        return list(self._used)


class ThreadController:
    def __init__(self):
        self.threads: Dict[str, tuple[threading.Thread, threading.Event]] = {}
        self.lock = threading.Lock()
        self.reg_id = Id()

    def thread(
        self,
        target_func: Callable[[threading.Event, tuple], None],
        *params,
    ) -> str:
        thread_id = self.reg_id.apply()
        stop_event = threading.Event()

        def wrapped_target(params):
            try:
                target_func(stop_event, *params)
            except Exception as e:
                print(f"[Thread] {thread_id}线程异常, {e}")
                with self.lock:
                    if thread_id in self.threads:
                        self.threads[thread_id] = None
                        # print(f"[Thread] 线程{thread_id}已停止")

        # 设置为守护进程：随主线程结束而强制终止，继承父线程的守护状态，通常不需要join()
        thread = threading.Thread(target=wrapped_target, args=(params,), daemon=True)
        with self.lock:
            self.threads[thread_id] = (thread, stop_event)

        thread.start()
        return thread_id

    def stop(self, thread_id: str):
        with self.lock:
            if thread_id not in self.threads:
                print(f"[Thread] {thread_id}不在线程x信号表中")
                return False
            # threads[thread_id]空的话就说明异常退出了，只在这删除
            elif self.threads[thread_id] is None:
                del self.threads[thread_id]
                self.reg_id.release(thread_id)
                return True
            _, stop_event = self.threads[thread_id]
            # thread_id存在表中且threads[thread_id]非空
            # 通知线程退出、等待线程退出
            # 仅本函数把thread_id从线程x信号表中删除
            stop_event.set()
            # 每个线程都是不一样的，抛弃也没事。
            # 只要信号到位，不继续产生东西清除，清除已经产生的东西就好
            # 主线程不用等待，让这个线程他自己收到信号后自己慢慢停下手中的活就好了
            # thread.join(timeout=1)
            if thread_id in self.threads:
                del self.threads[thread_id]
                self.reg_id.release(thread_id)
                # print(f"[Thread] 线程{thread_id}已停止")
        return True

    def is_alive(self, thread_id: str):
        with self.lock:
            if thread_id not in self.threads:
                print(f"[Thread] {thread_id}不在线程x信号表中")
                return False
            # threads[thread_id]空的话就说明异常退出了
            elif self.threads[thread_id] is None:
                return False
            # thread_id存在表中且threads[thread_id]非空
            thread, _ = self.threads[thread_id]
        return thread.is_alive()

    def join(self, thread_id: str):
        # 这是个阻塞函数
        thread: threading.Thread
        with self.lock:
            if thread_id not in self.threads:
                print(f"[Thread] {thread_id}不在线程x信号表中")
                return
            # threads[thread_id]空的话就说明异常退出了
            elif self.threads[thread_id] is None:
                return
            # thread_id存在表中且threads[thread_id]非空
            thread, _ = self.threads[thread_id]
        thread.join()

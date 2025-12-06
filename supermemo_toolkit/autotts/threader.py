import random
import threading
import time
from typing import Callable, Dict
import uuid


class ThreadController:
    def __init__(self):
        self.threads: Dict[str, tuple[threading.Thread, threading.Event]] = {}
        self.lock = threading.Lock()

    @staticmethod
    def from_uuid(length: int = 8) -> str:
        start_pos = random.randint(0, 32 - length)
        return uuid.uuid4().hex[start_pos : start_pos + length]

    def thread(
        self,
        target_func: Callable[[threading.Event, tuple], None],
        *params,
    ) -> str:
        thread_id = f"thread_{self.from_uuid()}"
        stop_event = threading.Event()

        def wrapped_target(params):
            try:
                target_func(stop_event, *params)
            except Exception as e:
                print(f"线程{thread_id}异常{e}")
            finally:
                with self.lock:
                    if thread_id in self.threads:
                        del self.threads[thread_id]
                        # print(f"[Thread] 线程{thread_id}已停止")

        thread = threading.Thread(target=wrapped_target, args=(params,))
        with self.lock:
            self.threads[thread_id] = (thread, stop_event)

        thread.start()
        return thread_id

    def stop(self, thread_id: str):
        with self.lock:
            if thread_id not in self.threads:
                print(f"[Thread] {thread_id}不在线程x信号表中")
                return False
            thread, stop_event = self.threads[thread_id]
        # 通知线程退出、等待线程退出
        stop_event.set()
        thread.join()
        return True

    def is_alive(self, thread_id: str):
        with self.lock:
            if thread_id not in self.threads:
                print(f"[Thread] {thread_id}不在线程表中")
                return False
            thread, _ = self.threads[thread_id]
        return thread.is_alive()

    def join(self, thread_id: str):
        thread: threading.Thread
        with self.lock:
            if thread_id not in self.threads:
                print(f"[Thread] {thread_id}不在线程表中")
                return
            thread, _ = self.threads[thread_id]
        thread.join()


if __name__ == "__main__":
    # 使用示例
    def worker1(stop_event: threading.Event, *param):
        count = 0
        while not stop_event.is_set():
            print(f"{param[0]},param:{param[1]}: 工作次数 {count}")
            count += 1
            time.sleep(1)

    def worker2(stop_event: threading.Event, *param):
        count = 0
        while not stop_event.is_set():
            print(f"worker2: 工作次数 {count}")
            count += 1
            time.sleep(1)

    tc = ThreadController()

    # 创建多个线程
    id1 = tc.thread(worker1, "worker1", 1)
    id2 = tc.thread(worker2)
    time.sleep(6)
    tc.stop(id2)

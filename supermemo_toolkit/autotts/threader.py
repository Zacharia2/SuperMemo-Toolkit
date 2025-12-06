import random
import threading
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
                return True
            thread, stop_event = self.threads[thread_id]
        # thread_id存在表中且threads[thread_id]非空
        # 通知线程退出、等待线程退出
        # 仅本函数把thread_id从线程x信号表中删除
        stop_event.set()
        # 每个线程都是不一样的，抛弃也没事。
        # 只要信号到位，不继续产生东西清除，清除已经产生的东西就好
        # 主线程不用等待，让这个线程他自己收到信号后自己慢慢停下手中的活就好了
        # thread.join(timeout=1)
        with self.lock:
            if thread_id in self.threads:
                del self.threads[thread_id]
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


# if __name__ == "__main__":
#     # 使用示例
#     def worker1(stop_event: threading.Event, *param):
#         count = 0
#         while not stop_event.is_set():
#             print(f"{param[0]},param:{param[1]}: 工作次数 {count}")
#             count += 1
#             time.sleep(1)

#     def worker2(stop_event: threading.Event, *param):
#         count = 0
#         while not stop_event.is_set():
#             print(f"worker2: 工作次数 {count}")
#             count += 1
#             time.sleep(1)

#     tc = ThreadController()

#     # 创建多个线程
#     id1 = tc.thread(worker1, "worker1", 1)
#     id2 = tc.thread(worker2)
#     time.sleep(6)
#     tc.stop(id2)

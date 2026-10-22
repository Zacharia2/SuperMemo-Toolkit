# supermemo_toolkit/bridge.py
import threading
from collections.abc import Callable
from http.server import BaseHTTPRequestHandler, ThreadingHTTPServer
from urllib.parse import parse_qs, urlparse


class _Handler(BaseHTTPRequestHandler):
    bridge: "Bridge" = None  # 由 Bridge 注入

    def do_GET(self):
        # print(f"[Bridge] {self.path}")
        params = parse_qs(urlparse(self.path).query)
        cid = params.get("cid", [""])[0]
        if self.path.startswith("/save-formula"):
            try:
                self.bridge.handle_save(cid)
            except Exception as e:  # noqa: BLE001
                print(f"[Bridge] save 失败: {e}")
        self.send_response(204)
        self.end_headers()

    def log_message(self, *a):
        pass


class Bridge:
    def __init__(
        self,
        on_save: Callable[[str], bool] | None = None,
        host: str = "127.0.0.1",
        port: int = 0,
    ):
        self.on_save = on_save
        self._srv = ThreadingHTTPServer((host, port), _Handler)
        self._srv.RequestHandlerClass.bridge = self
        self.port = self._srv.server_address[1]
        threading.Thread(target=self._srv.serve_forever, daemon=True).start()

    def handle_save(self, cid: str) -> bool:
        if self.on_save is None:
            return False
        return bool(self.on_save(cid))

    def stop(self):
        self._srv.shutdown()

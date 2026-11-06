import hashlib
import html
import logging
import os
import re
import shutil
import sys
import threading
import time
import uuid
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
from urllib.parse import unquote, urlparse

import magic
import requests
from bs4 import BeautifulSoup
from charset_normalizer import from_bytes
from PIL import Image
from tqdm import tqdm

from supermemo_toolkit.utilscripts import config
from supermemo_toolkit.utilscripts.ulils import makeNameSafe

# ============================================================
# 日志基础设施
# ============================================================
config_dir = config.config_dir()
os.makedirs(config_dir, exist_ok=True)
LOG_FILE = os.path.join(config_dir, "pathpix.log")


def setup_logger():
    """幂等、utf-8、追加写、不向 root 传播。"""
    lg = logging.getLogger("smtk")
    lg.setLevel(logging.INFO)
    if lg.handlers:
        return lg
    lg.propagate = False

    fh = logging.FileHandler(LOG_FILE, mode="a", encoding="utf-8")
    fh.setFormatter(
        logging.Formatter(
            "%(asctime)s [%(levelname)-7s] %(threadName)s %(lineno)d - %(message)s"
        )
    )
    lg.addHandler(fh)

    ch = logging.StreamHandler(sys.stderr)
    ch.setLevel(logging.WARNING)
    ch.setFormatter(logging.Formatter("[%(levelname)s] %(message)s"))
    lg.addHandler(ch)
    return lg


logger = setup_logger()


# ============================================================
# 失败收集 & 扫描豁免
# ============================================================
report_list: list[str] = []
_unreadable_htms: set[str] = set()


def warn(msg: str, htm_path: str | None = None) -> None:
    """轻量警告：不打 traceback，进 report_list。"""
    if htm_path:
        logger.warning("[%s] %s", htm_path, msg, stacklevel=2)
    else:
        logger.warning("%s", msg, stacklevel=2)
    if htm_path:
        report_list.append(htm_path)


def error(
    msg: str, htm_path: str | None = None, *, exc: BaseException | None = None
) -> None:
    """硬错误：有 exc 就带 traceback，进 report_list。"""
    prefix = f"[{htm_path}] " if htm_path else ""
    if exc is not None:
        logger.error("%s%s", prefix, msg, exc_info=exc, stacklevel=2)
    else:
        logger.error("%s%s", prefix, msg, stacklevel=2)
    if htm_path:
        report_list.append(htm_path)


def mark_unreadable(htm_path: str) -> None:
    """扫描失败的文件：本轮不清图，防止误删。"""
    _unreadable_htms.add(os.path.normcase(htm_path))


def reset_report() -> None:
    report_list.clear()
    _unreadable_htms.clear()


# ============================================================
# 手写进度条（TTY 原地刷，非 TTY 降频打行，多线程安全）
# ============================================================
class Progress:
    _lock = threading.Lock()

    def __init__(
        self,
        desc="",
        total=None,
        stream=sys.stderr,
        min_interval=0.05,
        fallback_every=500,
    ):
        self.desc = desc
        self.total = total
        self.stream = stream
        self.min_interval = min_interval
        self.fallback_every = fallback_every
        try:
            self.enabled = stream.isatty()
        except Exception:
            self.enabled = False
        self.n = 0
        self._last_t = 0.0
        self._last_len = 0
        self._t0 = time.monotonic()
        try:
            self._width = shutil.get_terminal_size((80, 24)).columns - 1
        except OSError:
            self._width = 79

    def _fmt(self):
        dt = time.monotonic() - self._t0
        rate = self.n / dt if dt > 0.1 else 0
        if self.total:
            s = f"{self.desc} [{self.n}/{self.total}] ({rate:.0f}/s)"
        else:
            s = f"{self.desc} [{self.n}] ({rate:.0f}/s)"
        return s[: self._width]

    def update(self, n=1):
        self.n += n
        with self._lock:
            if not self.enabled:
                if self.n % self.fallback_every == 0:
                    self.stream.write(self._fmt() + "\n")
                    self.stream.flush()
                return
            now = time.monotonic()
            if now - self._last_t < self.min_interval and self.n != self.total:
                return
            self._last_t = now
            s = self._fmt()
            pad = " " * max(0, self._last_len - len(s))
            self.stream.write("\r\033[K" + s + pad)
            self.stream.flush()
            self._last_len = len(s)

    def close(self):
        with self._lock:
            if self.enabled:
                self.stream.write("\r\033[K")
            else:
                self.stream.write(self._fmt() + "\n")
            self.stream.flush()

    def __enter__(self):
        return self

    def __exit__(self, *a):
        self.close()


# ============================================================
# 彩色输出
# ============================================================
_COLOR = sys.stdout.isatty()
_CODES = {
    "green": "\033[0;32m",
    "red": "\033[0;31m",
    "yellow": "\033[1;33m",
    "reset": "\033[0m",
}


def cprint(msg: str, color: str | None = None):
    if color and _COLOR:
        sys.stdout.write(f"{_CODES[color]}{msg}{_CODES['reset']}\n")
    else:
        sys.stdout.write(f"{msg}\n")
    sys.stdout.flush()


def open_log():
    try:
        if os.name == "nt":
            os.startfile(LOG_FILE)
        else:
            cprint(f"日志文件：{LOG_FILE}")
    except Exception as e:
        cprint(f"无法打开日志 {LOG_FILE}: {e}", "red")


# ============================================================
# 基础工具
# ============================================================
def mkdir(path: str):
    if not os.path.exists(path):
        os.makedirs(path)
        logger.debug("mkdir: %s", path)


def copy_to_elements(file_path: str, target_folder: str) -> str:
    # unescape_fs_path = html.unescape(file_path)
    old_full_file_name = os.path.basename(file_path)
    _, ext = os.path.splitext(old_full_file_name)
    new_full_file_name = "im5_uuid_" + str(uuid.uuid4()) + ext
    target = os.path.join(target_folder, new_full_file_name)
    mkdir(target_folder)
    shutil.copyfile(file_path, target)
    return target


def is_in_elements_directory(fs_path, directory):
    """判断是否在elements文件夹内。windows路径。

    Args:
        fs_path (str): 任意文件夹路径
        directory (str): SM完整的集合中的元素文件夹路径

    Returns:
        bool: 在, 返回True; 不在, 返回False
    """
    # 获取文件夹路径
    directory_name = os.path.dirname(fs_path)
    return directory_name.startswith(directory)


# ============================================================
# 网络下载
# ============================================================
MAX_IMG_BYTES = 20 * 1024 * 1024


def checkUrlValidity(url: str) -> bool:
    try:
        r = requests.get(url, stream=True, allow_redirects=True, timeout=(5, 30))
        return r.status_code == 200
    except requests.RequestException as e:
        logger.warning("URL 检查失败 %s: %s", url, e)
        return False


def fetch_image(url: str):
    """下载图像，返回 (mime, name, bytes) 或 None。"""
    try:
        response = requests.get(url, stream=True, timeout=(5, 30))
    except requests.RequestException as e:
        logger.warning("下载失败 %s: %s", url, e)
        return None

    content_type = response.headers.get("content-type")
    chunks, total = [], 0
    for chunk in response.iter_content(64 * 1024):
        total += len(chunk)
        if total > MAX_IMG_BYTES:
            logger.warning("图片超过 %d 字节，跳过 %s", MAX_IMG_BYTES, url)
            return None
        chunks.append(chunk)
    content = b"".join(chunks)

    content_mime = (
        content_type.split(";")[0] if content_type else magic.from_buffer(content, True)
    )

    sha1_hash = hashlib.sha1()
    for i in range(0, len(content), 4096):
        sha1_hash.update(content[i : i + 4096])
    file_name = f"im_{sha1_hash.hexdigest()}"
    # 只有当 content_type 为 image 类型 否则或者 filetype 为 image 类型。
    # 才返回数据，否则返回None。
    if content_mime and "image" in content_mime:
        return content_mime, file_name, content
    return None


def is_html_ext_file(file_path):
    file_ext = os.path.splitext(file_path)[1].lower()
    return file_ext in [".html", ".htm"]


# Windows 下需要安装 libmagic 的 DLL，否则报错
# https://github.com/ahupp/python-magic
# def verify_mime_is_html(htm_path_list: list) -> list:
#     """需要全路径文件列表"""
#     for index, file_path in enumerate(htm_path_list):
#         file_type = magic.Magic(mime=True).from_file(file_path)
#         if not (file_type == "text/html" or file_type == "text/plain"):
#             del htm_path_list[index]
#         print(
#             "PathPix:: 正在验证HTM文件",
#             f"[{index+1}/{len(htm_path_list)}]",
#             end="\033[K\r",
#         )
#     print("\033[K", end="\033[K\r")
#     return htm_path_list


def is_http_url_scheme(string):
    v = re.compile(
        "^(?!mailto:)(?:(?:http|https|ftp)://|//)(?:\\S+(?::\\S*)?@)?(?:(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[0-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))|localhost)(?::\\d{2,5})?(?:(/|\\?|#)[^\\s]*)?$",
        re.IGNORECASE,
    )
    return bool(v.match(string))


def is_data_url_scheme(string):
    return urlparse(string).scheme == "data"


def is_relative_path(string):
    # string = "file:///[PrimaryStorage]path/to/file" or '../3\\39.gif'
    return string.startswith("file:///[PrimaryStorage]") or os.path.isabs(string)


# 还有这种：'file:///C:/Users/Snowy/Desktop/sm18/必读：旅途的开始.png'
# 'C:/Users/Snowy/Desktop/sm18/systems/Noname/elements/web_pic\\im_2023-11-09-20_39_50_plot_19.jpeg'
def relativization_path(win_path):
    """将位于sm的elements文件夹中的文件的绝对路径转换为相对路径.

    Args:
        win_path (str): url =
            "file:///z:/path/systems/collection/elements/path/to/file"
            "z:/path/systems/collection/elements/path/to/file"

    Returns:
        str: file:///[PrimaryStorage]path/to/file
    """
    # 需要把\\分割符变成/分割符，使变成标准的链接分割符。
    win_path = win_path.replace("\\", "/")
    if not win_path.startswith("file:///") and os.path.exists(win_path):
        win_path = "file:///" + win_path

    pattern = re.compile(r"file:///(.*?elements\\|.*?elements/)")
    src_path = pattern.sub("file:///[PrimaryStorage]", win_path)
    return src_path


# ============================================================
# 图片下载 & 转换
# ============================================================
def im_download_and_convert(url, web_pic_folder, collection_temp_folder, htm_path):
    """给定url, 下载图片并转换, 返回保存图片的绝对路径

    Args:
        url (str): img标签中的src值
        web_pic_folder (str): saved_path, collection_temp_path, htm_file_path
        collection_temp_folder (str):
        htm_path (str): 绝对路径, 保存img到指定目录

    Returns:
        str: 绝对路径, drive:/path/sm18/systems/col/elements/path/to/file.ext'
    """
    supports_im_type = [
        "image/jpeg",
        "image/jpg",
        "image/png",
        "image/gif",
        "image/bmp",
    ]
    # now = time.strftime("%Y-%m-%d-%H_%M", time.localtime(time.time()))
    # file_name = "im_" + now + "_uuid_" + str(uuid.uuid4())

    if not checkUrlValidity(url):
        warn(f"无效资源链接 {url}", htm_path)
        return None
    fetched_image = fetch_image(url)
    if not fetched_image:
        warn(f"非图片资源链接 {url}", htm_path)
        return None

    (content_type, file_name, im_bytes) = fetched_image

    if content_type in supports_im_type:
        extension = content_type.split("/")[1]
        # 如果支持的话，就直接写入的路径中即可。
        mkdir(web_pic_folder)
        saved_path = os.path.join(web_pic_folder, file_name + f".{extension}")
        # 必须先创建文件夹。
        with open(saved_path, "wb") as f:
            f.write(im_bytes)
        return saved_path

    # 这些自然是不在受支持名单的。
    extension = content_type.split("/")[1]
    try:
        mkdir(collection_temp_folder)
        temp_file_path = os.path.join(
            collection_temp_folder, file_name + f".{extension}"
        )
        # 先把webp写到temp文件夹，然后再处理。
        with open(temp_file_path, "wb") as f:
            f.write(im_bytes)

        # 转换图片格式。
        with Image.open(temp_file_path) as im:
            logger.debug("convert %s %s %s", im.format, im.size, im.mode)
            # 这里是输出路径。
            mkdir(web_pic_folder)
            saved_path = os.path.join(web_pic_folder, file_name + ".png")
            im.save(saved_path, "png")
            return saved_path
    except Exception as e:
        warn(f"图片转换失败 {url}: {e}", htm_path)


def im_data_url_and_convert(htm_path):
    warn("Data URI 图片暂不支持，跳过", htm_path)


# ============================================================
# HTML 修改
# ============================================================
def modify_img_src(html_content, elements_folder, collection_temp_folder, htm_path):
    soup = BeautifulSoup(html_content, "html.parser")
    elements_folder = os.path.normpath(elements_folder)
    web_pic_folder = os.path.normpath(os.path.join(elements_folder, "web_pic"))
    local_pic_folder = os.path.normpath(os.path.join(elements_folder, "local_pic"))

    img_tags = soup.find_all("img")
    # 过滤元素。去掉没有src属性以及属性值为空的。
    filtered_im_list = list(
        filter(
            lambda im: "src" in im.attrs and im.attrs["src"] != "",
            img_tags,
        )
    )
    is_modify = False
    for im in filtered_im_list:
        # 中文的字符实体会自动变成正常的中文字符。
        # <img src="file:///C:/&#24517;&#35835;&#65306;&#26053;&#36884;&#30340;&#24320;&#22987;.png">
        im_src = im.attrs["src"]
        if is_http_url_scheme(im_src):
            im_web_local_path = im_download_and_convert(
                im_src, web_pic_folder, collection_temp_folder, htm_path
            )
            if im_web_local_path:
                im.attrs["src"] = relativization_path(
                    os.path.normpath(im_web_local_path)
                )
                is_modify = True
        elif is_data_url_scheme(im_src):
            # 如果是 Data URI scheme
            im_data_url_and_convert(htm_path)
        elif not is_relative_path(im_src):
            # ../ 等价于 file:///[PrimaryStorage] 等价于 elements_folder
            if im_src.startswith("../"):
                im_src = im_src.replace("../", elements_folder + "\\")

            # 绝对路径是否以file协议开头。
            if im_src.startswith("file:///"):
                # 还原绝对路径，去掉file协议。
                fs_path = unquote(os.path.normpath(im_src.split("file:///")[1]))
            else:
                fs_path = unquote(os.path.normpath(im_src))

            # if "file:///D:/Dropbox/21-Sandox/10-Picture/wine.png" == im_src:
            #     pass

            # 判断文件是否存在。
            if os.path.exists(fs_path):
                # 判断在不在集合的元素文件夹中。
                if is_in_elements_directory(fs_path, elements_folder):
                    # 在，修改为相对路径。
                    im.attrs["src"] = relativization_path(fs_path)
                    is_modify = True
                else:
                    # 不在，移动到集合元素文件夹的web_im_saved_path。
                    im.attrs["src"] = relativization_path(
                        os.path.normpath(copy_to_elements(fs_path, local_pic_folder))
                    )
                    is_modify = True
            else:
                warn(f"本地图片不存在 {fs_path}", htm_path)
        elif is_relative_path(im_src):
            is_modify = False
    if is_modify:
        return soup.encode(encoding="ascii")
    else:
        return False


def secure_file_write(modified_content, target_file, temp_folder):
    """
    写入文件的安全机制——文件备份和临时文件；

    文件备份和临时文件将在函数完成后删除。

    Args:
        modified_content (bytes):
        target_file (str): 目标文件
        temp_folder (str): 临时文件夹, 存储文件备份和临时文件
    """
    original_name = os.path.basename(target_file)
    backup_file = os.path.join(temp_folder, original_name + ".bak")
    temp_file = os.path.join(temp_folder, original_name + ".tmp")
    try:
        # print("正在处理：", target_file)
        mkdir(temp_folder)
        # 创建并写入临时文件
        with open(temp_file, "wb") as f:
            f.seek(0)
            f.write(modified_content)
            f.truncate()

        # 备份原始文件
        shutil.copyfile(target_file, backup_file)
        # 重命名临时文件为目标文件
        shutil.move(temp_file, target_file)
    except Exception as e:
        # 发生异常时回滚备份文件
        shutil.move(backup_file, target_file)
        error("写入文件失败", target_file, exc=e)
    finally:
        # 删除临时文件和备份文件
        if os.path.exists(temp_file):
            os.remove(temp_file)
        if os.path.exists(backup_file):
            os.remove(backup_file)


# ============================================================
# 遍历 & 读取
# ============================================================
def collect_documents(elements_folder):
    """在遍历查找HTM文档并返回文件路径列表。

    Args:
        elements_folder (str): elements路径

    Returns:
        tuple: (path, mtime)
    """
    htm_file_list = []
    stack = [elements_folder]
    with Progress("PathPix:: 扫描 HTM") as p:
        while stack:
            current = stack.pop()
            for entry in os.scandir(current):
                if entry.is_file() and is_html_ext_file(entry.path):
                    htm_file_list.append((entry.path, os.path.getmtime(entry.path)))
                    p.update()
                if entry.is_dir():
                    stack.append(entry.path)
    cprint(f"PathPix:: 共找到 {len(htm_file_list)} 个 HTM 文件", "green")
    return htm_file_list


def read_in_list(path_list):
    start_t = time.time()
    path_data = []
    with Progress("PathPix:: 读取文件", total=len(path_list)) as p:
        for htm_path in path_list:
            p.update()
            try:
                with open(htm_path, "rb") as f:
                    raw_data = f.read()
                file_type = magic.from_buffer(raw_data[:3072], mime=True)
                if file_type not in ("text/html", "text/xml", "text/plain"):
                    continue
                best = from_bytes(raw_data).best()
                if not best:
                    error("无法检测编码", htm_path)
                    mark_unreadable(htm_path)
                    continue
                path_data.append(
                    (
                        htm_path,
                        raw_data.decode(best.encoding, errors="xmlcharrefreplace"),
                    )
                )
            except Exception as e:
                error("读取文件失败", htm_path, exc=e)
                mark_unreadable(htm_path)
    cprint(
        f"PathPix:: Done! 验证并读取数据耗时 {time.time() - start_t:.2f} 秒。", "green"
    )
    return path_data


def relative_and_localize(wait_htm_path_list, elements_folder, collection_temp_folder):
    """在遍历查找到的html文挡, 一个个处理他们。

    Args:
        wait_htm_path_list (_type_): _description_
        elements_folder (_type_): _description_
        collection_temp_folder (_type_): _description_
    """
    # elements_path, im_saved_path, collection_temp_path
    processed_htm_files = []
    # 读取路径列表获得路径数据对列表：[(path,data),(path,data),...]
    htm_files = read_in_list(wait_htm_path_list)

    for htm_path, htm_data in tqdm(htm_files, desc="Doc-LinkCP"):
        try:
            modified_content = modify_img_src(
                htm_data, elements_folder, collection_temp_folder, htm_path
            )

            if modified_content:
                secure_file_write(modified_content, htm_path, collection_temp_folder)
                processed_htm_files.append(htm_path)
        except Exception as e:
            error("处理失败", htm_path, exc=e)

    if report_list:
        cprint("一些文件处理失败，请查看日志", "red")
    if not processed_htm_files:
        cprint("PathPix:: 无事可做。", "green")
    else:
        cprint(f"以下 {len(processed_htm_files)} 个文件已修改：", "green")
        for item in processed_htm_files[:20]:
            cprint(f"  {item}")
        if len(processed_htm_files) > 20:
            cprint(f"  ... 其余 {len(processed_htm_files) - 20} 个见日志")


# ============================================================
# 字节级 img src 提取（不变）
# ============================================================
class FindImgSrc:
    _WS = b" \t\r\n\f"
    _SEP = b"=/>"
    _QUOTES = (0x22, 0x27)
    _EQ = 0x3D

    _IMG_TAG_RE = re.compile(
        rb'<img(?=[\s/>])(?:[^>"\']|"[^"]*"|\'[^\']*\')*>', re.IGNORECASE
    )

    @staticmethod
    def _iter_attrs(raw: bytes):
        i, n = 1, len(raw)
        while i < n and raw[i] not in FindImgSrc._WS + b"/>":
            i += 1
        while i < n:
            while i < n and raw[i] in FindImgSrc._WS + b"/":
                i += 1
            if i >= n:
                break
            start = i
            while i < n and raw[i] not in FindImgSrc._WS + FindImgSrc._SEP:
                i += 1
            if i == start:
                i += 1
                continue
            name = raw[start:i]
            while i < n and raw[i] in FindImgSrc._WS:
                i += 1
            value = None
            if i < n and raw[i] == FindImgSrc._EQ:
                i += 1
                while i < n and raw[i] in FindImgSrc._WS:
                    i += 1
                if i < n and raw[i] in FindImgSrc._QUOTES:
                    quote = raw[i]
                    i += 1
                    vs = i
                    while i < n and raw[i] != quote:
                        i += 1
                    value = raw[vs:i]
                    if i < n:
                        i += 1
                else:
                    vs = i
                    while i < n and raw[i] not in FindImgSrc._WS + b">":
                        i += 1
                    value = raw[vs:i]
            yield name, value

    @staticmethod
    def find_img_srcs(text: bytes) -> list[str]:
        out = []
        for m in FindImgSrc._IMG_TAG_RE.finditer(text):
            for name, value in FindImgSrc._iter_attrs(m.group(0)):
                if name.lower() == b"src":
                    if value is not None:
                        out.append(value.decode("utf-8"))
                    break
        return out


# ============================================================
# 路径规范化
# ============================================================
def _to_short(abs_path: str) -> str:
    """绝对路径 → 形如 \\local_pic\\xxx.jpeg"""
    n = os.path.normpath(abs_path)
    if "elements" in n:
        n = n.rsplit("elements", 1)[1]
    if not n.startswith("\\"):
        n = "\\" + n.lstrip("/")
    return n


def _normalize_img_key(img: str) -> str:
    """图片 key → \\local_pic\\xxx.jpeg（内部会 unescape HTML 实体）"""
    img = html.unescape(img)
    n = os.path.normpath(img)
    if "elements" in n:
        n = n.rsplit("elements", 1)[1]
    if not n.startswith("\\"):
        n = "\\" + n.lstrip("/")
    return n


def _normalize_htm_key(path: str) -> str:
    """htm 路径 → 形如 \\8\\85.HTM"""
    n = os.path.normpath(path)
    if "elements" in n:
        n = n.rsplit("elements", 1)[1]
    if not n.startswith("\\"):
        n = "\\" + n.lstrip("/")
    return n


def _to_abs(elements_folder: str, short: str) -> str:
    return os.path.join(elements_folder, short.lstrip("\\/"))


# ============================================================
# 并行扫描 htm
# ============================================================
def _scan_htm_refs(htm_abs_paths, desc):
    """并行读一批 htm，返回 {img_short: {htm_short, ...}}"""
    index: dict[str, set[str]] = defaultdict(set)
    if not htm_abs_paths:
        return index

    def one(p):
        try:
            with open(p, "rb") as f:
                raw = f.read()
            return p, FindImgSrc.find_img_srcs(raw), None
        except Exception as e:
            return p, [], e

    total = len(htm_abs_paths)
    with ThreadPoolExecutor() as ex:
        for htm_abs, srcs, err in tqdm(
            ex.map(one, htm_abs_paths), total=total, desc=desc
        ):
            if err is not None:
                error("扫描引用失败", htm_abs, exc=err)
                mark_unreadable(htm_abs)
                continue
            short = _normalize_htm_key(htm_abs)
            for im in srcs:
                im = re.sub(r"^file.*?Storage\]", "", im)
                index[_normalize_img_key(im)].add(short)
    return index


# ============================================================
# 文档差异
# ============================================================
def diff_scanhtm(elements_folder, previous_scan_path):
    """返回 (差异文档列表, 现在扫描的文档列表, 已删除的文档列表)，均为绝对路径"""
    if os.path.exists(previous_scan_path):
        previous_scaned_docs = config.read_config(previous_scan_path) or {}
    else:
        previous_scaned_docs = {}

    now_scaned_docs = dict(collect_documents(elements_folder))

    if not previous_scaned_docs:
        cprint("PathPix:: 未检测到历史记录，本次将会全部整理。", "yellow")
        return list(now_scaned_docs), now_scaned_docs, []

    diff_docs = [
        p
        for p, m in now_scaned_docs.items()
        if p not in previous_scaned_docs or previous_scaned_docs[p] != m
    ]
    del_docs = list(set(previous_scaned_docs) - set(now_scaned_docs))
    return diff_docs, now_scaned_docs, del_docs


# ============================================================
# 图片引用记数本
# ============================================================
def 获取图片引用记数本(pre_record_path, htm_paths):
    """返回 {img_short: set(htm_short)}；冷启动时并行全量扫描"""
    if os.path.exists(pre_record_path):
        raw = config.read_config(pre_record_path)
        if raw:
            return {
                _normalize_img_key(img): {_normalize_htm_key(h) for h in paths}
                for img, paths in raw.items()
            }

    cprint("PathPix:: 未检测到图片记数本，全量扫描。", "yellow")
    index = _scan_htm_refs(htm_paths, desc="收集被引用的图片")
    config.dump_config(
        pre_record_path, {img: sorted(paths) for img, paths in index.items()}
    )
    return index


# ============================================================
# 磁盘图片（带目录树指纹缓存）
# ============================================================
def _tree_fingerprint(root: str) -> str:
    """目录树指纹：所有目录的 (路径, mtime_ns) 排序后 hash。"""
    entries = []
    for dirpath, _, _ in os.walk(root):
        try:
            entries.append((dirpath, os.stat(dirpath).st_mtime_ns))
        except OSError:
            continue
    entries.sort()
    h = hashlib.sha1()
    for p, m in entries:
        h.update(p.encode("utf-8", "surrogatepass"))
        h.update(b"\0")
        h.update(str(m).encode())
        h.update(b"\n")
    return h.hexdigest()


def find_im(directory):
    im_list = []
    stack = [directory]
    while stack:
        current_path = stack.pop()
        try:
            for entry in os.scandir(current_path):
                IMG_EXTS = {
                    ".jpg",
                    ".jpeg",
                    ".png",
                    ".gif",
                    ".bmp",
                    ".webp",
                    ".tif",
                    ".tiff",
                    ".svg",
                }
                if (
                    entry.is_file()
                    and os.path.splitext(entry.name)[1].lower() in IMG_EXTS
                ):
                    im_list.append(os.path.normpath(entry.path))
                if entry.is_dir():
                    stack.append(os.path.normpath(entry.path))
        except FileNotFoundError:
            pass
    return im_list


def 获取磁盘图片集合(web_pic, local_pic, cache_path):
    """返回 {\\local_pic\\xxx.jpeg, ...}；目录树没变则用缓存"""
    roots = [d for d in (web_pic, local_pic) if os.path.isdir(d)]
    fp_parts = []
    for d in roots:
        try:
            fp_parts.append(f"{d}|{_tree_fingerprint(d)}")
        except OSError:
            fp_parts.append(f"{d}|missing")
    fingerprint = "||".join(fp_parts)

    if os.path.exists(cache_path):
        cached = config.read_config(cache_path)
        if cached and cached.get("fingerprint") == fingerprint:
            return set(cached["paths"])

    paths = set()
    for d in roots:
        for p in find_im(d):
            paths.add(_to_short(p))

    config.dump_config(cache_path, {"fingerprint": fingerprint, "paths": sorted(paths)})
    return paths


# ============================================================
# 主流程：清理未使用图片
# ============================================================
def organize_unused_im(elements_folder):
    reset_report()
    logger.info("======== organize_unused_im: %s ========", elements_folder)

    web_pic = os.path.join(elements_folder, "web_pic")
    local_pic = os.path.join(elements_folder, "local_pic")
    temp_dir = os.path.normpath(os.path.join(elements_folder, "../", "temp"))
    unused_pic = os.path.join(temp_dir, "unused_im")

    if not (os.path.exists(web_pic) or os.path.exists(local_pic)):
        cprint(
            "PathPix:: 未处理过此集合，web_pic 和 local_pic 文件夹不存在。", "yellow"
        )
        return

    cprint("PathPix:: 清理 web_pic、local_pic 文件夹中未被使用的图片")

    key = makeNameSafe(elements_folder).lower()
    配置_扫描路径 = os.path.join(config_dir, f"previous_scaned_docs_{key}.json")
    配置_记数本路径 = os.path.join(config_dir, f"previous_img_peer_htms_{key}.json")
    配置_磁盘缓存 = os.path.join(config_dir, f"previous_disk_imgs_{key}.json")

    # 1. 文档差异
    差异文档列表, 现在扫描的文档列表, 已删除的文档列表 = diff_scanhtm(
        elements_folder, 配置_扫描路径
    )
    删除集合 = {_normalize_htm_key(x) for x in 已删除的文档列表}
    增改集合 = {_normalize_htm_key(x) for x in 差异文档列表}

    # 2. 并行解析增改文档
    增改引用 = _scan_htm_refs(差异文档列表, desc="解析变更文档")

    # 3. 载入记数本 {img_short: set(htm_short)}
    记数本 = 获取图片引用记数本(配置_记数本路径, list(现在扫描的文档列表))

    # 4. 剥旧账：删除的文档 + 增改文档的历史引用
    for paths in 记数本.values():
        paths -= 删除集合
        paths -= 增改集合

    # 5. 补新账：增改文档的最新引用
    for img, htms in 增改引用.items():
        记数本.setdefault(img, set()).update(htms)

    # 6. 引用数为 0 = 孤儿图；先不删记数本，留给下一步做差时自然排除
    孤儿图 = {img for img, paths in 记数本.items() if not paths}

    # 7. 磁盘有、文档没有的
    在磁盘中的图片路径 = 获取磁盘图片集合(web_pic, local_pic, 配置_磁盘缓存)
    磁盘差集 = 在磁盘中的图片路径 - set(记数本.keys())
    等待删除的图片路径 = list(孤儿图 | 磁盘差集)

    # ===== 有扫描失败就保守跳过，宁可不删也不误删 =====
    if _unreadable_htms:
        cprint(
            f"检测到 {len(_unreadable_htms)} 个 htm 扫描失败，本轮跳过清理以防误删。",
            "yellow",
        )
        if report_list:
            open_log()
        return

    # 8. 移动
    if 等待删除的图片路径:
        mkdir(unused_pic)
        for short in 等待删除的图片路径:
            rel = short.lstrip("\\/")
            src = os.path.join(elements_folder, rel)
            if not os.path.exists(src):  # 兜底：文件已经不在就当它已经删过了
                continue
            dst = os.path.join(unused_pic, makeNameSafe(rel))
            try:
                logger.info("移到 unused: %s", rel)
                shutil.move(src, dst)
            except Exception as e:
                error("移动图片失败", src, exc=e)
    else:
        cprint("PathPix:: 无事可做。", "green")

    # 8.5 记数本落盘前，把孤儿图剔除
    for img in 孤儿图:
        del 记数本[img]

    # 9. 清空 local_pic 下的空目录
    if os.path.isdir(local_pic):
        for entry in os.scandir(local_pic):
            if entry.is_dir():
                try:
                    os.rmdir(entry.path)
                except OSError:
                    pass

    # 10. 落盘
    config.dump_config(
        配置_记数本路径, {img: sorted(paths) for img, paths in 记数本.items()}
    )
    config.dump_config(配置_扫描路径, 现在扫描的文档列表)

    logger.info(
        "======== organize_unused_im done: failed=%d ========", len(set(report_list))
    )
    if report_list:
        open_log()


# ============================================================
# 单文件处理
# ============================================================
def single_file(fullpath: str):
    reset_report()
    logger.info("======== single_file: %s ========", fullpath)

    elements_folder = os.path.normpath(
        os.path.join(fullpath.split("elements")[0], "elements")
    )
    collection_temp_folder = os.path.normpath(
        os.path.join(elements_folder, "../", "temp")
    )
    web_pic_folder = os.path.normpath(os.path.join(elements_folder, "web_pic"))
    local_pic_folder = os.path.normpath(os.path.join(elements_folder, "local_pic"))
    cprint(f"元素位置：{fullpath}")
    cprint(f"图片位置：{[web_pic_folder, local_pic_folder]}")
    cprint(f"临时文件：{collection_temp_folder}")

    relative_and_localize([fullpath], elements_folder, collection_temp_folder)

    logger.info("======== single_file done: failed=%d ========", len(set(report_list)))
    if report_list:
        open_log()


# ============================================================
# 入口：批量处理
# ============================================================
def start(elements_folder):
    reset_report()
    logger.info("======== start: %s ========", elements_folder)

    collection_temp_folder = os.path.normpath(
        os.path.join(elements_folder, "../", "temp")
    )
    web_pic_folder = os.path.normpath(os.path.join(elements_folder, "web_pic"))
    local_pic_folder = os.path.normpath(os.path.join(elements_folder, "local_pic"))
    cprint(f"集合元素：{elements_folder}")
    cprint(f"图片位置：{[web_pic_folder, local_pic_folder]}")
    cprint(f"临时文件：{collection_temp_folder}")

    # 读取旧列表,transfer_images、pathpix、organize_unused_im，他们diff的区别在于每个人执行的时间不同。
    # 所以似乎不能混用同一个历史记录？？？
    previous_scan_conf_path = os.path.join(
        config_dir, f"previous_scan_{makeNameSafe(elements_folder).lower()}.json"
    )

    diff_list, now_scan, _ = diff_scanhtm(elements_folder, previous_scan_conf_path)
    if diff_list:
        relative_and_localize(diff_list, elements_folder, collection_temp_folder)
    else:
        cprint("PathPix:: 无事可做。", "green")

    # 失败文件下次重试；pop 防 KeyError
    for htm_path in set(report_list):
        now_scan.pop(htm_path, None)

    config.dump_config(previous_scan_conf_path, now_scan)

    logger.info("======== start done: failed=%d ========", len(set(report_list)))
    if report_list:
        open_log()


# ============================================================
# 集合间转移图片
# ============================================================
def _diff_by_case(a, b) -> list[str]:
    """a 中有、b 中没有（大小写不敏感），返回 a 的原始写法。"""
    a_map = {os.path.normcase(x): x for x in a}
    b_keys = {os.path.normcase(x) for x in b}
    return [a_map[k] for k in a_map.keys() - b_keys]


def transfer_images(src_elements_root: str, dst_elements_root: str):
    """仅转移web_pic和local_pic文件夹中缺失的图片，从src_kno移动到dst_kno。"""
    reset_report()
    logger.info(
        "======== transfer_images: %s -> %s ========",
        src_elements_root,
        dst_elements_root,
    )

    dst_web_pic = os.path.join(dst_elements_root, "web_pic")
    dst_local_pic = os.path.join(dst_elements_root, "local_pic")

    cprint("PathPix:: 收集 dst 缺失的图片，从 src 移动到目的位置。")

    # 1. 并行扫描 dst 的所有 htm，得到 {img_short: {htm_short}}
    htm_paths = [p for p, _ in collect_documents(dst_elements_root)]
    引用索引 = _scan_htm_refs(htm_paths, desc="收集被引用的图片")

    # 只保留 local_pic / web_pic 下的图片
    被引用的图片 = {img for img in 引用索引 if "local_pic" in img or "web_pic" in img}

    # 2. 复用磁盘图片缓存，拿到 dst 上实际存在的图片
    dst_key = makeNameSafe("transfer" + dst_elements_root).lower()
    配置_磁盘缓存 = os.path.join(config_dir, f"previous_disk_imgs_{dst_key}.json")
    在磁盘中的图片路径 = 获取磁盘图片集合(dst_web_pic, dst_local_pic, 配置_磁盘缓存)

    # 3. 差集 = 缺失的图片
    缺失图片 = _diff_by_case(被引用的图片, 在磁盘中的图片路径)

    if _unreadable_htms:
        cprint(f"警告：{len(_unreadable_htms)} 个 htm 扫描失败，可能漏搬图。", "yellow")

    # 4. 从 src 搬到 dst
    for short in 缺失图片:
        rel = short.lstrip("\\/")
        src_path = _to_abs(src_elements_root, rel)
        dst_path = _to_abs(dst_elements_root, rel)
        if os.path.exists(src_path):
            mkdir(os.path.dirname(dst_path))
            shutil.move(src_path, dst_path)
            logger.info("移动缺失图片: %s", rel)
        else:
            warn(f"源集合缺图 {rel}", dst_path)

    # 5. 搬完图，dst 磁盘变了，缓存作废
    if 缺失图片 and os.path.exists(配置_磁盘缓存):
        os.remove(配置_磁盘缓存)

    # dst htm ──扫描──→ 被引用的图片 ─┐
    #                               ├─ 差集 ─→ 缺失图片 ─→ 从 src 搬到 dst
    # dst 磁盘 ──扫描──→ 磁盘图片 ───┘

    logger.info(
        "======== transfer_images done: moved=%d failed=%d ========",
        len(缺失图片),
        len(set(report_list)),
    )
    if report_list:
        open_log()


# 区分文件和文件夹路径。文件就使用path，文件夹就使用folder

# start("D:/SuperMemo/systems/ALL IN ONE/elements")
# organize_unused_im("D:/SuperMemo/systems/Reading-And-Review/elements")
# single_file("E:\\新建文件夹\\elements\\26690.HTM")
# transfer_images("", "")

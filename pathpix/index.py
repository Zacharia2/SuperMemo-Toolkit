from bs4 import BeautifulSoup
import re
import os
import time
import requests
from PIL import Image

URL = 1
RELATIVE = 2
ABSOLUTE = 3


def is_html_file(name):
    name = name.lower()
    return name.endswith(".html") or name.endswith(".htm")


def is_url(str):
    v = re.compile(
        "^(?!mailto:)(?:(?:http|https|ftp)://|//)(?:\\S+(?::\\S*)?@)?(?:(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[0-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))|localhost)(?::\\d{2,5})?(?:(/|\\?|#)[^\\s]*)?$",
        re.IGNORECASE,
    )
    return bool(v.match(str))


def is_relative_path(string):
    # string = "file:///[PrimaryStorage]path/to/file"
    return string.startswith("file:///[PrimaryStorage]")


def matches_type(src_url):
    if is_url(src_url):
        return URL
    if is_relative_path(src_url):
        return RELATIVE
    else:
        return ABSOLUTE


def modify_src_to_relative(url):
    """将sm绝对路径转换为相对路径.

    Args:
        url (str): url = "file:///z:/path/systems/collection/elements/path/to/file"

    Returns:
        str: file:///[PrimaryStorage]path/to/file
    """

    pattern = re.compile(r"file:///.*?elements/")
    src_path = pattern.sub("file:///[PrimaryStorage]", url)
    return src_path


def im_download_and_convert(url, saved_path):
    """给定url, 下载图片并转换, 返回保存图片的绝对路径

    Args:
        url (str): img标签中的src值
        saved_path (_type_): 绝对路径, 保存img到指定目录

    Returns:
        str: 绝对路径, 图片的绝对位置
    """
    supports_im_type = ["image/jpeg", "image/jpg", "image/png"]
    response = requests.get(url)
    content_type = response.headers.get("Content-Type")

    now = time.strftime("%Y-%m-%d-%H_%M_%S", time.localtime(time.time()))
    file_name = "im_" + now + "_plot_" + str(len(now))

    if content_type and content_type.startswith("image/"):
        im_bytes = response.content
        if content_type not in supports_im_type:
            try:
                with Image.open(im_bytes) as im:
                    print(im.format, im.size, im.mode)
                    # 这里是输出路径。
                    saved_path = os.path.join(saved_path, file_name + ".png")
                    im.save(saved_path, "png")
                    return saved_path
            except OSError:
                print("cannot convert", url)
        else:
            ext = content_type.split("/")[1]
            # 如果支持的话，就直接写入的路径中即可。
            saved_path = os.path.join(saved_path, file_name + f".{ext}")
            with open(saved_path, "wb") as f:
                f.write(im_bytes)
            return saved_path
    else:
        print("非图片资源链接 ", url)


def modify_src(html_path, web_im_saved_path):
    soup = BeautifulSoup(html_path, "html.parser")

    img_tags = soup.find_all("img")
    for img in img_tags:
        src = img.attrs["src"]
        if matches_type(src) == URL:
            img.attrs["src"] = modify_src_to_relative(
                im_download_and_convert(src, web_im_saved_path)
            )
        elif matches_type(src) == ABSOLUTE:
            img.attrs["src"] = modify_src_to_relative(src)
    return str(soup)


def relative_and_localize(elements_path, web_im_saved_path):
    """在遍历查找html文件时, 一个个处理他们，并返回处理后的文件列表。

    Args:
        element_path (str): elements路径

    Returns:
        list: 处理后的文件列表
    """
    processed_htm_files = []

    def find_htm_files(directory):
        nonlocal processed_htm_files
        with os.scandir(directory) as entries:
            for entry in entries:
                if entry.is_file() and is_html_file(entry.name):
                    # todo something
                    try:
                        with os.open(entry, "r", encoding="utf-8") as f:
                            content = f.read()
                            f.seek(0)
                            modified_content = modify_src(content, web_im_saved_path)
                            f.write(modified_content)
                            f.truncate()
                            processed_htm_files.append(entry.path)
                    except OSError:
                        print(entry)

                if entry.is_dir():
                    find_htm_files(entry.path)

    find_htm_files(elements_path)
    return processed_htm_files


# collect_html(
#     "C:\\Users\\Snowy\\Desktop\\sm18\\systems\\CongMingRenDeGeRenChengZhang\\elements"
# )

relative_and_localize(
    "C:\\Users\\Snowy\\Desktop\\sm18\\systems\\CongMingRenDeGeRenChengZhang\\elements",
    "C:\\Users\\Snowy\\Desktop\\sm18\\systems\\CongMingRenDeGeRenChengZhang\\elements\\web_pic",
)

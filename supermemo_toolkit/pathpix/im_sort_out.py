import hashlib
import logging
import os
import re
import shutil
import time
import uuid
from urllib.parse import unquote, urlparse

import chardet
import magic
import requests
from PIL import Image
from bs4 import BeautifulSoup
from tqdm import tqdm

from supermemo_toolkit.utilscripts import config
from supermemo_toolkit.utilscripts.ulils import makeNameSafe

config_dir = config.get_config_dir()
if os.path.exists(config_dir):
    LOG_FILE = os.path.join(config_dir, "smtk.log.txt")
elif not os.path.exists(config_dir):
    os.makedirs(config_dir)
    LOG_FILE = os.path.join(config_dir, "smtk.log.txt")


def setup_logger():
    """设置日志记录器，添加文件处理器和格式化器"""
    # 创建记录器并设置等级
    mlogger = logging.getLogger(__name__)
    mlogger.setLevel(logging.INFO)

    # 创建文件处理器并设置等级
    file_handler = logging.FileHandler(LOG_FILE, mode="w")
    file_handler.setLevel(logging.INFO)

    # 创建格式化器并设置到处理器
    formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    )
    file_handler.setFormatter(formatter)

    # 添加处理器到记录器
    mlogger.addHandler(file_handler)

    return mlogger


logger = setup_logger()
report_list = list()


def report(msg: dict):
    # def msg: dict : {msg，htm_path}
    logger.warning(msg["msg"])
    if msg["htm_path"]:
        report_list.append(msg["htm_path"])


def copy_to_elements(file_path: str, target_folder: str) -> str:
    # unescape_fs_path = html.unescape(file_path)
    old_full_file_name = os.path.basename(file_path)
    name, ext = os.path.splitext(old_full_file_name)
    new_full_file_name = (
        # makeNameSafe(trans_pinyin(full_to_half(name)))
        "im5_uuid_" + str(uuid.uuid4()) + ext
    )
    target = os.path.join(target_folder, new_full_file_name)
    mkdir(target_folder)
    shutil.copyfile(file_path, target)
    return target


def mkdir(path: str):
    if not os.path.exists(path):
        os.makedirs(path)
        print("创建文件夹:: " + path)


def unified_path_separator(path):
    """格式化Windows路径为, 以\\作为分割符的路径。

    Args:
        path (str): Windows系统文件路径。

    Returns:
        str: 以\\作为分割符的标准路径。
    """
    return path.replace("/", "\\")


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
    # 判断给定路径是否以指定目录开头
    return directory_name.startswith(directory)


def checkUrlValidity(url: str) -> bool:
    try:
        response = requests.get(url, stream=True, allow_redirects=True)
        if response.status_code == 200:
            return True
        else:
            return False
    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
        return False
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
        return False
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
        return False
    except requests.RequestException as e:
        print("RequestException ", e)
        return False
    except ValueError as e:
        print("响应解析异常: ", e)
        return False


def fetch_image(url: str):
    """
    下载图像文件，返回(图片类型, 图片名称, 图片数据) | None
    """
    sha1_hash = hashlib.sha1()
    response = requests.get(url, stream=True)
    content_type = response.headers.get("content-type")
    content = response.content
    content_mime = ""
    # 1.生成 sha1_hash 作为文件名
    # Read and update hash in chunks of 4K
    field_length = 4096
    for byte_block in [
        content[i : i + field_length] for i in range(0, len(content), field_length)
    ]:
        sha1_hash.update(byte_block)
    file_name = f"im_{sha1_hash.hexdigest()}"

    # 2.处理 content_type 中可能的字符编码
    # 如：image/jpeg; charset=utf-8
    if content_type:
        content_mime = content_type.split(";")[0]
    else:
        # 3.通过文件内容判断文件图片类型，作为判断是否为图片类型的备选措施。
        # filetype = imghdr.what(None, content)
        content_mime = magic.from_buffer(content, True)

    # 只有当 content_type 为 image 类型 否则或者 filetype 为 image 类型。
    # 才返回数据，否则返回None。
    if content_mime and "image" in content_mime:
        return content_mime, file_name, content
    else:
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
#             end="\r",
#         )
#     print("\033[K", end="\r")
#     return htm_path_list


def is_http_url_scheme(string):
    v = re.compile(
        "^(?!mailto:)(?:(?:http|https|ftp)://|//)(?:\\S+(?::\\S*)?@)?(?:(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[0-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))|localhost)(?::\\d{2,5})?(?:(/|\\?|#)[^\\s]*)?$",
        re.IGNORECASE,
    )
    return bool(v.match(string))


def is_data_url_scheme(string):
    parsed_url = urlparse(string)
    if parsed_url.scheme == "data":
        return True


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
        report(
            {
                "msg": f"警告! File:{htm_path}, 无效资源链接 {url}",
                "htm_path": htm_path,
            }
        )
        return None
    fetched_image = fetch_image(url)

    if not fetched_image:
        report(
            {
                "msg": f"警告! File:{htm_path}, 非图片资源链接 {url}",
                "htm_path": htm_path,
            }
        )
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
            print(im.format, im.size, im.mode)
            # 这里是输出路径。
            mkdir(web_pic_folder)
            saved_path = os.path.join(web_pic_folder, file_name + ".png")
            im.save(saved_path, "png")
            return saved_path
    except Exception as e:
        report(
            {
                "msg": f"发生一个异常: {e}! \n\tFile:{htm_path}, \n\tCannot convert {url}",
                "htm_path": htm_path,
            }
        )


def im_data_url_and_convert(htm_path):
    print("这是一个Data URI scheme, 暂不支持; svglib、pyvips。文件:", htm_path)


def modify_img_src(
    html_content,
    elements_folder,
    collection_temp_folder,
    htm_path,
):
    # im_saved_path, elements_path, collection_temp_path, htm_file_path
    soup = BeautifulSoup(html_content, "html.parser")
    elements_folder = unified_path_separator(elements_folder)
    web_pic_folder = os.path.normpath(os.path.join(elements_folder, "web_pic"))
    local_pic_folder = os.path.normpath(os.path.join(elements_folder, "local_pic"))

    img_tags = soup.find_all("img")
    # 过滤元素。去掉没有src属性以及属性值为空的。
    filtered_im_list = list(
        filter(
            lambda im_node: "src" in im_node.attrs and im_node.attrs["src"] != "",
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
                im_src,
                web_pic_folder,
                collection_temp_folder,
                htm_path,
            )
            if im_web_local_path:
                standard_path = unified_path_separator(im_web_local_path)
                im.attrs["src"] = relativization_path(standard_path)
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
                fs_path = unquote(unified_path_separator(im_src.split("file:///")[1]))
            else:
                fs_path = unquote(unified_path_separator(im_src))

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
                        unified_path_separator(
                            copy_to_elements(fs_path, local_pic_folder)
                        )
                    )
                    is_modify = True
            else:
                report(
                    {
                        "msg": f"{htm_path}, local-img {fs_path} not exists !",
                        "htm_path": htm_path,
                    }
                )
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
        print(f"写入文件时发生错误：{str(e)}")
    finally:
        # 删除临时文件和备份文件
        if os.path.exists(temp_file):
            os.remove(temp_file)
        if os.path.exists(backup_file):
            os.remove(backup_file)


def collect_documents(elements_folder):
    """在遍历查找HTM文档并返回文件路径列表。

    Args:
        elements_folder (str): elements路径

    Returns:
        tuple: (path, mtime)
    """
    htm_file_list = []
    count_processed = 0

    stack = [elements_folder]
    while stack:
        current_path = stack.pop()
        for entry in os.scandir(current_path):
            if entry.is_file() and is_html_ext_file(entry.path):
                htm_file_list.append((entry.path, os.path.getmtime(entry.path)))
                count_processed += 1
                # if count_processed % 100 == 0:
                print(
                    "PathPix:: 正在计算HTM文件总数",
                    f"[{count_processed}]",
                    end="\r",
                )
            if entry.is_dir():
                stack.append(entry.path)
    print(f"\nPathPix:: 共找到 {count_processed} 个HTM文件")
    return htm_file_list


def read_in_list(path_list: list) -> list:
    start_time = time.time()
    path_data = []
    for index, htm_path in enumerate(path_list):
        try:
            with open(htm_path, "rb") as f:
                raw_data = f.read()
                file_type = magic.from_buffer(raw_data[:3072], mime=True)
                if not (
                    file_type == "text/html"
                    or file_type == "text/xml"
                    or file_type == "text/plain"
                ):
                    continue
                result = chardet.detect(raw_data)
                encoding = result["encoding"]
            path_data.append(
                (
                    htm_path,
                    raw_data.decode(encoding=encoding, errors="xmlcharrefreplace"),
                )
            )
        except Exception as e:
            report(
                {
                    "msg": f"{htm_path}, {e}",
                    "htm_path": htm_path,
                }
            )
        print(
            "PathPix:: 正在读取文件数据",
            f"[{index + 1}/{len(path_list)}]",
            end="\r",
        )
    end_time = time.time()
    print("\nPathPix:: Done!", f" 验证并读取数据耗时 {end_time - start_time:.2f} 秒。")
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
                htm_data,
                elements_folder,
                collection_temp_folder,
                htm_path,
            )

            if modified_content:
                secure_file_write(modified_content, htm_path, collection_temp_folder)
                processed_htm_files.append(htm_path)
        except Exception as e:
            report(
                {
                    "msg": f"{htm_path}, {e}",
                    "htm_path": htm_path,
                }
            )

    if len(report_list) != 0:
        print("\033[0;31;40m", "一些文件处理失败, 请查看log文件", "\033[0m")
        os.startfile(LOG_FILE)
    if len(processed_htm_files) == 0:
        print("\033[0;32m", "PathPix:: 无事可做。", "\033[0m")
    else:
        print("\033[0;32m", "以下文件已修改：", "\033[0m")
        for item in processed_htm_files:
            print(item)


def find_im(directory):
    im_list = []
    stack = [directory]
    while stack:
        current_path = stack.pop()
        try:
            for entry in os.scandir(current_path):
                if entry.is_file():
                    im_list.append(entry.path)
                if entry.is_dir():
                    stack.append(entry.path)
        except FileNotFoundError:
            pass
    return im_list


def organize_unused_im(elements_folder):
    doc_im_set = set()

    web_pic = os.path.join(elements_folder, "web_pic")
    local_pic = os.path.join(elements_folder, "local_pic")
    temp_dir = os.path.normpath(os.path.join(elements_folder, "../", "temp"))
    unused_pic = os.path.join(temp_dir, "unused_im")

    is_exists_web_pic = os.path.exists(web_pic)
    is_exists_local_pic = os.path.exists(local_pic)
    if is_exists_web_pic or is_exists_local_pic:
        print("PathPix::", "清理web_pic, local_pic文件夹中未被使用的图片")
        # 读取单个HTML文件中的被引用的im名字。
        im_list = find_im(web_pic) + find_im(local_pic)
        htm_path_m_date_list = collect_documents(elements_folder)
        for htm_file_path, m_time in tqdm(htm_path_m_date_list, desc="Doc-ImGather"):
            try:
                with open(htm_file_path, "rb") as f:
                    raw_data = f.read()
                    result = chardet.detect(raw_data)
                    encoding = result["encoding"]

                content = raw_data.decode(encoding=encoding, errors="xmlcharrefreplace")
                soup = BeautifulSoup(content, "html.parser")
                img_tags = soup.find_all("img")

                filtered_im_list = list(
                    filter(
                        lambda im_node: "src" in im_node.attrs
                        and im_node.attrs["src"] != "",
                        img_tags,
                    )
                )
                for im in filtered_im_list:
                    parse_result = urlparse(im.attrs["src"])
                    file_name = os.path.basename(unquote(parse_result.path))
                    # 收集所有被引用的im文件名。
                    doc_im_set.add(file_name)
            except UnicodeDecodeError as e:
                print(htm_file_path + "\n\t" + e)

        # 移动到temp文件夹
        unused_pic_list = []
        for im in im_list:
            # 对im进行 整理 只保留文件名。
            im_file_name = os.path.basename(im)
            if im_file_name not in doc_im_set:
                unused_pic_list.append(im)

        if len(unused_pic_list) > 0:
            for im in unused_pic_list:
                try:
                    print("处理: ", os.path.basename(im))
                    mkdir(unused_pic)
                    # 将一个文件或文件夹从 src 移动到 dst 如果 dst 已存在且为文件夹，则 src 将会被移动到 dst内。
                    shutil.move(im, unused_pic)
                except Exception as e:
                    print(f"移动至unused_pic时发生错误: {str(e)}")
        else:
            print("\033[0;32m", "PathPix:: 无事可做。", "\033[0m")

        # 删除空白图书图片文件夹。
        # 查找localpic下的所有空白文件夹并删除
        for entry in os.scandir(local_pic):
            # not os.listdir(entry.path)即为空文件夹。
            if entry.is_dir() and not os.listdir(entry.path):
                os.rmdir(entry.path)
    else:
        print("PathPix:: 未处理过此集合, web_pic 和 local_pic 文件夹不存在。")


def single_file(fullpath: str):
    # fullpath (str): D:/SuperMemo/systems/ABC of SuperMemo 19/elements/26690.HTM

    elements_folder = os.path.normpath(
        os.path.join(fullpath.split("elements")[0], "elements")
    )
    collection_temp_folder = os.path.normpath(
        os.path.join(elements_folder, "../", "temp")
    )
    web_pic_folder = os.path.normpath(os.path.join(elements_folder, "web_pic"))
    local_pic_folder = os.path.normpath(os.path.join(elements_folder, "local_pic"))
    print("元素位置：", fullpath)
    print("图片位置：", [web_pic_folder, local_pic_folder])
    print("临时文件：", collection_temp_folder)
    relative_and_localize(
        [fullpath],
        elements_folder,
        collection_temp_folder,
    )


def start(elements_folder):
    collection_temp_folder = os.path.normpath(
        os.path.join(elements_folder, "../", "temp")
    )
    web_pic_folder = os.path.normpath(os.path.join(elements_folder, "web_pic"))
    local_pic_folder = os.path.normpath(os.path.join(elements_folder, "local_pic"))
    print("集合元素：", elements_folder)
    print("图片位置：", [web_pic_folder, local_pic_folder])
    print("临时文件：", collection_temp_folder)

    # 读取旧列表
    conf_old_dict_filter_path = os.path.join(
        config_dir, f"old_{makeNameSafe(elements_folder).lower()}_dict_filter.json"
    )
    if os.path.exists(conf_old_dict_filter_path):
        old_dict_filter = config.read_config(conf_old_dict_filter_path)
    else:
        old_dict_filter = dict()

    # 构建一个字典 { path: mtime }
    gen_dict_filter = dict()
    htm_path_mdate_list = collect_documents(elements_folder)
    for path, mtime in htm_path_mdate_list:
        gen_dict_filter[path] = mtime

    htm_path_filtered_list = list()
    # 判断字典非空，存在默认为True。
    if old_dict_filter:
        # 使用生成字典去迭代读取字典。
        for path, mtime in gen_dict_filter.items():
            # 说明文件是存在的
            if path in old_dict_filter.keys():
                # 应该找出修改的文件。
                if mtime != old_dict_filter[path]:
                    htm_path_filtered_list.append(path)
            # 说明文件是新增的
            else:
                htm_path_filtered_list.append(path)
            # 读取字典有的，生成字典没有的，是被删除的。
    else:
        # 第一次添加生成字典。所谓的初始化数据库。
        print("PathPix:: 未检测到历史记录，本次将会全部整理。")
        for path in gen_dict_filter.keys():
            htm_path_filtered_list.append(path)

    if htm_path_filtered_list:
        relative_and_localize(
            htm_path_filtered_list,
            elements_folder,
            collection_temp_folder,
        )
    else:
        print("\n\033[0;32m", "PathPix:: 无事可做。", "\033[0m")
    # 把处理失败的文件剔除掉，下次重新试过一次。
    for htm_path in report_list:
        del gen_dict_filter[htm_path]
    # 保存生成字典
    config.update_config(conf_old_dict_filter_path, gen_dict_filter)


# 区分文件和文件夹路径。文件就使用path，文件夹就使用folder

# start("C:/Users/Snowy/Desktop/sm18/systems/all in one/elements")
# start("D:/SuperMemo/systems/ALL IN ONE/elements")
# organize_unused_im("D:/SuperMemo/systems/Reading-And-Review/elements")
# single_file("E:\\新建文件夹\\elements\\26690.HTM")

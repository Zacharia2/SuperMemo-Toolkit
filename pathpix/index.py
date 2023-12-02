import imghdr
import logging
import shutil
import sys
import uuid
from bs4 import BeautifulSoup
import re
import os
import time
import chardet
import pypinyin
import requests
from PIL import Image
from tqdm import tqdm
import magic
from urllib.parse import unquote, urlparse

sys.path.insert(0, sys.path[0] + "/../")
from scripts import config  # noqa: E402

config_dir = config.get_config_dir()
if os.path.exists(config_dir):
    LOG_FILE = os.path.join(config_dir, "supermemokit.log.txt")
elif not os.path.exists(config_dir):
    os.makedirs(config_dir)
    LOG_FILE = os.path.join(config_dir, "supermemokit.log.txt")


def setup_logger():
    """设置日志记录器，添加文件处理器和格式化器"""
    # 创建记录器并设置等级
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.INFO)

    # 创建文件处理器并设置等级
    file_handler = logging.FileHandler(LOG_FILE, mode="w")
    file_handler.setLevel(logging.INFO)

    # 创建格式化器并设置到处理器
    formatter = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
    )
    file_handler.setFormatter(formatter)

    # 添加处理器到记录器
    logger.addHandler(file_handler)

    return logger


logger = setup_logger()


def makeNameSafe(name):
    illegalFilenameCharacters = r"/<|>|\:|\"|\/|\\|\||\?|\*|\^|\s/g"
    fixedTitle = re.sub(illegalFilenameCharacters, "_", name)
    return fixedTitle


# 全角转半角
def full_to_half(text: str):  # 输入为一个句子
    _text = ""
    for char in text:
        inside_code = ord(
            char
        )  # 以一个字符（长度为1的字符串）作为参数，返回对应的 ASCII 数值
        if inside_code == 12288:  # 全角空格直接转换
            inside_code = 32
        elif 65281 <= inside_code <= 65374:  # 全角字符（除空格）根据关系转化
            inside_code -= 65248
        _text += chr(inside_code)
    return _text


def trans_pinyin(str):
    trans_list = []
    half_text = full_to_half(str)
    for pinyin_name in pypinyin.pinyin(half_text, style=pypinyin.NORMAL):
        for pinyin_name_ in pinyin_name:
            pinyin_name__ = pinyin_name_.capitalize()
            trans_list.append(pinyin_name__)
    return "".join(trans_list)


def copy_to_elements(file_path, target_folder):
    # unescape_fs_path = html.unescape(file_path)
    old_full_file_name = os.path.basename(file_path)
    name, ext = os.path.splitext(old_full_file_name)
    new_full_file_name = (
        makeNameSafe(trans_pinyin(full_to_half(name)))
        + "_uuid_"
        + str(uuid.uuid4())
        + ext
    )
    target = os.path.join(target_folder, new_full_file_name)
    mkdir(target_folder)
    shutil.copyfile(file_path, target)
    return target


def mkdir(path):
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
        path (str): 任意文件夹路径
        directory (str): SM完整的集合中的元素文件夹路径

    Returns:
        bool: 在, 返回True; 不在, 返回False
    """
    # 获取文件夹路径
    directory_name = os.path.dirname(fs_path)
    # 判断给定路径是否以指定目录开头
    return directory_name.startswith(directory)


def assure_image_url(url):
    """
    接受URL, 返回图片类型和响应, 不是图片返回False。
    """
    try:
        response = requests.get(url, stream=True)
        content_type = response.headers.get("content-type")
        content = response.content
        if content_type:
            # 处理可能的字符编码，如：image/jpeg; charset=utf-8
            content_type = content_type.split(";")[0]
        # 仅读取文件头用于确定文件类型
        filetype = imghdr.what(None, content)
        # 文件头信息、文件内容。
        if content_type and "image" in content_type:
            return (content_type, content)
        elif filetype is not None:
            return ("image/" + filetype, content)
        else:
            return False
    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
    except ValueError as e:
        print("响应解析异常: ", e)


# Windows 下需要安装 libmagic 的 DLL，否则报错
# https://github.com/ahupp/python-magic
def is_html_file(file_path):
    file_type = magic.Magic(mime=True).from_file(file_path)
    file_ext = os.path.splitext(file_path)[1].lower()
    return file_type == "text/html" or file_ext in [".html", ".htm"]


def is_http_url_scheme(str):
    v = re.compile(
        "^(?!mailto:)(?:(?:http|https|ftp)://|//)(?:\\S+(?::\\S*)?@)?(?:(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[0-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))|localhost)(?::\\d{2,5})?(?:(/|\\?|#)[^\\s]*)?$",
        re.IGNORECASE,
    )
    return bool(v.match(str))


def is_data_url_scheme(str):
    parsed_url = urlparse(str)
    if parsed_url.scheme == "data":
        return True


def is_relative_path(string):
    # string = "file:///[PrimaryStorage]path/to/file"
    return string.startswith("file:///[PrimaryStorage]")


# 还有这种：'file:///C:/Users/Snowy/Desktop/sm18/必读：旅途的开始.png'
# 'C:/Users/Snowy/Desktop/sm18/systems/Noname/elements/web_pic\\im_2023-11-09-20_39_50_plot_19.jpeg'
def relativized_path(win_path):
    """将位于sm的elements文件夹中的文件的绝对路径转换为相对路径.

    Args:
        url (str): url =
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


def im_download_and_convert(url, saved_path, collection_temp_path):
    """给定url, 下载图片并转换, 返回保存图片的绝对路径

    Args:
        url (str): img标签中的src值
        saved_path (_type_): 绝对路径, 保存img到指定目录

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
    now = time.strftime("%Y-%m-%d-%H_%M", time.localtime(time.time()))
    file_name = "im_" + now + "_uuid_" + str(uuid.uuid4())

    result_is_im = assure_image_url(url)

    if result_is_im:
        im_bytes = result_is_im[1]
        if result_is_im[0] not in supports_im_type:
            extension = result_is_im[0].split("/")[1]
            try:
                # temp_path = os.path.join(saved_path, "temp")
                mkdir(collection_temp_path)
                temp_file_path = os.path.join(
                    collection_temp_path, file_name + f".{extension}"
                )
                # 先把webp写到temp文件夹，然后再处理。
                with open(temp_file_path, "wb") as f:
                    f.write(im_bytes)

                # 转换图片格式。
                with Image.open(temp_file_path) as im:
                    print(im.format, im.size, im.mode)
                    # 这里是输出路径。
                    mkdir(saved_path)
                    saved_path = os.path.join(saved_path, file_name + ".png")
                    im.save(saved_path, "png")
                    return saved_path
            except Exception as e:
                print(f"An error occurred: {e}! Cannot convert {url}")
        else:
            extension = result_is_im[0].split("/")[1]
            # 如果支持的话，就直接写入的路径中即可。
            mkdir(saved_path)
            saved_path = os.path.join(saved_path, file_name + f".{extension}")
            # 必须先创建文件夹。
            with open(saved_path, "wb") as f:
                f.write(im_bytes)
            return saved_path
    else:
        print("警告！非图片资源链接 ", url)


def im_data_url_and_convert():
    print("这是一个Data URI scheme。svglib、pyvips")


def modify_src(html_doc, im_saved_path, elements_path, collection_temp_path):
    soup = BeautifulSoup(html_doc, "html.parser")
    elements_path = unified_path_separator(elements_path)

    img_tags = soup.find_all("img")
    # 过滤元素。去掉没有src属性以及属性值为空的。
    filtered_im_list = list(
        filter(lambda im: "src" in im.attrs and im.attrs["src"] != "", img_tags)
    )
    is_modify = False
    for im in filtered_im_list:
        # 中文的字符实体会自动变成正常的中文字符。
        # <img src="file:///C:/Users/Snowy/Desktop/sm18/&#24517;&#35835;&#65306;&#26053;&#36884;&#30340;&#24320;&#22987;.png">
        im_src = im.attrs["src"]
        if is_http_url_scheme(im_src):
            im_local_path = im_download_and_convert(
                im_src, im_saved_path, collection_temp_path
            )
            standard_path = unified_path_separator(im_local_path)
            im.attrs["src"] = relativized_path(standard_path)
            is_modify = True
        elif is_data_url_scheme(im_src):
            im_data_url_and_convert()
            # 如果是 Data URI scheme
            pass
        elif not is_relative_path(im_src):
            # 绝对路径
            # 去掉前缀
            if im_src.startswith("file:///"):
                fs_path = unquote(unified_path_separator(im_src.split("file:///")[1]))
            else:
                fs_path = unquote(unified_path_separator(im_src))
            # 判断在不在集合的元素文件夹中。
            if is_in_elements_directory(fs_path, elements_path):
                im.attrs["src"] = relativized_path(fs_path)
                is_modify = True
            else:
                # 不在，移动到集合元素文件夹的web_im_saved_path。
                local_pic = os.path.join(elements_path, "local_pic")
                im.attrs["src"] = relativized_path(
                    unified_path_separator(copy_to_elements(fs_path, local_pic))
                )
                is_modify = True
        elif is_relative_path(im_src):
            is_modify = False
    # 删除临时文件夹。
    # print("删除临时文件夹::", collection_temp_path)
    # shutil.rmtree(collection_temp_path)
    if is_modify:
        return soup.encode(encoding="ascii")
    else:
        return False


def secure_file_write(modified_content, target_file, temp_dir):
    """
    写入文件的安全机制——文件备份和临时文件；

    文件备份和临时文件将在函数完成后删除。

    Args:
        target_file (str): 目标文件
        temp_dir (str): 临时文件夹, 存储文件备份和临时文件
    """
    original_name = os.path.basename(target_file)
    backup_file = os.path.join(temp_dir, original_name + ".bak")
    temp_file = os.path.join(temp_dir, original_name + ".tmp")
    try:
        print("正在处理：", target_file)
        mkdir(temp_dir)
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


def collect_documents(elements_path):
    """在遍历查找HTM文档并返回文件路径列表。

    Args:
        element_path (str): elements路径

    Returns:
        list: 找到的HTM的文件列表
    """
    waiting_process_htm_files = []
    processed_count = 0

    def find_htm_files_in_directory(directory):
        nonlocal waiting_process_htm_files
        nonlocal processed_count
        with os.scandir(directory) as entries:
            for entry in entries:
                if entry.is_file() and is_html_file(entry.path):
                    waiting_process_htm_files.append(entry.path)
                    processed_count += 1
                    print(
                        "PathPix:: 正在收集HTM文件, 请稍后.",
                        f"[{processed_count}]\r",
                        end="",
                    )
                if entry.is_dir():
                    find_htm_files_in_directory(entry.path)

    find_htm_files_in_directory(elements_path)
    print("\nPathPix:: Done!")
    return waiting_process_htm_files


def relative_and_localize(
    waiting_process_list, elements_path, im_saved_path, collection_temp_path
):
    """在遍历查找到的html文挡, 一个个处理他们。

    Args:
        waiting_process_htm_files (_type_): _description_
        elements_path (_type_): _description_
        im_saved_path (_type_): _description_
        collection_temp_path (_type_): _description_
    """
    failed_process_htm_files = []
    processed_htm_files = []
    for htm_file_path in tqdm(waiting_process_list, desc="Doc-LinkCheck"):
        try:
            with open(htm_file_path, "rb") as f:
                raw_data = f.read()
                result = chardet.detect(raw_data)
                encoding = result["encoding"]
            content = raw_data.decode(encoding=encoding, errors="xmlcharrefreplace")

            modified_content = modify_src(
                content,
                im_saved_path,
                elements_path,
                collection_temp_path,
            )

            if modified_content:
                secure_file_write(modified_content, htm_file_path, collection_temp_path)
                processed_htm_files.append(htm_file_path)
        except Exception as e:
            failed_process_htm_files.append((htm_file_path, e))
            logger.warning((htm_file_path, e))

    if len(failed_process_htm_files) != 0:
        print("\033[0;31;40m", "一些文件处理失败, 请查看log文件", "\033[0m")
        os.startfile(LOG_FILE)
        # print("\033[0;31;40m", "以下文件处理失败：", "\033[0m")
        # for item in failed_process_htm_files:
        #     print(
        #         "\033[0;31;40m", f"Cannot process {item[0]}. \n\t{item[1]}", "\033[0m"
        #     )
    if len(processed_htm_files) == 0:
        print("\033[0;32m", "PathPix:: 无事可做。", "\033[0m")
    else:
        print("\033[0;32m", "以下文件已修改：", "\033[0m")
        for item in processed_htm_files:
            print(item)


def organize_unused_im(elements_path):
    im_list = []
    doc_im_set = set()

    webpic = os.path.join(elements_path, "web_pic")
    localpic = os.path.join(elements_path, "local_pic")
    temp_dir = os.path.normpath(os.path.join(elements_path, "../", "temp"))
    unused_pic = os.path.join(temp_dir, "unused_im")

    # 读取单个HTML文件中的被引用的im名字。
    def find_im(directory):
        im_list = []
        try:
            with os.scandir(directory) as entries:
                for entry in entries:
                    if entry.is_file():
                        im_list.append(entry.path)
        except FileNotFoundError:
            pass
        return im_list

    is_exists_webpic = os.path.exists(webpic)
    is_exists_localpic = os.path.exists(localpic)
    if is_exists_webpic or is_exists_localpic:
        print("PathPix::", "清理web_pic, local_pic文件夹中从未被使用的图片")
        im_list = find_im(webpic) + find_im(localpic)

        for htm_file_path in tqdm(
            collect_documents(elements_path), desc="Doc-ImGather"
        ):
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
                        lambda im: "src" in im.attrs and im.attrs["src"] != "",
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
            im_fname = os.path.basename(im)
            if im_fname not in doc_im_set:
                unused_pic_list.append(im)

        if len(unused_pic_list) > 0:
            for im in unused_pic_list:
                try:
                    print("正在处理：", os.path.basename(im))
                    mkdir(unused_pic)
                    # 将一个文件或文件夹从 src 移动到 dst 如果 dst 已存在且为文件夹，则 src 将会被移动到 dst内。
                    shutil.move(im, unused_pic)
                except Exception as e:
                    print(f"移动unused_pic时发生错误: {str(e)}")
        else:
            print("PathPix:: 无事可做。")
    else:
        print("PathPix:: 未处理过此集合, web_pic 和 local_pic 文件夹不存在。")


def start(elements_path):
    collection_temp_path = os.path.normpath(os.path.join(elements_path, "../", "temp"))
    save_img_folder = os.path.normpath(os.path.join(elements_path, "web_pic"))
    local_pic = os.path.normpath(os.path.join(elements_path, "local_pic"))
    print("集合元素：", elements_path)
    print("图片位置：", [save_img_folder, local_pic])
    print("临时文件：", collection_temp_path)
    waiting_process_list = collect_documents(elements_path)
    relative_and_localize(
        waiting_process_list, elements_path, save_img_folder, collection_temp_path
    )


# start("C:/Users/Snowy/Desktop/sm18/systems/all in one/elements")
# start("D:/SuperMemo/systems/ALL IN ONE/elements")
# organize_unused_im("D:/SuperMemo/systems/Reading-And-Review/elements")

import os
import re
from bs4 import BeautifulSoup

import requests


def is_md_ext_file(file_path):
    file_ext = os.path.splitext(file_path)[1].lower()
    return file_ext in [".md"]


def is_start_with_num(path):
    num_partten = r"\d\d"
    basename = os.path.basename(path)
    num = re.findall(num_partten, basename)
    if len(num) > 0 and int(num[0]) > 0:
        return True
    else:
        return False


def iter_dir(folder: str):
    file_list = []
    count_processed = 0

    stack = [folder]
    while stack:
        current_path = stack.pop()
        for entry in os.scandir(current_path):
            if (
                entry.is_file()
                and is_md_ext_file(entry.path)
                and is_start_with_num(entry.path)
            ):
                # 必须是md文件，且文件名称开头首先是数字，其次必须大于1（从01开始）。
                file_list.append(entry.path)
                count_processed += 1
                print(
                    "正在计算文件总数",
                    f"[{count_processed}]",
                    end="\r",
                )
            if entry.is_dir() and is_start_with_num(entry.path):
                stack.append(entry.path)
    print(f"\n共找到 {count_processed} 个文件")
    return file_list


def read_file(path_list):
    origin_list = list()
    for path in path_list:
        with open(path, "r", encoding="utf-8") as f:
            origin_list = f.readlines()
        for index, iterm in enumerate(origin_list):
            if "class" not in iterm:
                del origin_list[index]
        for index, iterm in enumerate(origin_list):
            if "category" in iterm:
                pass


# a = iter_dir(
#     "D:/Dropbox/00-TMP/英语词义分类数据库（大学版）（带词汇表目录）/英语词义分类数据库（大学版）"
# )
# read_file(a)

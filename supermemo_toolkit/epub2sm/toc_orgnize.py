import re
import urllib.parse
from copy import deepcopy

import ebooklib
from bs4 import BeautifulSoup
from ebooklib import epub


def 规范化链接(链接):
    """去锚点、URL 解码、统一斜杠。"""
    if not 链接:
        return ""
    链接 = 链接.split("#", 1)[0]
    链接 = urllib.parse.unquote(链接)
    return 链接.replace("\\", "/").lstrip("./")


def 遍历目录链接(目录):
    """递归产出目录中所有条目指向的文档路径（已规范化）。"""
    for 条目 in 目录:
        if isinstance(条目, epub.Link):
            yield 规范化链接(条目.href)
        elif isinstance(条目, tuple) and len(条目) == 2:
            头部, 子项 = 条目
            # Link 和 Section 都要 yield 自身
            if isinstance(头部, (epub.Section, epub.Link)):
                yield 规范化链接(头部.href)
            if isinstance(子项, list):
                yield from 遍历目录链接(子项)


def 收集目录链接集合(书籍):
    return {链接 for 链接 in 遍历目录链接(书籍.toc) if 链接}


def 是否在目录中(书籍, 文档, 目录链接集合=None):
    """判断文档是否在目录中。目录链接集合可传入以复用。"""
    链接集合 = 目录链接集合 if 目录链接集合 is not None else 收集目录链接集合(书籍)
    return 规范化链接(文档.file_name) in 链接集合


def 补全目录文档分类(书籍):
    """
    分类书籍中的所有文档：
      头部文档列表: 目录之前出现的、不在目录中的文档，每项 (文件名, [])
      正文分类列表: 目录中出现的文档，以及每个目录文档后紧跟的、不在目录中的兄弟文档
                    每项 (目录文件名, [兄弟文件名, ...])
    """
    目录链接集合 = 收集目录链接集合(书籍)
    头部文档列表, 正文分类列表 = [], []
    已遇到目录文档 = False

    for 文档 in 书籍.get_items_of_type(ebooklib.ITEM_DOCUMENT):
        文档在目录中 = 规范化链接(文档.file_name) in 目录链接集合

        if not 已遇到目录文档:
            if 文档在目录中:
                已遇到目录文档 = True
                正文分类列表.append((文档.file_name, []))
            else:
                头部文档列表.append((文档.file_name, []))
        else:
            if 文档在目录中:
                正文分类列表.append((文档.file_name, []))
            else:
                正文分类列表[-1][1].append(文档.file_name)

    return 头部文档列表, 正文分类列表


def 清理标题(原始文本, 最大长度=35):
    """去掉控制字符（含换行）、折叠空白、截断。"""
    文本 = re.sub(r"[\x00-\x1f\x7f]", "", 原始文本)
    文本 = re.sub(r"\s+", " ", 文本).strip()
    return 文本[:最大长度] or "无标题"


def 创建链接(书籍, 链接):
    文档 = 书籍.get_item_with_href(链接)
    if 文档 is None:
        return epub.Link(href=链接, title="无标题")
    try:
        文档树 = BeautifulSoup(文档.content, "html.parser")
        原始文本 = 文档树.get_text()
    except Exception:
        原始文本 = ""
    return epub.Link(href=链接, title=清理标题(原始文本))


def 插入兄弟文档(章节列表, 目标链接, 新链接列表):
    """在目录中查找目标链接对应项，在其后（或子项内）插入新链接列表。"""
    目标链接规范化 = 规范化链接(目标链接)
    待查列表 = [章节列表]

    while 待查列表:
        当前列表 = 待查列表.pop()
        for 位置, 条目 in enumerate(当前列表):
            if isinstance(条目, epub.Link):
                if 规范化链接(条目.href) == 目标链接规范化:
                    for 序号, 链接 in enumerate(新链接列表):
                        当前列表.insert(位置 + 1 + 序号, 链接)
                    return True

            elif isinstance(条目, tuple) and len(条目) == 2:
                头部, 子项 = 条目
                if (
                    isinstance(头部, (epub.Section, epub.Link))
                    and 规范化链接(头部.href) == 目标链接规范化
                ):
                    if isinstance(子项, list) and 子项:
                        # 有子项：并入 Section 开头
                        for 序号, 链接 in enumerate(新链接列表):
                            子项.insert(序号, 链接)
                    else:
                        # 无子项：平级插入 Section 之后
                        for 序号, 链接 in enumerate(新链接列表):
                            当前列表.insert(位置 + 1 + 序号, 链接)
                    return True

                if isinstance(子项, list):
                    待查列表.append(子项)

    return False


def 合并目录(书籍):
    头部文档列表, 正文分类列表 = 补全目录文档分类(书籍)

    # 深拷贝：后续 insert 只改副本，多次调用不会重复插入
    目录副本 = deepcopy(书籍.toc)

    头部链接列表 = [创建链接(书籍, 名称) for 名称, _ in 头部文档列表]
    最终章节列表 = 头部链接列表 + 目录副本

    for 目录中已有文档, 兄弟文档列表 in 正文分类列表:
        if not 兄弟文档列表:
            continue
        新链接列表 = [创建链接(书籍, 链接) for 链接 in 兄弟文档列表]
        if not 插入兄弟文档(最终章节列表, 目录中已有文档, 新链接列表):
            # 兜底：找不到插入位置时追加到末尾，保证不遗漏文档
            print(
                f"警告：未在目录中找到 {目录中已有文档}，"
                f"以下文档追加到末尾：{兄弟文档列表}"
            )
            最终章节列表.extend(新链接列表)

    return 最终章节列表


def 检查遗漏文档(书籍, 章节列表):
    """调试用：校验所有 ITEM_DOCUMENT 都出现在最终目录中。"""

    def 展开链接(目录):
        for 条目 in 目录:
            if isinstance(条目, epub.Link):
                yield 规范化链接(条目.href)
            elif isinstance(条目, tuple) and len(条目) == 2:
                头部, 子项 = 条目
                if isinstance(头部, (epub.Section, epub.Link)):
                    yield 规范化链接(头部.href)
                if isinstance(子项, list):
                    yield from 展开链接(子项)

    输入集合 = {
        规范化链接(文档.file_name)
        for 文档 in 书籍.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    }
    输出集合 = set(展开链接(章节列表))
    遗漏集合 = 输入集合 - 输出集合
    if 遗漏集合:
        print(f"遗漏文档：{遗漏集合}")
    else:
        print("无遗漏")
    return not 遗漏集合


if __name__ == "__main__":
    书籍 = epub.read_epub(
        r"D:\Dropbox\21-Sandox\图书专题\东尼·博赞.epub",
        {"ignore_ncx": True},
    )
    章节列表 = 合并目录(书籍)
    检查遗漏文档(书籍, 章节列表)

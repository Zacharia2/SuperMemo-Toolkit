import re
import urllib.parse
from copy import deepcopy

import ebooklib
from bs4 import BeautifulSoup
from ebooklib import epub


def _normalize_href(href):
    """去锚点、URL 解码、统一斜杠。"""
    if not href:
        return ""
    href = href.split("#", 1)[0]
    href = urllib.parse.unquote(href)
    return href.replace("\\", "/").lstrip("./")


def _iter_toc_hrefs(chapters):
    """递归产出目录中所有条目指向的文档路径（已规范化）。"""
    for chapter in chapters:
        if isinstance(chapter, epub.Link):
            yield _normalize_href(chapter.href)
        elif isinstance(chapter, tuple) and len(chapter) == 2:
            head, children = chapter
            # Link 和 Section 都要 yield 自身
            if isinstance(head, (epub.Section, epub.Link)):
                yield _normalize_href(head.href)
            if isinstance(children, list):
                yield from _iter_toc_hrefs(children)


def _collect_toc_hrefs(book):
    return {h for h in _iter_toc_hrefs(book.toc) if h}


def in_toc(book, doc, toc_hrefs=None):
    """判断 doc 是否在 toc 中。toc_hrefs 可传入以复用。"""
    hrefs = toc_hrefs if toc_hrefs is not None else _collect_toc_hrefs(book)
    return _normalize_href(doc.file_name) in hrefs


def complete_toc_with_documents(book):
    """
    分类 book 中的所有文档：
      Head: toc 之前出现的、不在 toc 中的文档，每项 (file_name, [])
      Body: toc 中出现的文档，以及每个 toc 文档后紧跟的、不在 toc 中的兄弟文档
            每项 (toc_file_name, [sibling_file_name, ...])
    """
    toc_hrefs = _collect_toc_hrefs(book)
    Head, Body = [], []
    first_toc_checked = False

    for doc in book.get_items_of_type(ebooklib.ITEM_DOCUMENT):
        in_toc_doc = _normalize_href(doc.file_name) in toc_hrefs

        if not first_toc_checked:
            if in_toc_doc:
                first_toc_checked = True
                Body.append((doc.file_name, []))
            else:
                Head.append((doc.file_name, []))
        else:
            if in_toc_doc:
                Body.append((doc.file_name, []))
            else:
                Body[-1][1].append(doc.file_name)

    return Head, Body


def _clean_title(raw, max_len=35):
    """去掉控制字符（含换行）、折叠空白、截断。"""
    text = re.sub(r"[\x00-\x1f\x7f]", "", raw)
    text = re.sub(r"\s+", " ", text).strip()
    return text[:max_len] or "无标题"


def _make_link(book, href):
    doc = book.get_item_with_href(href)
    if doc is None:
        return epub.Link(href=href, title="无标题")
    try:
        soup = BeautifulSoup(doc.content, "html.parser")
        raw = soup.get_text()
    except Exception:
        raw = ""
    return epub.Link(href=href, title=_clean_title(raw))


def _insert_siblings(chapters, target_href, new_links):
    """在 toc 中查找 target_href 对应项，在其后（或子项内）插入 new_links。"""
    target = _normalize_href(target_href)
    stack = [chapters]

    while stack:
        curr = stack.pop()
        for idx, chapter in enumerate(curr):
            if isinstance(chapter, epub.Link):
                if _normalize_href(chapter.href) == target:
                    for j, link in enumerate(new_links):
                        curr.insert(idx + 1 + j, link)
                    return True

            elif isinstance(chapter, tuple) and len(chapter) == 2:
                head, children = chapter
                if (
                    isinstance(head, (epub.Section, epub.Link))
                    and _normalize_href(head.href) == target
                ):
                    if isinstance(children, list) and children:
                        # 有子项：并入 Section 开头
                        for j, link in enumerate(new_links):
                            children.insert(j, link)
                    else:
                        # 无子项：平级插入 Section 之后
                        for j, link in enumerate(new_links):
                            curr.insert(idx + 1 + j, link)
                    return True

                if isinstance(children, list):
                    stack.append(children)

    return False


def merge_doc(book):
    Head, Body = complete_toc_with_documents(book)

    # 深拷贝：后续 insert 只改副本，多次调用不会重复插入
    toc_copy = deepcopy(book.toc)

    H_list = [_make_link(book, name) for name, _ in Head]
    epub_chapters = H_list + toc_copy

    for exist_toc_of_doc, sibling_doc_list in Body:
        if not sibling_doc_list:
            continue
        new_links = [_make_link(book, href) for href in sibling_doc_list]
        if not _insert_siblings(epub_chapters, exist_toc_of_doc, new_links):
            # 兜底：找不到插入位置时追加到末尾，保证不遗漏文档
            print(
                f"警告：未在 toc 中找到 {exist_toc_of_doc}，"
                f"以下文档追加到末尾：{sibling_doc_list}"
            )
            epub_chapters.extend(new_links)

    return epub_chapters


def check_no_missing(book, chapters):
    """调试用：校验所有 ITEM_DOCUMENT 都出现在最终 toc 中。"""

    def flatten(chs):
        for c in chs:
            if isinstance(c, epub.Link):
                yield _normalize_href(c.href)
            elif isinstance(c, tuple) and len(c) == 2:
                head, children = c
                if isinstance(head, (epub.Section, epub.Link)):
                    yield _normalize_href(head.href)
                if isinstance(children, list):
                    yield from flatten(children)

    input_set = {
        _normalize_href(d.file_name)
        for d in book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    }
    output_set = set(flatten(chapters))
    missing = input_set - output_set
    if missing:
        print(f"遗漏文档：{missing}")
    else:
        print("无遗漏")
    return not missing


if __name__ == "__main__":
    book = epub.read_epub(
        r"D:\Dropbox\21-Sandox\图书专题\东尼·博赞.epub",
        {"ignore_ncx": True},
    )
    chapters = merge_doc(book)
    check_no_missing(book, chapters)

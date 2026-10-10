import copy
import io
import os
import shutil
from pathlib import Path

import ebooklib
from bs4 import BeautifulSoup, Doctype, NavigableString, Tag
from ebooklib import epub
from PIL import Image
from reportlab.graphics import renderPM
from svglib.svglib import svg2rlg
from yattag import Doc

from supermemo_toolkit.epub2sm import toc_check, toc_orgnize
from supermemo_toolkit.utilscripts.ulils import (
    escape_sequence,
    get_id_func,
    makeNameSafe,
    mkdir,
    trans_pinyin,
)

get_id = get_id_func()
id_counts = 0


def long_path(path):
    """Windows 下给路径加 \\\\?\\ 前缀，绕过 260 字符限制。非 Windows 平台原样返回。"""
    if os.name != "nt":
        return path
    path = os.path.abspath(path)
    if path.startswith("\\\\?\\"):
        return path
    if path.startswith("\\\\"):  # UNC 路径
        return "\\\\?\\UNC\\" + path[2:]
    return "\\\\?\\" + path


def modify_img_url(book, doc, folder_name):
    soup = BeautifulSoup(doc, "html.parser")
    # 删除DOCTYPE定义
    for item in soup.contents:
        if isinstance(item, Doctype):
            item.extract()
            break

    # 处理图片
    doc_imgs = soup.find_all("img")

    not_support = [
        (os.path.basename(image.file_name).lower(), image.file_name)
        for image in book.get_items()
        if image.media_type == "image/svg+xml" or image.media_type == "image/webp"
    ]
    not_support_1 = [f[0] for f in not_support]

    for doc_img in doc_imgs:
        # 处理svg和webp图片，转换为png格式
        doc_img_name = os.path.basename(doc_img.attrs["src"])
        if len(not_support) != 0 and doc_img_name in not_support_1:
            _, image_file_name = not_support[not_support_1.index(doc_img_name.lower())]
            image = book.get_item_with_href(image_file_name)
            if image.media_type == "image/svg+xml":
                output_buffer = io.BytesIO()
                renderPM.drawToPIL(svg2rlg(io.BytesIO(image.content))).save(
                    output_buffer, format="PNG"
                )
                image.content = output_buffer.getvalue()
                name, _ = os.path.splitext(image.file_name)
                image.file_name = name + ".png"
                image.media_type = "image/png"
            if image.media_type == "image/webp":
                output_buffer = io.BytesIO()
                Image.open(io.BytesIO(image.content)).convert("RGBA").save(
                    output_buffer, format="PNG"
                )
                image.content = output_buffer.getvalue()
                name, _ = os.path.splitext(image.file_name)
                image.file_name = name + ".png"
                image.media_type = "image/png"
            doc_img.attrs["src"] = (
                f"file:///[PrimaryStorage]local_pic/{folder_name}/{image.file_name}"
            )
        # 受支持的图片
        doc_img.attrs["src"] = (
            f"file:///[PrimaryStorage]local_pic/{folder_name}/{doc_img_name}"
        )
    doc = str(soup.encode(encoding="ascii"), "utf-8")
    return doc.replace("\n", "").replace("\r", "")


def split_anchor_point(html: str, anchor_point: str, anchor_points: list) -> str:
    """
    按锚点线性切分 HTML，返回从「文档开始或当前锚点（含）」到「下一个锚点（不含）或文档结束」的独立 HTML 片段。
    """
    # 保留了文章的完整性。虽然这种方式会第一个切分对象或整个子元素对象和他的父目录（完整文档）产生重复内容。
    # 开始位置分为两种情况，一种是锚点是body的第一个元素，另一种是锚点在body第一个元素之后。
    # 结束位置分为两种情况，一种是下一个锚点在这个锚点之后，另一种是当前锚点是body的最后一个元素。
    # 文档是h1-h6标签分层的。他是有树形层次关系的。但是目录的指向位置是锚点，锚点在视觉上就是一个切分位置。
    # 在文档中是线性顺序的。所以可以根据锚点作为切分点切分文档。
    if not html and not html.strip():
        return " "

    soup = BeautifulSoup(html, "html.parser")
    cur = soup.find(id=anchor_point)
    if not cur:
        return ""

    try:
        idx = anchor_points.index(anchor_point)
    except ValueError:
        return ""

    next_anchor = anchor_points[idx + 1] if idx + 1 < len(anchor_points) else None
    # next_elem = soup.find(id=next_anchor) if next_anchor else None

    # 深拷贝，避免修改原文档
    soup_copy = copy.deepcopy(soup)
    cur_copy = soup_copy.find(id=anchor_point)
    next_copy = soup_copy.find(id=next_anchor) if next_anchor else None

    # 确定起始节点
    if idx == 0:
        if soup_copy.body and soup_copy.body.contents:
            start_node = soup_copy.body.contents[0]
        else:
            start_node = next(soup_copy.descendants, None)
    else:
        start_node = cur_copy

    if not start_node:
        return " "

    # 收集从 start_node 到 next_copy 之前的所有节点（按文档顺序）
    nodes_to_move = []
    collecting = False
    for node in soup_copy.descendants:
        if node is start_node:
            collecting = True
        if collecting:
            if next_copy and node is next_copy:
                break
            nodes_to_move.append(node)

    if not nodes_to_move:
        return " "

    # 过滤出顶级节点，避免重复
    top_nodes = []
    for node in nodes_to_move:
        ancestors = list(node.parents)
        if any(anc in nodes_to_move for anc in ancestors):
            continue
        top_nodes.append(node)

    # 递归修剪函数，删除包含 next_copy 的子树
    def trim_node(node, target):
        """从 node 中删除 target 及其后面的兄弟节点，若 target 在后代中则递归修剪"""
        if node is target:
            node.decompose()
            return True
        # 只有 Tag 才有 children，NavigableString 无子节点
        if not isinstance(node, Tag):
            return False
        for child in list(node.children):
            if child is target:
                # 删除 target 及其所有后续兄弟
                while child:
                    nxt = child.next_sibling
                    child.decompose()
                    child = nxt
                return True
            else:
                if trim_node(child, target):
                    return True
        return False

    if next_copy:
        for tn in top_nodes:
            trim_node(tn, next_copy)

    # 创建新容器，移动修剪后的顶级节点
    new_soup = BeautifulSoup('<div class="extracted-section"></div>', "html.parser")
    container = new_soup.div
    for node in top_nodes:
        container.append(node)  # 直接移动节点

    return str(new_soup)


def get_content(book: epub.EpubBook, href: str, anchor_points: dict = {}):
    # 锚点类型必须提供锚点列表，文件类型不需要提供。
    # 备用方案：编辑epub目录或者修改epub自己分割好并映射好目录和内容。
    if "#" in href and len(anchor_points) > 0:
        # 锚点类型
        doc_href, anchor_point = href.split("#")
        doc = book.get_item_with_href(doc_href)
        anchor_points = anchor_points.get(doc_href)
        html = doc.content.decode("utf-8") if doc else " "
        # 根据锚点取出锚点区间的内容。区间 [文档开始或锚点开始含自己，下一个锚点不含自己或文档结束]
        section = split_anchor_point(html, anchor_point, anchor_points)
        return escape_sequence(section)
    else:
        # 文件类型
        doc = book.get_item_with_href(href.split("#")[0] if "#" in href else href)
        content = doc.content.decode("utf-8") if doc else " "
    return escape_sequence(content)


def get_anchor_point_list(chapters):
    def recursion(chapters):
        anchor_points = []
        for chapter in chapters:
            if isinstance(chapter, epub.Link):
                doc_href, anchor_point = (
                    chapter.href.split("#")
                    if "#" in chapter.href
                    else (chapter.href, "")
                )
                anchor_points.append((doc_href, anchor_point))
            elif isinstance(chapter, tuple):
                section, elements = chapter
                doc_href, anchor_point = (
                    section.href.split("#")
                    if "#" in section.href
                    else (section.href, "")
                )
                anchor_points.append((doc_href, anchor_point))
                if len(elements) > 0:
                    anchor_points.extend(recursion(elements))
        return [(x, y) for x, y in anchor_points if str(y).strip() != ""]

    anchor_point_list = recursion(chapters)
    anchor_point_dict = {}
    for href, anchor_point in anchor_point_list:
        if href in anchor_point_dict:
            anchor_point_dict[href].append(anchor_point)
        else:
            anchor_point_dict[href] = [anchor_point]

    return anchor_point_dict


def get_docs_by_toc(book, chapters, folder_name):
    global id_counts
    el_list = []
    anchor_points = get_anchor_point_list(chapters)
    for chapter in chapters:
        # 把这一层处理好，再去处理下一层。这一层和下一层的逻辑一致。
        # 循环chapter
        if isinstance(chapter, epub.Link):
            doc, tag, text = Doc().tagtext()
            title = chapter.title
            href = chapter.href
            with tag("ID"):
                text(get_id())
            with tag("Type"):
                text("Topic")
            with tag("Title"):
                text(title)
            with tag("Content"), tag("Question"):
                text(
                    modify_img_url(
                        book, get_content(book, href, anchor_points), folder_name
                    )
                )
            id_counts += 1
            el_list.append(doc.getvalue())
        elif isinstance(chapter, tuple):
            # 是元组的时候就说明是有子集的数据。
            # 元组的第一个是本层Element章节，第二个是Element的循环的集合，子章节
            doc, tag, text = Doc().tagtext()
            sm_section, sm_element = chapter
            title = sm_section.title
            href = sm_section.href
            with tag("ID"):
                text(get_id())
            with tag("Type"):
                text("Topic")
            with tag("Title"):
                text(title)
            with tag("Content"), tag("Question"):
                text(
                    modify_img_url(
                        book, get_content(book, href, anchor_points), folder_name
                    )
                )
            if len(sm_element) > 0:
                # 当元组的第二个元素有子元素的时候。此集合名，循环的集合元素
                # 这里生成多个SuperMemoElement
                el_sublist = get_docs_by_toc(book, sm_element, folder_name)
                for el in el_sublist:
                    with tag("SuperMemoElement"):
                        doc.asis(el)
            id_counts += 1
            el_list.append(doc.getvalue())
    return el_list


def get_docs_by_doclist(book, folder_name):
    global id_counts
    el_list = []
    doc_list = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    for doc in doc_list:
        href = doc.file_name
        content = modify_img_url(book, get_content(book, href), folder_name)
        doc, tag, text = Doc().tagtext()
        with tag("ID"):
            text(get_id())
        with tag("Type"):
            text("Topic")
        with tag("Content"), tag("Question"):
            text(content)
        id_counts += 1
        el_list.append(doc.getvalue())
    return el_list


def merge_epub_to_topic(book, folder_name):
    # 只取body内的元素合并。忽略其他，因为sm不需要。
    doc_list = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    epub_topic = ""
    for doc in doc_list:
        # 将一本书合并为一个html。
        href = doc.file_name
        doc = book.get_item_with_href(href)
        content = doc.content.decode("utf-8") if doc else ""
        soup = BeautifulSoup(content, "html.parser")
        p_list = soup.find_all("p")
        for p in p_list:
            if "\n" in p.text:
                p.string = str(p.text).replace("\n", " ")
        html_body = soup.find("body")
        for child in html_body.children:
            epub_topic += str(child)
    doc = modify_img_url(book, epub_topic, folder_name)
    return doc


def write_img_file(ebook: epub.EpubBook, book_img_folder: str) -> None:
    """写出img文件到SuperMemo-XML-Book文件旁边的文件夹中。"""
    for image in ebook.get_items_of_type(ebooklib.ITEM_IMAGE):
        # 可以得到image.file_name 和 image.content 二进制数据、image.media_type
        # os.path.abspath(".")
        if not os.path.exists(book_img_folder):
            mkdir(book_img_folder)
        if image.file_name.find("/") != -1:
            filename = image.file_name.split("/")[-1]
            file = os.path.join(book_img_folder, filename)
        else:
            file = os.path.join(book_img_folder, image.file_name)
        with open(long_path(file), "wb") as f:
            f.write(image.content)


def split_html_with_lenght(book, book_f_name, limit_num):
    html = merge_epub_to_topic(book, book_f_name).replace("\n", "")
    soup = BeautifulSoup(html, "html.parser")

    def recursion(node, words=0):
        if isinstance(node, NavigableString):
            # 说明是叶子
            # 叶子就开始计数，当达到数量后，找到父节点然后再父节点下一个位置插入hr水平标签。
            words += len(str(node))
            if words > limit_num and node.parent:
                node_index = node.parent.index(node)
                node.parent.insert(node_index + 1, soup.new_tag("hr"))
                words = 0

        elif isinstance(node, Tag):
            # 说明是分支
            # 如果是分支就要找到他的子元素数量，如果子元素是NavigableString则计数
            # 如果子元素是Tag则进入。
            for child in node.contents:
                # 设置当前层字数
                words = recursion(child, words)
        # 返回子层字数
        return words

    recursion(soup)
    doc = str(soup.encode(encoding="ascii"), "utf-8")
    return doc.replace("\n", "").replace("\r", "")


def move_folder(src, dst_parent):
    src = Path(src)
    dst_parent = Path(dst_parent)

    if not src.is_dir():
        print(f"源文件夹不存在或不是文件夹: {src}")
        return

    dst_parent.mkdir(parents=True, exist_ok=True)
    target = dst_parent / src.name

    if target.exists():
        print(f"目标已存在: {target}")
        return

    shutil.move(str(src), str(dst_parent))


def filename_length_check_pass(book_f_name, max_len=255):
    filename = book_f_name + ".xml"

    utf8_bytes = len(filename.encode("utf-8"))
    utf16_units = len(filename.encode("utf-16-le")) // 2

    if utf8_bytes > max_len or utf16_units > max_len:
        print(
            f"警告：文件名过长"
            f" (UTF-8 {utf8_bytes} 字节, UTF-16 {utf16_units} 码元，限制 {max_len}), "
            f"请缩短文件名。"
        )
        return False

    return True


def start_with_toc(epub_file, save_folder, save_image_folder=None):
    # UserWarning: In the future version we will turn default option ignore_ncx to True.
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    if not filename_length_check_pass(book_f_name):
        return
    print("开始处理书籍：", book_f_name)
    # 创建数据结构
    toc = toc_orgnize.merge_doc(book)
    diff_list = toc_check.contrast_diff_toc(toc, book)
    # 验证内容完整性
    if len(diff_list) != 0:
        print("内容完整性: False;/n", diff_list)
        return
    doc, tag, text = Doc().tagtext()
    mid = get_id()
    el_list = get_docs_by_toc(book, toc, book_f_name)
    with tag("SuperMemoCollection"):
        with tag("Count"):
            text(id_counts + 1)
        with tag("SuperMemoElement"):
            with tag("ID"):
                text(mid)
            with tag("Title"):
                text(book.title)
            with tag("Type"):
                text("Concept")
            for element in el_list:
                with tag("SuperMemoElement"):
                    doc.asis(element)
    file = long_path(os.path.join(os.path.abspath(save_folder), book_f_name + ".xml"))
    folder = os.path.join(os.path.abspath(save_folder), book_f_name)
    with open(file, "w", encoding="utf-8") as f:
        f.write(doc.getvalue())
    write_img_file(book, folder)
    if save_image_folder:
        move_folder(folder, save_image_folder)
    print("转换完成，已存储至：", os.path.abspath(save_folder))


def start_with_seq(epub_file, save_folder, save_image_folder=None):
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    print("开始处理书籍：", book_f_name)
    if not filename_length_check_pass(book_f_name):
        return
    doc, tag, text = Doc().tagtext()
    mid = get_id()
    el_list = get_docs_by_doclist(book, book_f_name)
    with tag("SuperMemoCollection"):
        with tag("Count"):
            text(id_counts + 1)
        with tag("SuperMemoElement"):
            with tag("ID"):
                text(mid)
            with tag("Title"):
                text(book.title)
            with tag("Type"):
                text("Concept")
            for element in el_list:
                with tag("SuperMemoElement"):
                    doc.asis(element)
    file = long_path(os.path.join(os.path.abspath(save_folder), book_f_name + ".xml"))
    folder = os.path.join(os.path.abspath(save_folder), book_f_name)
    with open(file, "w", encoding="utf-8") as f:
        f.write(doc.getvalue())
    write_img_file(book, folder)
    if save_image_folder:
        move_folder(folder, save_image_folder)
    print("转换完成，已存储至：", os.path.abspath(save_folder))


def start_with_topic(epub_file, save_folder, limit_num, save_image_folder=None):
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    if not filename_length_check_pass(book_f_name):
        return
    print("开始处理书籍：", book_f_name)

    doc, tag, text, line = Doc().ttl()
    if limit_num:
        topic_doc = split_html_with_lenght(book, book_f_name, limit_num)
    else:
        topic_doc = merge_epub_to_topic(book, book_f_name)
    with tag("SuperMemoCollection"):
        line("Count", 1)
        with tag("SuperMemoElement"):
            line("ID", 1)
            line("Title", book.title)
            line("Type", "Topic")
            with tag("Content"), tag("Question"):
                text(topic_doc)
    file = long_path(os.path.join(os.path.abspath(save_folder), book_f_name + ".xml"))
    folder = os.path.join(os.path.abspath(save_folder), book_f_name)
    with open(file, "w", encoding="utf-8") as f:
        f.write(doc.getvalue())
    write_img_file(book, folder)
    if save_image_folder:
        move_folder(folder, save_image_folder)
    print("转换完成，已存储至：", os.path.abspath(save_folder))


if __name__ == "__main__":
    start_with_toc(r"D:\Calibre Library\Calibre 花园\Kong Zi\Zhu Zi Bai Jia Xi Lie Tao Zhuang [(T (85)\Zhu Zi Bai Jia Xi Lie Tao Zhuan - Kong Zi.epub", r"C:\Users\Snowy\Desktop")

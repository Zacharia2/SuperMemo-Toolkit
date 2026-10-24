import io
import os
import shutil
from pathlib import Path

import ebooklib
from bs4 import BeautifulSoup, Comment, Doctype, NavigableString, Tag
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
_split_cache = {}


def _reset_state():
    """每本书开始处理前重置全局状态，避免多次转换串数据。"""
    global id_counts
    id_counts = 0
    _split_cache.clear()


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


def _soup_to_ascii(soup):
    """把 BeautifulSoup 对象转成纯 ASCII 字符串，非 ASCII 字符用字符实体表示。"""
    return str(soup).encode("ascii", "xmlcharrefreplace").decode("ascii")


def modify_img_url(book, doc, folder_name):
    soup = BeautifulSoup(doc, "html.parser")
    # 删除DOCTYPE定义
    for item in soup.contents:
        if isinstance(item, Doctype):
            item.extract()
            break

    # 可转换图片：basename(小写) -> image 对象
    convert_map = {}
    for image in book.get_items():
        if image.media_type in ("image/svg+xml", "image/webp"):
            convert_map[os.path.basename(image.file_name).lower()] = image

    for doc_img in soup.find_all("img"):
        src = doc_img.attrs.get("src")
        if not src:
            continue
        doc_img_name = os.path.basename(src)
        image = convert_map.get(doc_img_name.lower())

        if image is not None:
            if image.media_type == "image/svg+xml":
                output_buffer = io.BytesIO()
                renderPM.drawToPIL(svg2rlg(io.BytesIO(image.content))).save(
                    output_buffer, format="PNG"
                )
                image.content = output_buffer.getvalue()
                name, _ = os.path.splitext(image.file_name)
                image.file_name = name + ".png"
                image.media_type = "image/png"
            elif image.media_type == "image/webp":
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
        else:
            doc_img.attrs["src"] = (
                f"file:///[PrimaryStorage]local_pic/{folder_name}/{doc_img_name}"
            )

    return _soup_to_ascii(soup).replace("\n", "").replace("\r", "")


def _collect_events(root):
    """对 root 的子节点做 DFS，生成 (kind, payload) 事件流。"""
    events = []

    def dfs(node):
        if isinstance(node, Tag):
            events.append(("open", node))
            for child in node.children:
                dfs(child)
            events.append(("close", node))
        elif isinstance(node, Comment):
            events.append(("comment", str(node)))
        elif isinstance(node, Doctype):
            pass
        elif isinstance(node, NavigableString):
            events.append(("text", str(node)))

    for child in root.children:
        dfs(child)
    return events


def _build_segment(events, start, end, prefix_stack):
    """从事件流 [start, end) 重建 HTML；段外未闭合的祖先补空壳。"""
    soup = BeautifulSoup('<div class="extracted-section"></div>', "html.parser")
    container = soup.div

    # 补全段外的祖先空壳（从外到内），跳过 id/name 避免产生重复 id
    current = container
    for anc in prefix_stack:
        shell = soup.new_tag(anc.name)
        for k, v in anc.attrs.items():
            if k in ("id", "name"):
                continue
            shell[k] = v
        current.append(shell)
        current = shell

    stack = [current]
    for i in range(start, end):
        kind, payload = events[i]
        if kind == "open":
            node = payload
            new_tag = soup.new_tag(node.name)
            for k, v in node.attrs.items():
                new_tag[k] = v
            stack[-1].append(new_tag)
            stack.append(new_tag)
        elif kind == "close":
            if len(stack) > 1:
                stack.pop()
        elif kind == "text":
            stack[-1].append(NavigableString(payload))
        elif kind == "comment":
            stack[-1].append(Comment(payload))

    return str(soup.div)


def split_html_by_toc(html, anchor_points, remove_overlap=True):
    """
    按目录顺序切分某文档。

    anchor_points: 该文档在目录中出现的锚点顺序列表（目录顺序）。
    返回 {anchor_id: segment_html}。

    每个锚点的区间：
      起点 = 该锚点在文档中的位置；若是目录中该文档的第一个锚点，则从文档开头算起。
      终点 = 目录中下一个锚点在文档中的位置（不含）；若没有下一个锚点，
             或下一个锚点在文档中不存在 / 出现在当前锚点之前，
             则延伸到文档末尾。
    文档中不存在的锚点，对应片段为 ""。
    remove_overlap:
        如果为 True，则子节点从锚点本身开始切分，文档开头到第一个锚点的部分
        会被单独存为 "_prefix_"，供父节点（不带锚点的节点）提取，避免重复。
    """
    if not html or not html.strip() or not anchor_points:
        return {}

    soup = BeautifulSoup(html, "html.parser")
    root = soup.body if soup.body else soup
    if root is None:
        return {}

    events = _collect_events(root)
    if not events:
        return {}

    # 锚点 -> 文档中第一次出现的 open 事件索引
    pos = {}
    for i, (kind, payload) in enumerate(events):
        if kind == "open":
            nid = payload.get("id")
            if nid and nid not in pos:
                pos[nid] = i

    # 目录顺序与文档顺序一致性校验（仅旧版模式提示，因为新版模式会自动按文档顺序重新排序）
    if not remove_overlap:
        ordered_pos = [pos[aid] for aid in anchor_points if aid in pos]
        if ordered_pos != sorted(ordered_pos):
            print(f"警告：目录锚点顺序与文档顺序不一致：{anchor_points}")

    # 提取有效锚点并按文档实际物理顺序排序（去重模式下）
    if remove_overlap:
        processing_anchors = sorted(
            [a for a in anchor_points if a in pos], key=lambda x: pos[x]
        )
    else:
        processing_anchors = anchor_points

    n = len(processing_anchors)
    ranges = []
    prefix_html = ""

    # 提取文档开头到第一个锚点的内容，作为父节点的专属内容
    if remove_overlap and processing_anchors:
        first_pos = pos[processing_anchors[0]]
        if first_pos > 0:
            prefix_html = _build_segment(events, 0, first_pos, [])

    for idx, aid in enumerate(processing_anchors):
        if aid not in pos:
            ranges.append((aid, None, None))
            continue

        # 核心修改：如果去重，子节点永远从自身位置开始；否则保持原逻辑（第一个从 0 开始）
        start = pos[aid] if remove_overlap else (0 if idx == 0 else pos[aid])

        if idx + 1 < n:
            next_aid = processing_anchors[idx + 1]
            next_pos = pos.get(next_aid)
            if next_pos is None or next_pos <= start:
                end = len(events)
            else:
                end = next_pos
        else:
            end = len(events)

        ranges.append((aid, start, end))

    # 只记录切分点处的活跃祖先栈
    needed = {s for _, s, _ in ranges if s is not None}
    active_stack_at = {}
    stack = []
    for i, (kind, payload) in enumerate(events):
        if i in needed:
            active_stack_at[i] = list(stack)
        if kind == "open":
            stack.append(payload)
        elif kind == "close" and stack:
            stack.pop()

    result = {}
    if remove_overlap and prefix_html:
        result["_prefix_"] = prefix_html

    for aid, s, e in ranges:
        if s is None or s >= e:
            result[aid] = ""
            continue
        result[aid] = _build_segment(events, s, e, active_stack_at.get(s, []))
    return result


def get_content(
    book: epub.EpubBook,
    href: str,
    anchor_points: dict[str, list[str]] | None = None,
    remove_overlap: bool = True,
):
    if "#" in href and anchor_points:
        doc_href, _, anchor_point = href.partition("#")
        anchor_list = anchor_points.get(doc_href)
        if not anchor_list:
            return ""

        cache_key = (doc_href, remove_overlap)
        if cache_key not in _split_cache:
            doc = book.get_item_with_href(doc_href)
            if doc is None:
                return ""
            html = doc.content.decode("utf-8")
            _split_cache[cache_key] = split_html_by_toc(
                html, anchor_list, remove_overlap
            )

        return escape_sequence(_split_cache[cache_key].get(anchor_point, ""))

    doc_href = href.partition("#")[0]
    doc = book.get_item_with_href(doc_href)

    # 核心修改：如果没有锚点，但该文档有子节点进行了切分，父节点只返回前缀部分
    if remove_overlap and anchor_points and doc_href in anchor_points:
        anchor_list = anchor_points[doc_href]
        cache_key = (doc_href, remove_overlap)
        if cache_key not in _split_cache:
            if doc is None:
                return ""
            html = doc.content.decode("utf-8")
            _split_cache[cache_key] = split_html_by_toc(html, anchor_list, remove_overlap)
        
        split_result = _split_cache[cache_key]
        # 兜底：如果切分结果为空（说明目录里的锚点在 HTML 中完全找不到），则父节点返回全文，防止内容丢失
        if not split_result:
            return escape_sequence(doc.content.decode("utf-8") if doc else " ")
            
        return escape_sequence(split_result.get("_prefix_", ""))

    content = doc.content.decode("utf-8") if doc else " "
    return escape_sequence(content)


def get_anchor_point_list(chapters):
    def recursion(chapters):
        anchor_points = []
        for chapter in chapters:
            if isinstance(chapter, epub.Link):
                doc_href, _, anchor_point = chapter.href.partition("#")
                anchor_points.append((doc_href, anchor_point))
            elif isinstance(chapter, tuple):
                section, elements = chapter
                doc_href, _, anchor_point = section.href.partition("#")
                anchor_points.append((doc_href, anchor_point))
                if elements:
                    anchor_points.extend(recursion(elements))
        return [(x, y) for x, y in anchor_points if str(y).strip() != ""]

    anchor_point_dict: dict[str, list[str]] = {}
    for href, anchor_point in recursion(chapters):
        anchor_list = anchor_point_dict.setdefault(href, [])
        if anchor_point not in anchor_list:
            anchor_list.append(anchor_point)

    return anchor_point_dict


def get_docs_by_toc(book, chapters, folder_name, remove_overlap=True):
    anchor_points = get_anchor_point_list(chapters)
    return _get_docs_by_toc(book, chapters, folder_name, anchor_points, remove_overlap)


def _get_docs_by_toc(book, chapters, folder_name, anchor_points, remove_overlap=True):
    global id_counts
    el_list = []
    for chapter in chapters:
        if isinstance(chapter, epub.Link):
            title = chapter.title
            href = chapter.href
            children = None
        elif isinstance(chapter, tuple):
            sm_section, sm_element = chapter
            title = sm_section.title
            href = sm_section.href
            children = sm_element
        else:
            continue

        doc, tag, text = Doc().tagtext()
        with tag("ID"):
            text(get_id())
        with tag("Type"):
            text("Topic")
        with tag("Title"):
            text(title)
        with tag("Content"), tag("Question"):
            text(
                modify_img_url(
                    book,
                    get_content(book, href, anchor_points, remove_overlap),
                    folder_name,
                )
            )
        id_counts += 1

        if children:
            for el in _get_docs_by_toc(
                book, children, folder_name, anchor_points, remove_overlap
            ):
                with tag("SuperMemoElement"):
                    doc.asis(el)

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
        if not html_body:
            continue
        for child in html_body.children:
            epub_topic += str(child)
    return modify_img_url(book, epub_topic, folder_name)


def write_img_file(ebook: epub.EpubBook, book_img_folder: str) -> None:
    """写出img文件到SuperMemo-XML-Book文件旁边的文件夹中。"""
    for image in ebook.get_items_of_type(ebooklib.ITEM_IMAGE):
        # 可以得到image.file_name 和 image.content 二进制数据、image.media_type
        # os.path.abspath(".")
        if not os.path.exists(book_img_folder):
            mkdir(book_img_folder)
        if "/" in image.file_name:
            filename = image.file_name.split("/")[-1]
            file = os.path.join(book_img_folder, filename)
        else:
            file = os.path.join(book_img_folder, image.file_name)
        with open(long_path(file), "wb") as f:
            f.write(image.content)


def split_html_with_lenght(html, limit_num):
    soup = BeautifulSoup(html, "html.parser")

    def recursion(node, words=0):
        if isinstance(node, NavigableString):
            # 说明是叶子
            # 叶子就开始计数，当达到数量后，找到父节点然后再父节点下一个位置插入hr水平标签。
            words += len(str(node))
            if words > limit_num and node.parent:
                node_index = node.parent.index(node)
                node.parent.insert(node_index + 1, soup.new_tag("hr", id="smtk-number"))
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
    return _soup_to_ascii(soup).replace("\n", "").replace("\r", "")


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


def _finalize(book, book_f_name, save_folder, save_image_folder, xml_str):
    file = long_path(os.path.join(os.path.abspath(save_folder), book_f_name + ".xml"))
    folder = os.path.join(os.path.abspath(save_folder), book_f_name)
    with open(file, "w", encoding="utf-8") as f:
        f.write(xml_str)
    write_img_file(book, folder)
    if save_image_folder:
        move_folder(folder, save_image_folder)
    print("转换完成，已存储至：", os.path.abspath(save_folder))


def start_with_toc(epub_file, save_folder, save_image_folder=None, remove_overlap=True):
    _reset_state()
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    if not filename_length_check_pass(book_f_name):
        return
    print("开始处理书籍：", book_f_name)
    # 创建数据结构
    toc = toc_orgnize.合并目录(book)
    diff_list = toc_check.contrast_diff_toc(toc, book)
    # 验证内容完整性
    if len(diff_list) != 0:
        print("内容完整性: False\n", diff_list)
        return

    doc, tag, text = Doc().tagtext()
    mid = get_id()
    el_list = get_docs_by_toc(book, toc, book_f_name, remove_overlap)
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

    _finalize(book, book_f_name, save_folder, save_image_folder, doc.getvalue())


def start_with_seq(epub_file, save_folder, save_image_folder=None):
    _reset_state()
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

    _finalize(book, book_f_name, save_folder, save_image_folder, doc.getvalue())


def start_with_topic(epub_file, save_folder, limit_num, save_image_folder=None):
    _reset_state()
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    if not filename_length_check_pass(book_f_name):
        return
    print("开始处理书籍：", book_f_name)

    doc, tag, text, line = Doc().ttl()
    if limit_num:
        html = merge_epub_to_topic(book, book_f_name).replace("\n", "")
        topic_doc = split_html_with_lenght(html, limit_num)
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

    _finalize(book, book_f_name, save_folder, save_image_folder, doc.getvalue())


if __name__ == "__main__":
    start_with_toc(
        r"D:\Calibre Library\Calibre 星轨\Yi Ming\Shi Jing (Quan Xi Quan Yi Ban ) (283)\Shi Jing (Quan Xi Quan Yi Ban ) - Yi Ming.epub",
        r"C:\Users\Snowy\Desktop",
        remove_overlap=True,  # 设为 True 时去重（仅保留叶子），设为 False 时保留旧版全量包含
    )

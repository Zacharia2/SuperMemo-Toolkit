import os

import ebooklib
from bs4 import BeautifulSoup, Doctype, Tag, NavigableString
from ebooklib import epub

from supermemo_toolkit.epub2sm import toc_check
from supermemo_toolkit.epub2sm import toc_orgnize
from supermemo_toolkit.utilscripts.ulils import (
    makeNameSafe,
    trans_pinyin,
    mkdir,
    get_id_func,
    escape_sequence,
)

from yattag import Doc


get_id = get_id_func()
id_counts = 0


def modify_img_url(doc, folder_name):
    soup = BeautifulSoup(doc, "html.parser")
    # 删除DOCTYPE定义
    for item in soup.contents:
        if isinstance(item, Doctype):
            item.extract()
            break
    # 处理图片
    imgs = soup.find_all("img")
    for img in imgs:
        # 新的图片将会放在一个全英文下面的文件中，文件夹名字以书名命名。
        img_name = os.path.basename(img.attrs["src"])
        img.attrs["src"] = f"file:///[PrimaryStorage]local_pic/{folder_name}/{img_name}"
    doc = str(soup.encode(encoding="ascii"), "utf-8")
    return doc.replace("\n", "").replace("\r", "")


def split_section(html, doc_id):
    soup = BeautifulSoup(html, "html.parser")
    m_element = soup.find(id=doc_id)
    tag_name = m_element.name
    # 获取带有id属性的元素，提取这一节内容，把它自己（分割标记）也放进去。
    content = str(m_element)
    if m_element is not None:
        for sibling in m_element.find_next_siblings():
            if isinstance(sibling, Tag):
                # sibling是Tag对象，检查Tag对象的name属性
                if sibling.name == tag_name:
                    break
                else:
                    content += str(sibling)
            else:
                # sibling是字符串，添加到content中
                content += str(sibling)
    return content


def get_content(book: epub.EpubBook, href: str):
    if href.find("#") != -1:
        doc_id = href.split("#")[-1]
        doc_href = href.split("#")[0]
        doc = book.get_item_with_href(doc_href)
        # 分割文本
        section = split_section(doc.content.decode("utf-8"), doc_id) if doc else " "
        return escape_sequence(section)
    else:
        # 没有锚点，是一个文件。
        doc = book.get_item_with_href(href)
        content = doc.content.decode("utf-8") if doc else " "
    return escape_sequence(content)


def get_docs_by_toc(book, chapters, folder_name):
    global id_counts
    el_list = []
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
            with tag("Content"):
                with tag("Question"):
                    text(modify_img_url(get_content(book, href), folder_name))
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
            with tag("Content"):
                with tag("Question"):
                    text(modify_img_url(get_content(book, href), folder_name))
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
        content = modify_img_url(get_content(book, href), folder_name)
        doc, tag, text = Doc().tagtext()
        with tag("ID"):
            text(get_id())
        with tag("Type"):
            text("Topic")
        with tag("Content"):
            with tag("Question"):
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
        html_body = soup.find("body")
        for child in html_body.children:
            epub_topic += str(child)
    doc = modify_img_url(epub_topic, folder_name)
    return doc


def write_img_file(ebook: epub.EpubBook, book_img_folder: str) -> None:
    """写出img文件到SuperMemo-XML-Book文件旁边的文件夹中。"""
    for image in ebook.get_items_of_type(ebooklib.ITEM_IMAGE):
        # 可以得到image.file_name 和 image.content二进制数据、image.media_type
        # os.path.abspath(".")
        if not os.path.exists(book_img_folder):
            mkdir(book_img_folder)
        if image.file_name.find("/") != -1:
            filename = image.file_name.split("/")[-1]
            file = os.path.join(book_img_folder, filename)
        else:
            file = os.path.join(book_img_folder, image.file_name)
        with open(file, "wb") as f:
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


def start_with_toc(epub_file, save_folder):
    # UserWarning: In the future version we will turn default option ignore_ncx to True.
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
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
    file = os.path.join(save_folder, book_f_name + ".xml")
    folder = os.path.join(save_folder, book_f_name)
    with open(file, "w", encoding="utf-8") as f:
        f.write(doc.getvalue())
    write_img_file(book, folder)

    print("转换完成，已存储至：", save_folder)


def start_with_linear(epub_file, save_folder):
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    print("开始处理书籍：", book_f_name)

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
    file = os.path.join(save_folder, book_f_name + ".xml")
    folder = os.path.join(save_folder, book_f_name)
    with open(file, "w", encoding="utf-8") as f:
        f.write(doc.getvalue())
    write_img_file(book, folder)

    print("转换完成，已存储至：", save_folder)


def start_with_topic(epub_file, save_folder, limit_num):
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
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
            with tag("Content"):
                with tag("Question"):
                    text(topic_doc)
    file = os.path.join(save_folder, book_f_name + ".xml")
    folder = os.path.join(save_folder, book_f_name)
    with open(file, "w", encoding="utf-8") as f:
        f.write(doc.getvalue())
    write_img_file(book, folder)

    print("转换完成，已存储至：", save_folder)

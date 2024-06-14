import os

import ebooklib
from bs4 import BeautifulSoup, Doctype
from ebooklib import epub

from supermemo_toolkit.epub2sm.smxml import SmXml
from supermemo_toolkit.epub2sm.toc_units import toc_check, toc_orgnize
from supermemo_toolkit.utilscripts.ulils import makeNameSafe, trans_pinyin


# sys.path.insert(0, os.path.normpath(sys.path[0] + "/../../"))


# resolved：空格变问号的问题
# https://blog.csdn.net/u013778905/article/details/53177042
# 符号库：https://www.fuhaoku.net/U+00A9
# 写入数据结构时，必要调用的函数之一。
def modify_img_url(doc, folder_name):
    escape_sequence = {
        "EM SPACE": (chr(0x2003), "&ensp;"),
        "COPYRIGHT SIGN": (chr(0x00A9), "&copy;"),
        "EM DASH": (chr(0x2014), "&#8212;"),
        "chapterlast": (chr(0xF108), "&#10048;"),
        "REPLACEMENT CHARACTER": (chr(0xFFFD), "&#65533;"),
    }
    for escape in escape_sequence.values():
        doc = doc.replace(escape[0], escape[1])
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
    return str(soup.encode(encoding="ascii"), "utf-8")


def split_section(html, doc_id):
    soup = BeautifulSoup(html, "html.parser")
    m_element = soup.find(id=doc_id)
    tag_name = m_element.name
    # 获取带有id属性的元素
    # 提取这一节内容
    # 把它自己（分割标记）也放进去。
    content = str(m_element)
    if m_element is not None:
        for sibling in m_element.find_next_siblings():
            if sibling.name == tag_name:
                break
            else:
                content += str(sibling)
    return content


def get_content(book, href):
    if href.find("#") != -1:
        doc_id = href.split("#")[-1]
        doc_href = href.split("#")[0]
        doc = book.get_item_with_href(doc_href)
        # 分割文本
        section = split_section(doc.content.decode("utf-8"), doc_id) if doc else " "
        return section
    else:
        # 没有锚点。说明是一个文件。
        doc = book.get_item_with_href(href)
        content = doc.content.decode("utf-8") if doc else " "
    return content


# {"Question": modify_img_url(section, foldername)}
# {"Question": ""}
def get_documents_by_toc(book, chapters, folder_name):
    global m_element
    m_list = []
    for chapter in chapters:
        # 把这一层处理好，再去处理下一层。
        # 这一层和下一层的逻辑一致。
        if isinstance(chapter, epub.Link):
            title = chapter.title
            href = chapter.href
            content = {"Question": modify_img_url(get_content(book, href), folder_name)}
            m_element = {"Title": title, "Type": "Topic", "Content": content}
            m_list.append(m_element)
        # 是元组的时候就说明是有子集的数据。这个元组代表当前的数据。元组的内容代表下一层数据。
        # 在元组中，其中第一个元素是本层的数据，第二个元素是下一层的数据，也是入口。
        # 这个的子元素的入口、以及超子集元素之间的关联位点。
        if isinstance(chapter, tuple):
            if isinstance(chapter[0], epub.Section):
                title = chapter[0].title
                href = chapter[0].href
                content = {
                    "Question": modify_img_url(get_content(book, href), folder_name)
                }
                m_element = {
                    "Title": title,
                    "Type": "Topic",
                    "Content": content,
                    # "SuperMemoElement": SuperMemoElement,
                }
                m_list.append(m_element)
            # 当元组的第二个元素有子元素的时候。
            if isinstance(chapter[1], list):
                sub_element_list = get_documents_by_toc(book, chapter[1], folder_name)
                m_element["SuperMemoElement"] = sub_element_list
    return m_list


def get_documents_by_doc_list(book, folder_name):
    m_list = []
    doc_list = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    for doc in doc_list:
        href = doc.file_name
        content = {"Question": modify_img_url(get_content(book, href), folder_name)}
        sub_element = {"Type": "Topic", "Content": content}
        m_list.append(sub_element)
    return m_list


# 只取body内的元素合并。忽略其他，因为sm不需要。
def merge_epub_to_topic(book, folder_name):
    doc_list = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    epub_topic = ""
    for doc in doc_list:
        href = doc.file_name
        doc = book.get_item_with_href(href)
        content = doc.content.decode("utf-8") if doc else ""
        soup = BeautifulSoup(content, "html.parser")
        html_body = soup.find("body")
        for child in html_body.children:
            epub_topic += str(child)
    # 将一本书合并为一个html。
    return modify_img_url(epub_topic, folder_name)


def start_with_toc(epub_file, folder_name):
    # UserWarning: In the future version we will turn default option ignore_ncx to True.
    #   warnings.warn('In the future version we will turn default option ignore_ncx to True.')
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    print("开始处理书籍：", book_f_name)
    # 创建数据结构
    toc = toc_orgnize.merge_doc(book)
    diff_list = toc_check.contrast_diff_toc(toc, book)
    if len(diff_list) == 0:
        print("内容完整性: True")
        # 这个是Collection下的第一个SuperMemoElement
        root_element = [
            {
                "Title": book.title,
                "Type": "Concept",
                "SuperMemoElement": get_documents_by_toc(book, toc, book_f_name),
            }
        ]

        # 根据数据结构创建XML文件
        sm_book = SmXml(book, book_f_name, folder_name)
        sm_book.create_xml(root_element)
    else:
        print("内容完整性: False;/n", diff_list)
    print("转换完成，已存储至：", folder_name)


def start_with_linear(epub_file, save_folder):
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    print("开始处理书籍：", book_f_name)

    root_element = [
        {
            "Title": book.title,
            "Type": "Concept",
            "SuperMemoElement": get_documents_by_doc_list(book, book_f_name),
        }
    ]

    # 根据数据结构创建XML文件
    sm_book = SmXml(book, book_f_name, save_folder)
    sm_book.create_xml(root_element)
    print("转换完成，已存储至：", save_folder)


def start_with_topic(epub_file, save_folder):
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    print("开始处理书籍：", book_f_name)
    root_element = [
        {
            "Title": book.title,
            "Type": "Topic",
            "Content": {"Question": merge_epub_to_topic(book, book_f_name)},
        }
    ]
    sm_book = SmXml(book, book_f_name, save_folder)
    sm_book.create_xml(root_element)
    print("转换完成，已存储至：", save_folder)

import os

import ebooklib
from bs4 import BeautifulSoup, Doctype
from supermemo_toolkit.epub2sm.epub_convert import get_content
from ebooklib import epub


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
        img_name = os.path.basename(img.attrs["src"])
        # anki图片格式：<img src="微信图片_20240721115214.jpg">
        # 图片需要使用api发送到anki。
        img.attrs["src"] = f"{img_name}"
    doc = str(soup.encode(encoding="ascii"), "utf-8")
    return doc.replace("\n", "").replace("\r", "")


def get_docs_by_doclist(book, folder_name):
    el_list = []
    doc_list = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    for doc in doc_list:
        href = doc.file_name
        content = modify_img_url(get_content(book, href), folder_name)
        content
        # 将书内容放到一个Front字段中即可，{{Front}}, {{FrontSide}}
        # TODO)) content
        el_list.append(doc.getvalue())
    return el_list


def start_with_linear(epub_file, save_folder):
    book = epub.read_epub(epub_file, {"ignore_ncx": True})
    print("开始处理书籍：", book.title)
    el_list = get_docs_by_doclist(book, book.title)
    for element in el_list:
        # 发送html文章到anki
        element

    # 发送图片到anki
    for image in book.get_items_of_type(ebooklib.ITEM_IMAGE):
        # 可以得到image.file_name 和 image.content二进制数据、image.media_type
        # 使用ankiconnect api发送
        pass

    print("已全部发送到anki")

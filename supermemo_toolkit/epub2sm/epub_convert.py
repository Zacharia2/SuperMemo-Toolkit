import os
import sys
import ebooklib
from ebooklib import epub
from bs4 import BeautifulSoup, Doctype

sys.path.insert(0, os.path.normpath(sys.path[0] + "/../../"))
from supermemo_toolkit.epub2sm.toc_units import toc_check, toc_orgnize
from supermemo_toolkit.epub2sm.sm_xml import SM_XML
from supermemo_toolkit.utilscripts.ulils import makeNameSafe, trans_pinyin


# resolved：空格变问号的问题
# https://blog.csdn.net/u013778905/article/details/53177042
# 符号库：https://www.fuhaoku.net/U+00A9
# 写入数据结构时，必要调用的函数之一。
def modify_img_url(doc, foldername):
    escapeSequence = {
        "EM SPACE": (chr(0x2003), "&ensp;"),
        "COPYRIGHT SIGN": (chr(0x00A9), "&copy;"),
        "EM DASH": (chr(0x2014), "&#8212;"),
        "chapterlast": (chr(0xF108), "&#10048;"),
        "REPLACEMENT CHARACTER": (chr(0xFFFD), "&#65533;"),
    }
    for escape in escapeSequence.values():
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
        img.attrs["src"] = f"file:///[PrimaryStorage]local_pic/{foldername}/{img_name}"
    return str(soup.encode(encoding="ascii"), "utf-8")


def split_section(html, doc_id):
    soup = BeautifulSoup(html, "html.parser")
    element = soup.find(id=doc_id)
    tag_name = element.name
    # 获取带有id属性的元素
    # 提取这一节内容
    # 把它自己（分割标记）也放进去。
    content = str(element)
    if element is not None:
        for sibling in element.find_next_siblings():
            if sibling.name == tag_name:
                break
            else:
                content += str(sibling)
    return content


def getContent(book, href):
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
        Content = doc.content.decode("utf-8") if doc else " "
    return Content


# {"Question": modify_img_url(section, foldername)}
# {"Question": ""}
def get_documents_by_toc(book, chapters, foldername):
    mList = []
    for chapter in chapters:
        # 把这一层处理好，再去处理下一层。
        # 这一层和下一层的逻辑一致。
        if isinstance(chapter, epub.Link):
            title = chapter.title
            href = chapter.href
            Content = {"Question": modify_img_url(getContent(book, href), foldername)}
            element = {"Title": title, "Type": "Topic", "Content": Content}
            mList.append(element)
        # 是元组的时候就说明是有子集的数据。这个元组代表当前的数据。元组的内容代表下一层数据。
        # 在元组中，其中第一个元素是本层的数据，第二个元素是下一层的数据，也是入口。
        # 这个的子元素的入口、以及超子集元素之间的关联位点。
        if isinstance(chapter, tuple):
            if isinstance(chapter[0], epub.Section):
                title = chapter[0].title
                href = chapter[0].href
                Content = {
                    "Question": modify_img_url(getContent(book, href), foldername)
                }
                element = {
                    "Title": title,
                    "Type": "Topic",
                    "Content": Content,
                    # "SuperMemoElement": SuperMemoElement,
                }
                mList.append(element)
            # 当元组的第二个元素有子元素的时候。
            if isinstance(chapter[1], list):
                SubElementList = get_documents_by_toc(book, chapter[1], foldername)
                element["SuperMemoElement"] = SubElementList
    return mList


def get_documents_by_docList(book, foldername):
    mList = []
    docList = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    for doc in docList:
        href = doc.file_name
        Content = {"Question": modify_img_url(getContent(book, href), foldername)}
        element = {"Type": "Topic", "Content": Content}
        mList.append(element)
    return mList


def start_with_toc(epubfile, savefolder):
    # UserWarning: In the future version we will turn default option ignore_ncx to True.
    #   warnings.warn('In the future version we will turn default option ignore_ncx to True.')
    book = epub.read_epub(epubfile, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    print("开始处理书籍：", book_f_name)
    # 创建数据结构
    toc = toc_orgnize.merge_doc(book)
    diff_list = toc_check.contrast_diff_toc(toc, book)
    if len(diff_list) == 0:
        print("内容完整性: True")
        # 这个是Collection下的第一个SuperMemoElement
        rootElement = [
            {
                "Title": book.title,
                "Type": "Concept",
                "SuperMemoElement": get_documents_by_toc(book, toc, book_f_name),
            }
        ]

        # 根据数据结构创建XML文件
        smbook = SM_XML(book, book_f_name, savefolder)
        smbook.create_xml(rootElement)
    else:
        print("内容完整性: False;/n", diff_list)
    print("转换完成，已存储至：", savefolder)


def start_with_linear(epubfile, savefolder):
    book = epub.read_epub(epubfile, {"ignore_ncx": True})
    book_f_name = makeNameSafe(trans_pinyin(book.title))
    print("开始处理书籍：", book_f_name)

    rootElement = [
        {
            "Title": book.title,
            "Type": "Concept",
            "SuperMemoElement": get_documents_by_docList(book, book_f_name),
        }
    ]

    # 根据数据结构创建XML文件
    smbook = SM_XML(book, book_f_name, savefolder)
    smbook.create_xml(rootElement)
    print("转换完成，已存储至：", savefolder)

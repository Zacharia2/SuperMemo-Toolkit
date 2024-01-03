import copy
import re
import ebooklib
from ebooklib import epub
from bs4 import BeautifulSoup


def get_doc_of_toc(book):
    chapters = book.toc
    mList = []

    def iter_toc(chapters):
        nonlocal mList
        for chapter in chapters:
            if isinstance(chapter, epub.Link):
                # title = chapter.title
                href = chapter.href
                file_name = href.split("#")[0]
                mList.append(file_name)
            if isinstance(chapter, tuple):
                if isinstance(chapter[0], epub.Section):
                    # title = chapter[0].title
                    href = chapter[0].href
                    file_name = href.split("#")[0]
                    mList.append(file_name)
                # 当元组的第二个元素有子元素的时候。
                if isinstance(chapter[1], list):
                    iter_toc(chapter[1])

    iter_toc(chapters)
    return mList


def isToc(book, doc):
    # 判断doc是否在toc列表中。
    doc_of_toc_list = get_doc_of_toc(book)
    if doc.file_name in doc_of_toc_list:
        return True
    else:
        return False


def organize_linear_documents(book):
    FirstTocChecked = False
    M_list = [[], []]  # 第一个元素的start，第二个是body
    Head, Body = M_list

    # 大前提是，docList是线性的。
    for doc in book.get_items_of_type(ebooklib.ITEM_DOCUMENT):
        # 开头部分。没有toc引用，需要自己创建的。
        if not isToc(book, doc) and FirstTocChecked is False:
            Head.append([doc.file_name, []])
        # toc中有的。
        elif isToc(book, doc):
            FirstTocChecked = True
            Body.append([doc.file_name, []])
        # toc中没有，但需要追加的doc。
        elif not isToc(book, doc) and FirstTocChecked is True:
            L_list = Body.pop()  # M取出最后一个元素给L
            toc_doc_name, sub_doc_names = L_list
            # [[head], [body]]
            # [body] = ["toc_doc_name", [sub_doc_names]]: ['Text/Section0001_0012.xhtml', ['Text/Section0001_0013.xhtml']]
            # 已解决：L_list[1]，sub_doc_names 是一个 列表。会有多个doc位于toc之后，但没有没toc引用。
            # sub_doc_names 追加到 toc_doc_name 的子集中。
            sub_doc_names.append(doc.file_name)
            Body.append(L_list)  # M在加回去L
    return M_list


def insert_doc(book, chapters, f_href, sub_doc_list):
    stack = [chapters]
    f_href = f_href.split("#")[0]

    while stack:
        chapters = stack.pop()
        for chapter in chapters:
            if isinstance(chapter, epub.Link):
                # title = chapter.title
                href = chapter.href
                file_name = href.split("#")[0]
                if f_href == file_name:
                    elink = []
                    for item in sub_doc_list:
                        item_content = book.get_item_with_href(item).content
                        soup = BeautifulSoup(item_content, "html.parser")
                        item_title = re.sub(
                            r"\\[btnfr]", "", "".join(filter(str.isalnum, soup.text))
                        )[:50]
                        elink.append(epub.Link(href=item, title=item_title))
                    rdata = copy.deepcopy(chapter[1])
                    elink.extend(rdata)
                    chapter[1].clear()
                    chapter[1].extend(elink)
            if isinstance(chapter, tuple):
                if isinstance(chapter[0], epub.Section):
                    # title = chapter[0].title
                    href = chapter[0].href
                    file_name = href.split("#")[0]
                    if f_href == file_name:
                        elink = []
                        for item in sub_doc_list:
                            item_content = book.get_item_with_href(item).content
                            soup = BeautifulSoup(item_content, "html.parser")
                            item_title = re.sub(
                                r"\\[btnfr]",
                                "",
                                "".join(filter(str.isalnum, soup.text)),
                            )[:50]
                            elink.append(epub.Link(href=item, title=item_title))
                        rdata = copy.deepcopy(chapter[1])
                        elink.extend(rdata)
                        chapter[1].clear()
                        chapter[1].extend(elink)
                # 当元组的第二个元素有子元素的时候。
                if isinstance(chapter[1], list):
                    stack.append(chapter[1])


def find_all_anchor_point_of_toc(chapters):
    # 只有锚点会多次复用一个文档文件。
    # 两种可能：
    # 第一种，一个文档一个锚点，一一对应。这种保留不用管。
    # 第二种，一个文档，多个锚点，文档是唯一的，锚点都是文档的孩子。这种删掉所有锚点，只保留文档即可。
    # 或者删掉锚点文档的所有子锚点

    # 1. 找到所有锚点。
    # 2. 找到锚点的文档名字，对应的href数量，如果为1个，不用管。如果大于一个，就删掉所有锚点。

    # src="Text/Section0122.xhtml"
    # src="Text/Section0122.xhtml#sigil_toc_id_1"
    stack = [chapters]
    anchor_point = set()
    while stack:
        chapters = stack.pop()
        for chapter in chapters:
            if isinstance(chapter, epub.Link):
                # file_name = chapter.href.split("#")[0]
                if "#" in chapter.href:
                    anchor_point.add(chapter.href.split("#")[0])
            if isinstance(chapter, tuple):
                if isinstance(chapter[0], epub.Section):
                    # file_name = chapter[0].href.split("#")[0]
                    if "#" in chapter[0].href:
                        anchor_point.add(chapter[0].href.split("#")[0])
                if isinstance(chapter[1], list):
                    stack.append(chapter[1])
    return anchor_point


def count_anchors_in_toc(count_anchor_point, chapters):
    stack = [chapters]
    duplicate_anchor_count = 0
    while stack:
        chapters = stack.pop()
        for chapter in chapters:
            if isinstance(chapter, epub.Link):
                if count_anchor_point in chapter.href:
                    duplicate_anchor_count += 1
            if isinstance(chapter, tuple):
                if isinstance(chapter[0], epub.Section):
                    if count_anchor_point in chapter[0].href:
                        duplicate_anchor_count += 1
                if isinstance(chapter[1], list):
                    stack.append(chapter[1])
    return duplicate_anchor_count


def remove_anchors_in_toc(anchor_sharp, chapters):
    stack = [chapters]
    while stack:
        chapters = stack.pop()
        for chapter in chapters:
            if isinstance(chapter, tuple):
                # 保留chapter[0]里面的，删除sub_chapter[1]里面的。
                # 用不到isinstance(chapter, epub.Link)
                if isinstance(chapter[0], epub.Section):
                    if anchor_sharp in chapter[0].href:
                        for sub_chapter in chapter[1]:
                            # 删除epub.Link
                            if anchor_sharp in sub_chapter.href:
                                index_chapter = chapter[1].index(sub_chapter)
                                del chapter[1][index_chapter]
                if isinstance(chapter[1], list):
                    stack.append(chapter[1])


def merge_doc(book):
    # 去重
    M_list = organize_linear_documents(book)
    Head, Body = M_list
    # 合并没有列入toc的doc。
    # 要加入的其实只有head和sub_doc_names不为空的元素。把他们筛选出来。
    chapters = book.toc
    H_list = []
    if len(Head) != 0:
        for item in Head:
            href = item[0]
            content = book.get_item_with_href(href).content
            soup = BeautifulSoup(content, "html.parser")
            title = re.sub(r"\\[btnfr]", "", "".join(filter(str.isalnum, soup.text)))[
                :50
            ]
            H_list.append(epub.Link(href=href, title=title))
    chapters = H_list + chapters

    B_list = []  # list ['Text/Section0001_0069.xhtml', ['Text/Section0001_0070.xhtml']]
    if len(Body) != 0:
        for item in Body:
            toc_doc_name, sub_doc_list = item
            if len(sub_doc_list) != 0:
                B_list.append(item)

    # TODO:chapters, 查找符合的href，加入到此toc的子集中。
    for item in B_list:
        href, sub_doc_list = item
        # 可变对象：list dict set
        # 可变对象作为参数传入时，在函数中对其本身进行修改，
        # 是会影响到全局中的这个变量值的，因为函数直接对该地址的值进行了修改
        insert_doc(book, chapters, href, sub_doc_list)
    anchor_points = find_all_anchor_point_of_toc(chapters)

    # 查找doc文件（anchor_point href去掉锚点）所有的锚点href数量
    # doc文档也可以自己就是锚点。
    duplicate_anchor = {}
    for anchor_point in anchor_points:
        duplicate_anchor[anchor_point] = count_anchors_in_toc(anchor_point, chapters)
    for key, vaule in duplicate_anchor.items():
        if vaule > 1:
            # 锚点href数量大于1，则查找删除所有锚点，只保留文档。
            remove_anchors_in_toc(key + "#", chapters)
    return chapters


# book = epub.read_epub("C:/Users/Snowy/Desktop/心理学与生活.epub", {"ignore_ncx": True})
# book = epub.read_epub(
#     "C:/Users/Snowy/Desktop/魔鬼沟通学 - 阮琦.epub", {"ignore_ncx": True}
# )
# merge_doc(book)

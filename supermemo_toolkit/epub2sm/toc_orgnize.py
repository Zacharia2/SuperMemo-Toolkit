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


def inToc(book, doc):
    """判断doc是否在toc列表中。"""
    doc_of_toc_list = get_doc_of_toc(book)
    if doc.file_name in doc_of_toc_list:
        return True
    else:
        return False


def complete_toc_with_documents(book):
    """list[]:(toc中存在的文档, [toc中不存在的兄弟结点文档]) 取所有的文档 、toc指向的文档(toc不会指向后续文档), 将toc没有的文档补充到toc中。

    Returns:
        tuple: (Head[(exist_toc_of_doc,[sibling_doc,...])], Body[(exist_toc_of_doc,[sibling_doc,...])])
    """
    FirstTocChecked = False
    Head, Body = [], []

    # 现在有两个资源，一个是一列有序html文档，另一个是目录对象，目录指向部分html文档
    # 最终任务是补全完整的目录对象。这方法是看看遗漏了哪些兄弟结点。
    docs = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    for doc in docs:
        # 开头部分。没有toc引用，需要自己创建的。
        if not inToc(book, doc) and not FirstTocChecked:
            Head.append((doc.file_name, []))
        # toc中有的。
        elif inToc(book, doc):
            FirstTocChecked = True
            Body.append((doc.file_name, []))
        # toc中没有，但需要追加的doc。
        elif not inToc(book, doc) and FirstTocChecked:
            # 会有多个doc位于toc之后，但没有没toc引用。
            last = Body.pop()
            exist_toc_of_doc, sibling_doc_list = last
            sibling_doc_list.append(doc.file_name)
            Body.append(last)
    return (Head, Body)


def insert_doc_in_exist_toc_of_doc(
    book, chapters, exist_toc_of_doc_file_href, sibling_doc_list
):
    stack = [chapters]
    exist_toc_of_doc_file_href = exist_toc_of_doc_file_href.split("#")[0]

    while stack:
        curr_chapters: list = stack.pop()
        for chapter in curr_chapters:
            # 转换为tuple(epub.Section，list=epub.Link)
            if isinstance(chapter, epub.Link):
                # title = chapter.title
                file_name = chapter.href.split("#")[0]
                if exist_toc_of_doc_file_href == file_name:
                    # 改成元组，第一个元素存储epub.Section，第二个元素存储list ，epub.Link
                    index_chapter: int = curr_chapters.index(chapter)
                    # 为缺失的sibling_doc创建epub.Link
                    index = 1
                    for item in sibling_doc_list:
                        item_content = book.get_item_with_href(item).content
                        soup = BeautifulSoup(item_content, "html.parser")
                        item_title = re.sub(
                            r"\\[btnfr]",
                            "",
                            "".join(filter(str.isalnum, soup.text)),
                        )[:50]
                        curr_chapters.insert(
                            index_chapter + index,
                            epub.Link(href=item, title=item_title),
                        )
                        index += 1
                    # 将link_list插入到前一个之后。
                    # exist_toc_of_doc_file_href是有的，他的后面跟着缺失的html文档。
                    # 所以插入到exist_toc_of_doc_file_href之后。也就是index_chapter+1下标处插入

                    # 替换为新的
                    # section = epub.Section(chapter.title, chapter.href)
                    # curr_chapters[index_chapter] = tuple((section, link_list))
            if isinstance(chapter, tuple):
                if isinstance(chapter[0], epub.Section):
                    section, links = chapter
                    # title = chapter[0].title
                    file_name = section.href.split("#")[0]
                    if exist_toc_of_doc_file_href == file_name:
                        index = 0
                        for item in sibling_doc_list:
                            item_content = book.get_item_with_href(item).content
                            soup = BeautifulSoup(item_content, "html.parser")
                            item_title = re.sub(
                                r"\\[btnfr]",
                                "",
                                "".join(filter(str.isalnum, soup.text)),
                            )[:50]
                            links.insert(index, epub.Link(href=item, title=item_title))
                            index += 1
                        # TOOD 没有达到理想结果
                        # rdata = copy.deepcopy(links)
                        # elink.extend(rdata)
                        # links.clear()
                        # links.extend(elink)
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
        curr_chapters = stack.pop()
        for chapter in curr_chapters:
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
        curr_chapters = stack.pop()
        for chapter in curr_chapters:
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


# def remove_anchors_in_toc(anchor_sharp, chapters):
#     stack = [chapters]
#     while stack:
#         curr_chapters = stack.pop()
#         for chapter in curr_chapters:
#             if isinstance(chapter, tuple):
#                 # 保留chapter[0]里面的，删除sub_chapter[1]里面的。
#                 # 用不到isinstance(chapter, epub.Link)
#                 if (
#                     isinstance(chapter[0], epub.Section)
#                     and anchor_sharp in chapter[0].href
#                 ):
#                     for sub_chapter in chapter[1]:
#                         # 删除epub.Link
#                         if (
#                             isinstance(sub_chapter, epub.Link)
#                             and anchor_sharp in sub_chapter.href
#                         ):
#                             index_chapter = chapter[1].index(sub_chapter)
#                             del chapter[1][index_chapter]
#                         if isinstance(sub_chapter, tuple) or isinstance(
#                             sub_chapter, list
#                         ):
#                             stack.append(sub_chapter)
#                 if isinstance(chapter[1], list):
#                     stack.append(chapter[1])


def merge_doc(book):
    M_list = complete_toc_with_documents(book)
    Head, Body = M_list
    # 合并没有列入toc的doc。要插入到book.toc中不存在的文档。其实只有head和sub_doc_names不为空的元素。
    # 将开始的文档构建为epub.Link
    H_list = []
    if len(Head) != 0:
        for item in Head:
            content = book.get_item_with_href(item[0]).content
            soup = BeautifulSoup(content, "html.parser")
            title = re.sub(r"\\[btnfr]", "", "".join(filter(str.isalnum, soup.text)))[
                :50
            ]
            H_list.append(epub.Link(href=item[0], title=title))
    # chapters，用toc为基待补充完整的图书章节内容
    # 将开始的不在toc中的doc加入到章节。
    chapters = H_list + book.toc
    # chapters, 查找符合的href，加入到此toc的子集中。
    if len(Body) != 0:
        for item in Body:
            exist_toc_of_doc, sibling_doc_list = item
            # 将toc中不存在的doc，插入到前面的doc的后面
            if len(sibling_doc_list) != 0:
                insert_doc_in_exist_toc_of_doc(
                    book, chapters, exist_toc_of_doc, sibling_doc_list
                )

    # TODO: 删除重复文件，去重。
    # 查找doc文件（anchor_point href去掉锚点）所有的锚点href数量
    # doc文档也可以自己就是锚点。
    # anchor_points = find_all_anchor_point_of_toc(chapters)
    # duplicate_anchor = {}
    # for anchor_point in anchor_points:
    #     # 计算某个文件的锚点数量。
    #     duplicate_anchor[anchor_point] = count_anchors_in_toc(anchor_point, chapters)
    # for key, vaule in duplicate_anchor.items():
    #     if vaule > 1:
    #         # 若某文件的锚点href数量 > 1，则查找删除所有锚点，只保留文档。
    #         remove_anchors_in_toc(key + "#", chapters)

    return chapters


# 可变对象：list dict set
# 可变对象作为参数传入时，在函数中对其本身进行修改，
# 是会影响到全局中的这个变量值的，因为函数直接对该地址的值进行了修改

# debug
# book = epub.read_epub(
#     "C:/Users/Snowy/Desktop/Wu Zhong Shi Jian _Zhong Jian R - Wang Xiao.epub",
#     {"ignore_ncx": True},
# )
# merge_doc(book)

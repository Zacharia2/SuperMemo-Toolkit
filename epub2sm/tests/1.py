import ebooklib
from ebooklib import epub


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
    pass


def organize_linear_documents(book):
    M_list = [[], []]  # 第一个元素的start，第二个是body
    FirstTocChecked = False

    # 大前提是，docList是线性的。
    for doc in book.get_items_of_type(ebooklib.ITEM_DOCUMENT):
        # 判断是不是开头部分。
        if isToc(doc) and FirstTocChecked is False:
            # 这个是没有toc引用，需要自己创建的。
            M_list[0].append(doc.file_name, [])
        elif isToc(doc):
            FirstTocChecked = True
            L_list = [doc.file_name, []]
            M_list[1].append(L_list)
        elif not isToc(doc):
            L_list = M_list[1].pop()  # M取出最后一个元素给L
            L_list[1].append(doc.file_name)
            M_list[1].append(L_list)  # M在加回去L


# book = epub.read_epub(epubfile)

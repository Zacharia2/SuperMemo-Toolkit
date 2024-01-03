import ebooklib
from ebooklib import epub


def get_doc_of_toc(chapters):
    mList = []
    stack = [chapters]
    while stack:
        chapters = stack.pop()
        for chapter in chapters:
            if isinstance(chapter, epub.Link):
                # title = chapter.title
                file_name = chapter.href.split("#")[0]
                mList.append(file_name)
            if isinstance(chapter, tuple):
                if isinstance(chapter[0], epub.Section):
                    # title = chapter[0].title
                    file_name = chapter[0].href.split("#")[0]
                    mList.append(file_name)
                # 当元组的第二个元素有子元素的时候。
                if isinstance(chapter[1], list):
                    stack.append(chapter[1])
    return mList


def get_doc_items_href(book):
    docs_file_name_list = []
    docs = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)

    for doc in docs:
        # print(doc.file_name)
        docs_file_name_list.append(doc.file_name)
    return docs_file_name_list


def contrast_diff(epubfile):
    # 条件是他们的名字必须一样，只是这样的担心是多余的，因为不一样就没法引用。
    book = epub.read_epub(epubfile)

    toc_of_set = set(get_doc_of_toc(book.toc))
    doc_of_href_set = set(get_doc_items_href(book))

    # 返回一个集合，元素包含在集合 x ，但不在集合 y
    diff_list = list(doc_of_href_set.difference(toc_of_set))
    return diff_list


def contrast_diff_toc(toc, book):
    """对比toc中的文档是否都在doc_items中。toc取文件名与doc_items进行对比。

    Args:
        toc (_type_): _description_
        book (_type_): _description_

    Returns:
        _type_: 缺失的toc文档列表。
    """
    toc_of_set = set(get_doc_of_toc(toc))
    doc_of_href_set = set(get_doc_items_href(book))

    # 返回一个集合，元素包含在集合 doc_of_href_set ，但不在集合 toc_of_set
    # doc_of_href_set是全集。
    diff_list = list(doc_of_href_set.difference(toc_of_set))
    return diff_list


# contrast_diff("D:\\Dropbox\\00-TMP\\魔鬼沟通学 - 阮琦.epub")
# contrast_diff("C:/Users/Snowy/Desktop/心理学与生活.epub")

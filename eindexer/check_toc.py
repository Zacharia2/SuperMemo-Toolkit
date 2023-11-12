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

    toc_of_set = set(get_doc_of_toc(book))
    doc_of_href_set = set(get_doc_items_href(book))

    # 返回一个集合，元素包含在集合 x ，但不在集合 y
    diff_list = list(doc_of_href_set.difference(toc_of_set))
    return diff_list


# contrast_diff("D:\\Dropbox\\00-TMP\\魔鬼沟通学 - 阮琦.epub")
contrast_diff("C:/Users/Snowy/Desktop/心理学与生活.epub")
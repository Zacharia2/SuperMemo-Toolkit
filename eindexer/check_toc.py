import ebooklib
from ebooklib import epub
from bs4 import BeautifulSoup


# {"Question": modify_img_url(section, foldername)}
# {"Question": ""}
def get_doc_of_toc(book):
    mList = []
    chapters = book.toc

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
        print(doc.file_name)
        docs_file_name_list.append(doc.file_name)
    return docs_file_name_list


def contrast_diff(epubfile):
    epubfile = "C:\\Users\\Snowy\\Desktop\\魔鬼沟通学 - 阮琦.epub"
    book = epub.read_epub(epubfile)

    doc_of_toc_list = get_doc_of_toc(book)
    doc_items_href_list = get_doc_items_href(book)

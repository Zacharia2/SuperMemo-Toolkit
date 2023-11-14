import ebooklib
from ebooklib import epub


def isToc(parameter_list):
    pass


def list_docs(book):
    M_list = [[], []]
    isF = False
    for doc in book.get_items_of_type(ebooklib.ITEM_DOCUMENT):
        if isToc(doc) and isF is True:
            M_list[0].append(doc.file_name, [])
        elif isToc(doc):
            isF = True
            L_list = [doc.file_name, []]
            M_list[1].append(L_list)
        elif not isToc(doc):
            L_list = M_list[1].pop()
            L_list[1].append(doc.file_name)
            M_list[1].append(L_list)


# book = epub.read_epub(epubfile)

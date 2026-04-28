import re
import ebooklib
from ebooklib import epub
from bs4 import BeautifulSoup


def in_toc(book, doc):
    """判断 doc 是否在 toc 列表中，利用生成器短路"""

    def _iter_toc_hrefs(chapters):
        """生成器：递归遍历目录，产出每个条目的文件名（去除锚点）"""
        for chapter in chapters:
            if isinstance(chapter, epub.Link):
                yield chapter.href.split("#")[0]
            elif isinstance(chapter, tuple) and len(chapter) == 2:
                # 元组的第一个元素可能是 epub.Section
                if isinstance(chapter[0], epub.Section):
                    yield chapter[0].href.split("#")[0]
                # 如果第二个元素是子列表，继续递归
                if isinstance(chapter[1], list):
                    yield from _iter_toc_hrefs(chapter[1])

    return any(fname == doc.file_name for fname in _iter_toc_hrefs(book.toc))


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
        if not in_toc(book, doc) and not FirstTocChecked:
            Head.append((doc.file_name, []))
        # toc中有的。
        elif in_toc(book, doc):
            FirstTocChecked = True
            Body.append((doc.file_name, []))
        # toc中没有，但需要追加的doc。
        elif not in_toc(book, doc) and FirstTocChecked:
            # 会有多个doc位于toc之后，但没有没toc引用。
            last = Body.pop()
            exist_toc_of_doc, sibling_doc_list = last
            sibling_doc_list.append(doc.file_name)
            Body.append(last)
    return (Head, Body)


def 在已有文档目录中插入缺失的文档(
    book, chapters, 存在文档文件目录的链接, 不存在toc中的兄弟文档列表
):
    目标链接 = 存在文档文件目录的链接.split("#")[0]
    if not 不存在toc中的兄弟文档列表:
        return

    # 生成新链接的辅助函数
    def make_link(href):
        content = book.get_item_with_href(href).content
        soup = BeautifulSoup(content, "html.parser")
        text = "".join(filter(str.isalnum, soup.get_text()))
        title = re.sub(r"\\[btnfr]", "", text)[:35]
        return epub.Link(href=href, title=title if title else "无标题")

    新链接列表 = [make_link(href) for href in 不存在toc中的兄弟文档列表]

    stack = [chapters]
    已找到 = False
    while stack and not 已找到:
        curr_chapters = stack.pop()
        for idx, chapter in enumerate(curr_chapters):
            if 已找到:
                break
            # 情况1：目录项是 epub.Link
            if isinstance(chapter, epub.Link):
                file_name = chapter.href.split("#")[0]
                if file_name == 目标链接:
                    # 在此 Link 之后插入所有新链接
                    for j, link in enumerate(新链接列表):
                        curr_chapters.insert(idx + 1 + j, link)
                    已找到 = True
            # 情况2：目录项是 (epub.Section, list)
            elif (
                isinstance(chapter, tuple)
                and len(chapter) == 2
                and isinstance(chapter[0], epub.Section)
            ):
                section, links = chapter
                file_name = section.href.split("#")[0]
                if file_name == 目标链接:
                    # 在该 Section 元组之后插入，而不是插入到 links 里
                    for j, link in enumerate(新链接列表):
                        curr_chapters.insert(idx + 1 + j, link)
                    已找到 = True
                # 无论是否匹配，都要继续深入子链接列表查找
                if isinstance(links, list):
                    stack.append(links)


def merge_doc(book):
    M_list = complete_toc_with_documents(book)
    Head, Body = M_list
    # 合并没有列入toc的doc。要插入到book.toc中不存在的文档。其实只有head和sub_doc_names不为空的元素。
    # 将开始的文档构建为epub.Link
    H_list = []
    if len(Head) != 0:
        for item有记录文档跟着无记录文档列表 in Head:
            content = book.get_item_with_href(
                item有记录文档跟着无记录文档列表[0]
            ).content
            soup = BeautifulSoup(content, "html.parser")
            title = re.sub(r"\\[btnfr]", "", "".join(filter(str.isalnum, soup.text)))[
                :50
            ]
            H_list.append(
                epub.Link(href=item有记录文档跟着无记录文档列表[0], title=title)
            )
    # chapters，用toc为基待补充完整的图书章节内容
    # 将开始的不在toc中的doc加入到章节。
    epub_chapters = H_list + book.toc
    # chapters, 查找符合的href，加入到此toc的子集中。
    if len(Body) != 0:
        for item有记录文档跟着无记录文档列表 in Body:
            在toc中存在的文档, 不存在toc中的兄弟文档列表 = (
                item有记录文档跟着无记录文档列表
            )
            # 将toc中不存在的doc，插入到前面的doc的后面
            if len(不存在toc中的兄弟文档列表) != 0:
                在已有文档目录中插入缺失的文档(
                    book, epub_chapters, 在toc中存在的文档, 不存在toc中的兄弟文档列表
                )

    return epub_chapters


# 可变对象：list dict set
# 可变对象作为参数传入时，在函数中对其本身进行修改，
# 是会影响到全局中的这个变量值的，因为函数直接对该地址的值进行了修改
if __name__ == "__main__":
    book = epub.read_epub(
        r"D:\Dropbox\21-Sandox\图书专题\东尼·博赞.epub",
        {"ignore_ncx": True},
    )
    merge_doc(book)

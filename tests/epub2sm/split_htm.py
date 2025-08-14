from bs4 import BeautifulSoup, NavigableString, Tag
import ebooklib
from ebooklib import epub


# Beautiful Soup将复杂HTML文档转换成一个复杂的树形结构,每个节点都是Python对象,
# 所有对象可以归纳为4种: Tag , NavigableString , BeautifulSoup , Comment .
# 其中就两种我可以用得到：Tag , NavigableString
def merge_epub_to_topic(book):
    # 只取body内的元素合并。忽略其他，因为sm不需要。
    doc_list = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
    epub_topic = ""
    for doc in doc_list:
        # 将一本书合并为一个html。
        href = doc.file_name
        doc = book.get_item_with_href(href)
        content = doc.content.decode("utf-8") if doc else ""
        soup = BeautifulSoup(content, "html.parser")
        html_body = soup.find("body")
        for child in html_body.children:
            epub_topic += str(child)
    return epub_topic


def split_html_with_lenght(limit_num):
    html = merge_epub_to_topic(
        epub.read_epub(
            "C:/Users/Snowy/Desktop/Harry_Potter_and_the_Sorcerer_39_s_Stone_Harry_Potter_1.epub",
            {"ignore_ncx": True},
        )
    ).replace("/n", "")
    soup = BeautifulSoup(html, "html.parser")

    def recursion(node, words=0):
        if isinstance(node, NavigableString):
            # 说明是叶子
            # 叶子就开始计数，当达到数量后，找到父节点然后再父节点下一个位置插入
            # hr水平标签。
            words += len(str(node))
            if words > limit_num and node.parent:
                node_index = node.parent.index(node)
                node.parent.insert(node_index + 1, soup.new_tag("hr"))
                words = 0

        elif isinstance(node, Tag):
            # 说明是分支
            # 如果是分支就要找到他的子元素数量，如果子元素是NavigableString则计数
            # 如果子元素是Tag则进入。
            for child in [x for x in node.contents if x != "\n"]:
                words = recursion(child, words)
        return words

    recursion(soup)
    with open("C:/Users/Snowy/Desktop/1.htm", "w", encoding="utf-8") as fs:
        fs.write(soup.prettify())


split_html_with_lenght(2000)

# 保留图片和文本，取代复杂嵌套格式。就像md文档一样。
# 我想让文本想水流一样流下来，然后分段处理。
# 目前文本可能存在于深层盒子里面。而且可能存在中间位置。前后都是文本。
# 方法一，我可以使用渲染后的内容，并 源码内容，使切点对齐两者，然后加入hr或者分割。
# 方法二，像水流一样流下来，像md文档一样分块存储。

# 前序递归，计算当前结点字符数，当条件达到时候插入hr标签。从显示开始的第一个文字开始
# 累计文字数量，除以2000 <= 1.2即插入兄弟节点HR。然后重置累计继续上述步骤。

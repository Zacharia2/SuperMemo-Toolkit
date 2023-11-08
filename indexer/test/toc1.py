from xml.dom.minidom import Element
from bs4 import BeautifulSoup
import ebooklib
from ebooklib import epub

# 打开电子书
book = epub.read_epub("Systematic.epub")

# 创建toc.ncx文件
toc = epub.EpubNav()
order = 1
level = 0  # 初始层级为0

# 遍历所有的元素
for item in book.get_items():
    # 获取具有role="doc-chapter"属性的元素
    soup = BeautifulSoup(item.get_content(), "html.parser")
    element = soup.find_all(attrs={"role": "doc-chapter"})
    if item.get_type() == ebooklib.ITEM_DOCUMENT and element:
        # 获取元素的标题和层级
        title = element[0].get("title")
        
        level = 3
        # 判断标题内容类型，并确定层级关系
        if "PART" in title:
            level = 1
        elif "CHAPTER" in title:
            level = 2
        # elif 'C' in title:
        #     level = 3
        # elif 'D' in title:
        #     level = 4

        # 创建toc.ncx的NavPoint
        # navpoint = epub.EpubNav(title, "nav_point_%d" % order, content=item)

        # 根据层级关系添加父子关系
        parent = toc
        for _ in range(level - 1):
            parent = parent.subsections[-1]
        parent.add_item("")

        order += 1

# 将toc.ncx保存到电子书中
book.add_item(toc)
book.toc = "toc.ncx"
book.add_item(epub.EpubNcx())
book.add_item(epub.EpubNav())

# 保存电子书
epub.write_epub("updated_book.epub", book, {})

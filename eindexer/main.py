import re
import xml.etree.ElementTree as ET
import ebooklib
from ebooklib import epub
from bs4 import BeautifulSoup

# 创建根节点
root = ET.Element("ncx", xmlns="http://www.daisy.org/z3986/2005/ncx/")
root.set("version", "2005-1")

# 创建head节点
head = ET.SubElement(root, "head")

# 创建meta节点 <meta name="dtb:depth" content="4"/>
meta = ET.SubElement(head, "meta", {"name": "dtb:depth", "content": "4"})


# 创建docTitle节点
doc_title = ET.SubElement(root, "docTitle")
text = ET.SubElement(doc_title, "text")
text.text = "Your Document Title"

# 创建navMap节点
nav_map = ET.SubElement(root, "navMap")

# 添加章节节点
chapter1 = ET.SubElement(nav_map, "navPoint", id="chapter1", playOrder="1")
chapter1_text = ET.SubElement(chapter1, "navLabel", id="chapter1-label")
chapter1_text.text = "Chapter 1"
chapter1_src = ET.SubElement(chapter1, "content", src="chapter1.html")


# 读取书籍，找到所有role="doc-chapter"的元素，然后判断title="PART 还是其它类别。

# 打开电子书
book = epub.read_epub("Systematic.epub")
order = 1

pattren = [
    r"PART\s\d+",
    r"CHAPTER\s\d+",
    r"[A-Z]\.",
    r"\d\.+",
]

def check_title(str):
    for index, value in enumerate(pattren):
        match = re.search(value,str)
        if match:
            return index
        else:
            return False


# 遍历所有的元素
for item in book.get_items():
    # 获取具有role="doc-chapter"属性的元素
    soup = BeautifulSoup(item.get_content(), "html.parser")
    element = soup.find_all(attrs={"role": "doc-chapter"})
    if item.get_type() == ebooklib.ITEM_DOCUMENT and element:
        # 获取元素的标题和层级
        title = element[0].get("title")

        if check_title(title) == 1:
            pass
        elif check_title(title) == 2:
            pass
        elif check_title(title) == 3:
            pass
        elif check_title(title) == 4:
            pass

# 添加更多章节节点...

# 创建ElementTree对象
tree = ET.ElementTree(root)

# 将生成的ncx保存到文件
tree.write("m_test_toc.ncx", encoding="UTF-8", xml_declaration=True)

import ebooklib
from ebooklib import epub
from bs4 import BeautifulSoup
import xml.etree.ElementTree as ET
from collections import defaultdict


# elemnt为传进来的Elment类，参数indent用于缩进，newline用于换行
def prettyXml(element, indent, newline, level=0):
    # 判断element是否有子元素
    if element:
        # 如果element的text没有内容
        if element.text is None or element.text.isspace():
            element.text = newline + indent * (level + 1)
        else:
            element.text = (
                newline
                + indent * (level + 1)
                + element.text.strip()
                + newline
                + indent * (level + 1)
            )
    # 此处两行如果把注释去掉，Element的text也会另起一行
    # else:
    # element.text = newline + indent * (level + 1) + element.text.strip() + newline + indent * level
    temp = list(element)  # 将elemnt转成list
    for subelement in temp:
        # 如果不是list的最后一个元素，说明下一个行是同级别元素的起始，缩进应一致
        if temp.index(subelement) < (len(temp) - 1):
            subelement.tail = newline + indent * (level + 1)
        else:  # 如果是list的最后一个元素， 说明下一行是母元素的结束，缩进应该少一个
            subelement.tail = newline + indent * level
        # 对子元素进行递归操作
        prettyXml(subelement, indent, newline, level=level + 1)


# 载入电子书
book = epub.read_epub("epubs/聪明人的个人成长.epub")
# print(book.toc)
# print(book.get_metadata("DC", "title"))
# # 解析

# # 提取书中的文本内容
# documents = book.get_items_of_type(ebooklib.ITEM_DOCUMENT)
# # 提取书中的文本内容
# images = book.get_items_of_type(ebooklib.ITEM_IMAGE)

# for tag in documents:
#     # epub中的内容是html格式，使用BeautifulSoup可以完美解析
#     soup = BeautifulSoup(tag.get_content(), "html")
#     # print(soup)

# 获取书籍的toc信息
toc = book.toc

# 创建字典用于保存层级关系
doc_dict = defaultdict(list)




def create_supermemo_element(parent_element, element_data):
    supermemo_element = ET.SubElement(parent_element, "SuperMemoElement")

    for key, value in element_data.items():
        if key == "SuperMemoElement":
            for sub_element_data in value:
                create_supermemo_element(supermemo_element, sub_element_data)
        elif key == "Content":
            content = ET.SubElement(supermemo_element, "Content")
            for sub_key, sub_value in value.items():
                sub_element = ET.SubElement(content, sub_key)
                sub_element.text = str(sub_value)
        else:
            sub_element = ET.SubElement(supermemo_element, key)
            sub_element.text = str(value)


def create_xml(data):
    root = ET.Element("SuperMemoCollection")

    count = ET.SubElement(root, "Count")
    count.text = str(len(data))

    for element_data in data:
        create_supermemo_element(root, element_data)

    tree = ET.ElementTree(root)
    root = tree.getroot()  # 得到根元素，Element类
    prettyXml(root, "\t", "\n")  # 执行美化方法
    tree.write("example.xml", encoding="utf-8", xml_declaration=True)
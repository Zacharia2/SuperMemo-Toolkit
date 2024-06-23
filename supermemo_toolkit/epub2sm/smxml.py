import os
from typing import Any
from xml.etree.ElementTree import Element, SubElement, ElementTree

import ebooklib
from ebooklib import epub

from supermemo_toolkit.utilscripts.ulils import mkdir


# sys.path.insert(0, os.path.normpath(sys.path[0] + "/../../"))


class SmXml:
    def __init__(self, book_name: str, save_folder=os.getcwd(), **kwargs):
        self.save_folder: str = save_folder
        self.book_name: str = book_name
        self.ebook: epub.EpubBook = kwargs["ebook"]
        self.book_file_path: str = os.path.join(self.save_folder, self.book_name + ".xml")
        self.book_img_folder: str = os.path.join(self.save_folder, self.book_name)

    def create_xml(self, data: list[dict[str, Any]]):
        """输入data, 创建SuperMemo-XML-Book

        Args: data (_type_): list[sm_element_dict[attr:value]],
        if attr == SuperMemoElement: attr = list[sm_element_dict[attr:value]]
        """

        root = Element("SuperMemoCollection")
        count = SubElement(root, "Count")
        self.set_unique_id(data)
        count.text = self.count_ids(data)
        self.create_supermemo_element(root, data)
        tree = ElementTree(root)
        tree.write(self.book_file_path, encoding="utf-8", xml_declaration=True)
        if self.ebook:
            self.write_img_file(self.ebook)

    def create_supermemo_element(self, parent_element: Element, data: list[dict[str, Any]]) -> None:
        supermemo_element = SubElement(parent_element, "SuperMemoElement")
        for element_data in data:
            for key, value in element_data.items():
                if key == "SuperMemoElement":
                    # SuperMemoElement是一个数组
                    self.create_supermemo_element(supermemo_element, value)
                elif key == "Content":
                    content = SubElement(supermemo_element, "Content")
                    for sub_key, sub_value in value.items():
                        sub_element = SubElement(content, sub_key)
                        sub_element.text = str(sub_value)
                else:
                    sub_element = SubElement(supermemo_element, key)
                    sub_element.text = str(value)

    @staticmethod
    def count_ids(data: list[dict[str, Any]]) -> str:
        count = 0
        stack = list(data)  # 将初始数据转换为栈
        while stack:
            item = stack.pop()  # 从栈中取出一个元素
            if "ID" in item:
                count += 1
            if "SuperMemoElement" in item:
                stack.extend(item["SuperMemoElement"])  # 将嵌套的列表扩展到栈中
        return str(count)

    @staticmethod
    def set_unique_id(data: list[dict[str, Any]]):
        """为SuperMemo元素设置id

        Args:
            data (_type_): _description_
        """
        count = 1
        stack = data + []
        while stack:
            current_element = stack.pop()
            current_element["ID"] = count
            count += 1
            if "SuperMemoElement" in current_element:
                # SuperMemoElement是一个数组
                for sub_element in current_element["SuperMemoElement"]:
                    stack.append(sub_element)

    def write_img_file(self, ebook: epub.EpubBook) -> None:
        """写出img文件到SuperMemo-XML-Book文件旁边的文件夹中。"""
        for image in ebook.get_items_of_type(ebooklib.ITEM_IMAGE):
            # 可以得到image.file_name 和 image.content二进制数据、image.media_type
            # os.path.abspath(".")
            if not os.path.exists(self.book_img_folder):
                mkdir(self.book_img_folder)
            if image.file_name.find("/") != -1:
                filename = image.file_name.split("/")[-1]
                file_path = os.path.join(self.book_img_folder, filename)
            else:
                file_path = os.path.join(self.book_img_folder, image.file_name)
            with open(file_path, "wb") as f:
                f.write(image.content)

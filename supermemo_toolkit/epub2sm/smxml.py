import os
import xml.etree.ElementTree as Et

import ebooklib
from ebooklib import epub

from supermemo_toolkit.utilscripts.ulils import mkdir
# sys.path.insert(0, os.path.normpath(sys.path[0] + "/../../"))


class SmXml:
    def __init__(self, ebook: epub.EpubBook, book_name: str, save_folder=os.getcwd()):
        self.ebook = ebook
        self.save_folder = save_folder
        self.book_name = book_name
        self.book_file_path = os.path.join(self.save_folder, self.book_name + ".xml")
        self.book_img_folder = os.path.join(self.save_folder, self.book_name)

    def create_xml(self, data):
        """输入data, 创建SuperMemo-XML-Book

        Args:
            data (_type_): _description_
        """

        root = Et.Element("SuperMemoCollection")

        count = Et.SubElement(root, "Count")
        self.set_unique_id(data)
        count.text = str(self.count_ids(data))

        for element_data in data:
            self.create_supermemo_element(root, element_data)

        tree = Et.ElementTree(root)
        tree.write(self.book_file_path, encoding="utf-8", xml_declaration=True)

        self.write_img_file()

    def create_supermemo_element(self, parent_element, element_data):
        supermemo_element = Et.SubElement(parent_element, "SuperMemoElement")

        for key, value in element_data.items():
            if key == "SuperMemoElement":
                # SuperMemoElement是一个数组
                for sub_element_data in value:
                    self.create_supermemo_element(supermemo_element, sub_element_data)
            elif key == "Content":
                content = Et.SubElement(supermemo_element, "Content")
                for sub_key, sub_value in value.items():
                    sub_element = Et.SubElement(content, sub_key)
                    sub_element.text = str(sub_value)
            else:
                sub_element = Et.SubElement(supermemo_element, key)
                sub_element.text = str(value)

    def count_ids(self, data):
        count = 0
        for item in data:
            if "ID" in item:
                count += 1
            if "SuperMemoElement" in item:
                count += self.count_ids(item["SuperMemoElement"])
        return count

    @staticmethod
    def set_unique_id(data: list):
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

    def write_img_file(self):
        """写出img文件到SuperMemo-XML-Book文件旁边的文件夹中。"""
        for image in self.ebook.get_items_of_type(ebooklib.ITEM_IMAGE):
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

import os
import time
import requests
from readability import Document
import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup


class Gen_SM_BookXML:
    def __init__(self, xmlname: str, savefolder=os.getcwd()):
        self.savefolder = savefolder
        self.xmlname = xmlname
        self.book_file_path = os.path.join(self.savefolder, self.xmlname + ".xml")

    def create_xml(self, data):
        """输入data, 创建SuperMemo-XML-Book

        Args:
            data (_type_): _description_
        """

        root = ET.Element("SuperMemoCollection")

        count = ET.SubElement(root, "Count")
        self.set_unique_id(data)
        count.text = str(self.count_ids(data))

        for element_data in data:
            self.create_supermemo_element(root, element_data)

        tree = ET.ElementTree(root)
        tree.write(self.book_file_path, encoding="utf-8", xml_declaration=True)

    def create_supermemo_element(self, parent_element, element_data):
        supermemo_element = ET.SubElement(parent_element, "SuperMemoElement")

        for key, value in element_data.items():
            if key == "SuperMemoElement":
                for sub_element_data in value:
                    self.create_supermemo_element(supermemo_element, sub_element_data)
            elif key == "Content":
                content = ET.SubElement(supermemo_element, "Content")
                for sub_key, sub_value in value.items():
                    sub_element = ET.SubElement(content, sub_key)
                    sub_element.text = str(sub_value)
            else:
                sub_element = ET.SubElement(supermemo_element, key)
                sub_element.text = str(value)

    def count_ids(self, data):
        count = 0
        for item in data:
            if "ID" in item:
                count += 1
            if "SuperMemoElement" in item:
                count += self.count_ids(item["SuperMemoElement"])
        return count

    def set_unique_id(self, data: list):
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
                for sub_element in current_element["SuperMemoElement"]:
                    stack.append(sub_element)


# with open("pathpix/weblist.txt", "r", encoding="utf-8") as f:
#     lines = f.readlines()
# 这个是Collection下的第一层SuperMemoElement

# lines = [
#     "https://blog.csdn.net/cqcre/article/details/100681678",
#     "https://github.com/andreasvc/readability/",
# ]

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0",
}

start = time.time()
with open("C:/Users/Snowy/Desktop/favorites_2024_2_24.html", "rb") as f:
    raw = f.read()
    soup = BeautifulSoup(raw, "html.parser")
    a_link_list = soup.find_all("a")
    link_list = [x.attrs["href"] for x in a_link_list if "href" in x.attrs]

print(f"WebI::检测到 {len(link_list)} 条链接")
rootElement = []
for link in link_list:
    try:
        response = requests.get(link, stream=True, headers=headers)
        content_type = response.headers.get("content-type")
        content = response.content
        doc = Document(response.content)
        m_element = {
            "Title": doc.title(),
            "Type": "Topic",
            "Content": {"Question": str(doc.summary(html_partial=True))},
        }
        rootElement.append(m_element)
        print(link)
    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
    except ValueError as e:
        print("响应解析异常: ", e)
    except Exception:
        pass

webfile = Gen_SM_BookXML("websmxml")
end = time.time()
print("WebI:: Done!", f" 耗时 {end - start:.2f} 秒。")
# 根据数据结构创建XML文件
webfile.create_xml(rootElement)

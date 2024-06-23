import os
import time
import requests
from readability import Document
import xml.etree.ElementTree as ET
from bs4 import BeautifulSoup
from supermemo_toolkit.epub2sm.smxml import SmXml


# with open("pathpix/weblist.txt", "r", encoding="utf-8") as f:
#     lines = f.readlines()
# 这个是Collection下的第一层SuperMemoElement

# lines = [
#     "https://blog.csdn.net/cqcre/article/details/100681678",
#     "https://github.com/andreasvc/readability/",
# ]

headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 "
                  "Safari/537.36 Edg/119.0.0.0",
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

webfile = SmXml("web_sm_xml")
end = time.time()
print("WebI:: Done!", f" 耗时 {end - start:.2f} 秒。")
# 根据数据结构创建XML文件
webfile.create_xml(rootElement)

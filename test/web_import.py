import os
import sys
from bs4 import BeautifulSoup

import requests

sys.path.insert(0, sys.path[0] + "/../")
from epub2sm.epub2sm import create_xml, set_unique_id  # noqa: E402


def H5_filter(soup):
    """
    对爬取的 H5 进行过滤
    :return:
    """
    tags = soup.find_all()
    for tag in tags:
        if tag.name == "script":
            tag.decompose()  # 剔除所有 script 脚本
        # if tag.name == "link":
        #     tag.decompose()
    filter_article = soup.find("body")  # 只拿 body
    return filter_article


# blog.csdn.net  div class="blog-content-box"
# 知乎 article class="Post-Main Post-NormalMain" class="Card AnswerCard css-0" class="ContentItem AnswerItem" ; class="ContentItem AnswerItem" data-za-index="0"
# 微信文章 div id="page-content" id="js_article"


# def funcname(parameter_list):
# 这个是Collection下的第一层SuperMemoElement
rootElement = []


headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36 Edg/119.0.0.0",
}

with open("pathpix/weblist.txt", "r", encoding="utf-8") as f:
    lines = f.readlines()
for line in lines:
    response = requests.get(line, stream=True, headers=headers)
    web_content = response.text
    soup = BeautifulSoup(web_content, "html.parser")
    filter_article = H5_filter(soup)
    # print(filter_article)
    with open("pathpix/weblist-11.html", "w", encoding="utf-8") as f:
        f.write(str(filter_article))
    Content = {"Question": filter_article}
    element = {
        "Title": soup.title.string,
        "Type": "Topic",
        "Content": Content,
        # "SuperMemoElement": SuperMemoElement,
    }
    rootElement.append(element)
set_unique_id(rootElement)
web_file_path = os.path.join("web" + ".xml")

# 根据数据结构创建XML文件
create_xml(rootElement, web_file_path)

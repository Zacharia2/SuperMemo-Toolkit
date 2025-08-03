import html
from bs4 import BeautifulSoup
import re


def haved_Title(el):
    for item in el.children:
        if item.name == "Title":
            return True
    return False


def parse(text):
    ref_dict = {}
    q_text: str = html.unescape(text)
    reference = re.search(
        r"<FONT class=reference>(.*?)</FONT>",
        re.split(r"<hr[\s\S]*?SuperMemo>", q_text)[-1],
        re.DOTALL,
    )
    if reference:
        ref_contents = reference.group(1).replace("\n", "").split("<br>")
        for ref_item in ref_contents:
            key, value = ref_item.split(":", 1)
            key = key.strip("#").strip()
            value = value.strip()
            ref_dict[key] = value
    return ref_dict


def tcomp(needfix, output):
    with open(needfix, mode="r") as fs:
        xml = fs.read()
    soup = BeautifulSoup(xml, "xml")
    # - SuperMemoElement
    #   - Title
    #   - Content
    #     - Question
    questions = soup.find_all("Question")
    for question in questions:
        el = question.parent.parent
        if haved_Title(el):
            continue
        # 排除掉有Title的el
        ref_dict = parse(question.text)
        new_title = soup.new_tag("Title")
        # TODO 有两个问题，一个是元素没设置ref，但父设置了，所以用的父的ref
        # 另一个问题是没有ref，但我导入图书的时候设计了title但没有生成ref。
        # 总之title是存放在知识树中的，导出XML会没有。
        new_title.string = ref_dict.get("Title") or "111"
        el.insert(0, new_title)
    with open(output, mode="w", encoding="utf-8") as fs:
        fs.write(str(soup))


infile = "C:/Users/Snowy/Desktop/1122.xml"
outfile = "C:/Users/Snowy/Desktop/5566.xml"

tcomp(infile, outfile)

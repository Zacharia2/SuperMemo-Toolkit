import html
from bs4 import BeautifulSoup
import re


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
        q_text: str = html.unescape(question.text)
        reference = re.search(
            r"<FONT class=reference>(.*?)</FONT>",
            re.split(r"<hr[\s\S]*?SuperMemo>", q_text)[-1],
            re.DOTALL,
        )
        if reference:
            ref_contents = reference.group(1).replace("\n", "").split("<br>")
        ref_dict = {}
        for ref_item in ref_contents:
            key, value = ref_item.split(":", 1)
            key = key.strip("#").strip()
            value = value.strip()
            ref_dict[key] = value
        new_title = soup.new_tag("Title")
        new_title.string = ref_dict.get("Title")
        el.insert(0, new_title)
    with open(output, mode="w", encoding="utf-8") as fs:
        fs.write(
            str(soup.encode(encoding="ascii"), "utf-8")
            .replace("\n", "")
            .replace("\r", "")
        )


infile = "C:/Users/Snowy/Desktop/2233.xml"
outfile = "C:/Users/Snowy/Desktop/5566.xml"

# tcomp(infile,outfile)

from bs4 import BeautifulSoup
import re


def haved_Title(el):
    for item in el.children:
        if item.name == "Title":
            return True
    return False


def parseHTM(file: str):
    with open(file, mode="r", encoding="utf-8") as fs:
        htms = [x.strip() for x in fs.read().split("<hr>") if x != ""]
    mapIdTitle = {}
    for htm in htms:
        soup = BeautifulSoup(htm, "html.parser")
        for item in soup.children:
            if re.match(r"(\w+)\s+#([\d,]+):", item.text):
                key, value = item.text.split(":", 1)
                key = key.split(" ")[-1].replace(",", "").strip("#").strip()
                value = value.strip().replace("\u3000", " ")
                mapIdTitle[key] = value
    return mapIdTitle


def xml_tcomp(needfix, patch):
    with open(needfix, mode="r") as fs:
        xml = fs.read()
    soup = BeautifulSoup(xml, "xml")
    # - SuperMemoElement
    #   - Title
    #   - ID
    IDs = soup.find_all("ID")
    for ID in IDs:
        el = ID.parent
        if haved_Title(el):
            continue
        new_title = soup.new_tag("Title")
        new_title.string = patch.get(ID.text)
        el.insert(0, new_title)
    with open(needfix, mode="w", encoding="utf-8") as fs:
        fs.write(str(soup))


infile = "C:/Users/Snowy/Desktop/1.xml"
inhtm = "C:/Users/Snowy/Desktop/1.htm"
patch = parseHTM(inhtm)
xml_tcomp(infile, patch)

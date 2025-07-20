from bs4 import BeautifulSoup

modifyFile = "d:/supermemo/systems/reading-and-review/elements/6/26/2063.HTM"

with open(modifyFile, "r") as fs:
    doc = fs.read()
soup = BeautifulSoup(doc, "html.parser")
ph3 = soup.find_all("p", class_="calibre_3")
for p in ph3:
    p.name = "h3"
result = str(soup.encode(encoding="ascii"), "utf-8").replace("/n", "").replace("/r", "")
# print(result)
with open(modifyFile, "w") as fs:
    fs.write(result)

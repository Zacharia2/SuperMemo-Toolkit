from bs4 import BeautifulSoup

from supermemo_toolkit.utilscripts.ulils import get_id_func

get_id = get_id_func()
with open("c:/Users/Snowy/Desktop/COCA-20000.xml", "r", encoding="utf-8") as fs:
    xml = fs.read()

soup = BeautifulSoup(xml, features="xml")
types = soup.find_all("Type")
for i, type in enumerate(types):
    # - SuperMemoElement
    #   - Type
    el = type.parent
    new_id = soup.new_tag("ID")
    new_id.string = get_id()
    el.insert(0, new_id)
with open(
    "c:/Users/Snowy/Desktop/COCA-20000-hasId.xml", mode="w", encoding="utf-8"
) as fs:
    fs.write(str(soup))
print("XML处理完成。")

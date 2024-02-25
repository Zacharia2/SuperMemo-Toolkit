import json
from pyquery import PyQuery
import urllib.request
from bs4 import BeautifulSoup


# from bs4 import BeautifulSoup

# html = """<strike style="color: #777777">975</strike> 487 RP<div class="gs-container default-2-col">"""
# soup = BeautifulSoup(html)

# #find <strike> element first, then get text element next to it
# result = soup.find('strike',{'style': 'color: #777777'}).findNextSibling(text=True)

# print(result.encode('utf-8'))
# #output : ' 487 RP'
# #you can then do simple text manipulation/regex to clean up the result


def request(action, **params):
    return {"action": action, "params": params, "version": 6}


def invoke(action, **params):
    requestJson = json.dumps(request(action, **params)).encode("utf-8")
    response = json.load(
        urllib.request.urlopen(
            urllib.request.Request("http://127.0.0.1:8765", requestJson)
        )
    )
    if len(response) != 2:
        raise Exception("response has an unexpected number of fields")
    if "error" not in response:
        raise Exception("response is missing required error field")
    if "result" not in response:
        raise Exception("response is missing required result field")
    if response["error"] is not None:
        raise Exception(response["error"])
    return response["result"]


note_id_list = invoke("findNotes", query="deck:词义分类")
notesInfo = invoke("notesInfo", notes=note_id_list)

for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    # 整理 phonetic
    # phonetic_w = fields["phonetic"]["value"]
    # v_soup = BeautifulSoup(phonetic_w, "html.parser")
    # vocabulary_tag = v_soup.find(class_="vocabulary")
    # phonetic = str(vocabulary_tag.findNextSibling(text=True)).strip()
    # 整理 definition
    definition = fields["definition"]["value"]
    d_soup = BeautifulSoup(definition, "html.parser")
    definition_tag = d_soup.find_all(class_="definition")
    de_list = []
    for def_tag in definition_tag:
        definition_class = PyQuery(str(def_tag))
        de_class = PyQuery("<span></span>")
        de_class.add_class("de")
        de_class.append(definition_class)
        sentence: str = str(def_tag.findNextSibling(text=True)).strip()
        example_list = [x.strip() for x in sentence.split("/")]
        ol_tag = PyQuery("<ol></ol>")
        ol_tag.add_class("example")
        for example in example_list:
            li_tag = PyQuery("<li></li>")
            li_tag.text(example)
            ol_tag.append(li_tag)
        de_class.append(ol_tag)
        de_list.append(de_class)
    de_list = " ".join([str(de) for de in de_list])
    invoke(
        "updateNote",
        note={
            "id": noteId,
            "fields": {"definition": de_list},
        },
    )
    print(f"{index+1}/{len(notesInfo)}")

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     field3 = fields["field3"]["value"]
#     word = fields["word"]["value"]
#     if field3 != "":
#         print(word)

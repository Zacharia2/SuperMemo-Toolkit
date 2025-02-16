import json
import os

from supermemo_toolkit.utilscripts.ankinet import invoke

# note_id_list = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇"
# )
# notesInfo = invoke("notesInfo", notes=note_id_list)
# mjson = dict()
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     word = fields["word"]["value"]
#     tyj = fields["同义句"]["value"]
#     tyj_mean = fields["同义句释义"]["value"]
#     mjson[word] = [tyj, tyj_mean]
#     print(word, f"{index + 1}/{len(notesInfo)}")
#
# with open(os.path.join(os.getcwd(),"m.json"), "w", encoding="utf-8") as json_file:
#     json.dump(mjson, json_file, indent=4)


with open(os.path.join(os.getcwd(), "m.json"), "rb") as f:
    raw_data = f.read()
    json_data = json.loads(raw_data)

note_id_list = invoke("findNotes", query="deck:24意境语义红宝石")
notesInfo = invoke("notesInfo", notes=note_id_list)
for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    if word in json_data:
        invoke(
            "updateNote",
            note={
                "id": noteId,
                "fields": {"同义短句": json_data[word][0], "同义释义": json_data[word][1]}
            },
        )
        print(fields["word"]["value"], f"{index + 1}/{len(notesInfo)}")

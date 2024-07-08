from tests.anki.main import invoke
import json

note_id_list = invoke(
    "findNotes", query="deck:2024红宝书考研词汇"
)
notesInfo = invoke("notesInfo", notes=note_id_list)
for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    try:
        TJF = json.loads(fields["同近反"]["value"].replace("'", '"'))
        if "related" in TJF:
            del TJF['related']
            result = json.dumps(TJF, ensure_ascii=False)
            invoke(
                "updateNote",
                note={
                    "id": noteId,
                    "fields": {"同近反": result}
                },
            )
            print(fields["word"]["value"], f"{index + 1}/{len(notesInfo)}")
        else:
            continue
    except Exception as e:
        print(e)
    
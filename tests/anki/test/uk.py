from main import download_youdao_word_uk, invoke


note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    if fields["UK"]["value"] == "" or fields["UK"]["value"].count("/") > 2:
        uk = download_youdao_word_uk(word)
        if uk and uk != "":
            invoke(
                "updateNote",
                note={
                    "id": noteId,
                    "fields": {"UK": uk},
                },
            )
            print(word, uk, f"{index + 1}/{len(notesInfo)}")

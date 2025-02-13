from main import download_word_sound, invoke

note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

notesInfo = invoke("notesInfo", notes=note_id_list)
for noteInfo in notesInfo:
    noteId = noteInfo["noteId"]
    tag = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    sound = fields["单词音频"]["value"]
    if sound == "":
        # 下载单词音频
        (file_name, file_data) = download_word_sound(word, 1)
        if file_name != "" and file_data != "":
            # 存储音频到anki
            result_filename = invoke(
                "storeMediaFile", filename=file_name, data=file_data
            )
            if result_filename:
                invoke(
                    "updateNote",
                    note={
                        "id": noteId,
                        "fields": {"单词音频": f"[sound:{result_filename}]"},
                    },
                )
                print(noteId, result_filename)

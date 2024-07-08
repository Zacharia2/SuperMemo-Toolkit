import json

from main import invoke

note_id_list = invoke("findNotes", query="deck:24意境语义红宝石")
notesInfo = invoke("notesInfo", notes=note_id_list)

# headwords, items = u_mdx("D:/Software/MDictPC/doc/ode_glance/ode_glance.mdx")
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     anki_word = fields["word"]["value"]
# if anki_word.encode() in headwords:
#     word, html = items[headwords.index(anki_word.encode())]
#     word, html = word.decode(), html.decode()
#     pq = PyQuery(html)
#     exampleGroup = pq(".exampleGroup.exGrBreak")
#     # 查找有翻译的句子。
#     first_example = None
#     first_example_sentence_en = ""
#     first_example_sentence_cn = ""
#     # 有中文的
#     for item in exampleGroup:
#         child = PyQuery(item).find('.cn').eq(0)
#         if child:
#             first_example = PyQuery(item)
#             first_example_sentence_en = first_example(".example").html()
#             first_example_sentence_cn = first_example(".cn").html()
#             first_example_sentence_en = first_example_sentence_en.replace(anki_word,
#                                                                           f"<span class='decorated_word'>{anki_word}</span>")
#             break
#     # 否则，随便找个有英文的
#     if not first_example:
#         for item in exampleGroup:
#             child = PyQuery(item).find('.example').eq(0)
#             if child:
#                 first_example = PyQuery(item)
#                 first_example_sentence_en = first_example(".example").html()
#                 first_example_sentence_en = first_example_sentence_en.replace(anki_word,
#                                                                               f"<span class='decorated_word'>{anki_word}</span>")
#                 break
#
#     invoke(
#         "updateNote",
#         note={
#             "id": noteId,
#             "fields": {"q_sentence": first_example_sentence_en, "a_sentence": first_example_sentence_cn},
#             "tag": []
#         },
#     )
#     print(f"{index + 1}/{len(notesInfo)}")


for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    try:
        SA: dict = json.loads(fields["SA"]["value"].replace("'", '"'))
        for key in SA.keys():
            SA[key] = SA[key][:6]
        result = json.dumps(SA, ensure_ascii=False)
        invoke(
            "updateNote",
            note={
                "id": noteId,
                "fields": {"SA": result},
                "tags": []
            },
        )
        print(fields["word"]["value"], f"{index + 1}/{len(notesInfo)}")

    except Exception as e:
        print(e)

# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# backup = dict()

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     word = fields["word"]["value"]
#     aabbyy = fields["意境嵌入词义"]["value"]
#     if aabbyy and aabbyy != "":
#         aabbyy_doc = PyQuery(aabbyy)
#         c = str(aabbyy_doc)
#         li_list = aabbyy_doc.children()
#         if len(li_list) > 4:
#             li_list = backward_erasure(li_list, 4)
#             ol_tag = PyQuery("<ol></ol>")
#             ol_tag.add_class("english_sentiment")
#             for li in li_list:
#                 ol_tag.append(li)
#             # 更新
#             m = str(ol_tag)
#             if len(ol_tag.children()) != 0:
#                 invoke(
#                     "updateNote",
#                     note={
#                         "id": noteId,
#                         "fields": {"意境嵌入词义": str(ol_tag)},
#                     },
#                 )
#                 print("es", f"{index+1}/{len(notesInfo)}")

# with open("./backup.json", "rb") as f:
#     raw_data = f.read()
#     json_data = json.loads(raw_data)

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     word = fields["word"]["value"]
#     aabbyy = fields["意境嵌入词义"]["value"]
#     ab = json_data[word]
#     try:
#         invoke(
#             "updateNote",
#             note={
#                 "id": noteId,
#                 "fields": {"意境嵌入词义": ab},
#             },
#         )
#         print("es", f"{index+1}/{len(notesInfo)}")
#     except Exception as e:
#         print(e)

#     if not aabbyy == "":
#         backup.update({word: aabbyy})
# backup_bytes = json.dumps(backup, ensure_ascii=False).encode()
# with open("./backup.json", "wb") as f:
#     f.write(backup_bytes)
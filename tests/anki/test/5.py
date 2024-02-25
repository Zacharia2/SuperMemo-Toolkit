# note_id_list = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if "剑桥LE" not in tags:
#         explain = download_cambridge_words_explain(fields["word"]["value"])
#         if explain:
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"剑桥LE英英释义": explain},
#                     "tags": ["剑桥LE"],
#                 },
#             )
#             print(fields["word"]["value"], "explain", f"{index+1}/{len(notesInfo)}")

# <br>
# with open("./mdict.json", "rb") as f:
#     raw_data = f.read()
#     mdict = json.loads(raw_data)

# note_id_list = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for noteInfo in notesInfo:
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     word: str = fields["word"]["value"]
#     if word in mdict.keys():
#         if len(mdict[word]) >= 1:
#             more_meaning = mdict[word]
#             cpath = list()
#             for single in more_meaning:
#                 if len(single) >= 1:
#                     cpath.append(single[0])
#             cyfl_path = "<br>".join(cpath)
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"词义分类": cyfl_path},
#                     "tags": [""],
#                 },
#             )
#             print(noteId, cyfl_path, word)
# pass

# note_id_list1 = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo1 = invoke("notesInfo", notes=note_id_list1)

# words = dict()
# for noteInfo in notesInfo1:
#     words.update({noteInfo["fields"]["word"]["value"]: noteInfo["noteId"]})

# >>>
# note_id_list2 = invoke("findNotes", query="deck:Anki创享岛-2024恋练有词")
# notesInfo2 = invoke("notesInfo", notes=note_id_list2)
# wait_list = dict()
# for index, noteInfo in enumerate(notesInfo2):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if fields["英"]["value"] not in words:
#         yin = fields["音"]["value"]
#         yi = fields["译"]["value"]
#         zu = fields["组"]["value"].replace(" ","-")
#         wait_list.update({fields["英"]["value"]: (yin, yi, zu)})

# for word, tup in wait_list.items():
#     (yin, yi, zu) = tup
#     invoke(
#         "addNote",
#         note={
#             "deckName": "2024红宝书考研词汇（必考词+基础词+超纲词）::D - 扩展词",
#             "modelName": "新模板 6.0",
#             "fields": {
#                 "word": word,
#                 "单词": word,
#                 "US": yin,
#                 "释义": yi,
#             },
#             "options": {
#                 "allowDuplicate": False,
#                 "duplicateScope": "deck",
#                 "duplicateScopeOptions": {
#                     "deckName": "Default",
#                     "checkChildren": False,
#                     "checkAllModels": False,
#                 },
#             },
#             "tags": ["2024恋练有词", zu],
#         },
#     )
#     print(word, "add")


# pass
# >>>
# note_id_list = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if "剑桥LE" not in tags:
#         explain = download_cambridge_words_explain(fields["word"]["value"])
#         if explain:
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"剑桥LE英英释义": explain},
#                     "tags": ["剑桥LE"],
#                 },
#             )
#             print(fields["word"]["value"], "explain", f"{index+1}/{len(notesInfo)}")


# >>> download_collins_words_explain
# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# mdx = MDX("D:\\Software\\MDictPC\\doc\\Collins\ccald9.mdx")
# headwords = [*mdx]  # 单词名列表
# items = [*mdx.items()]  # 释义html源码列表
# if len(headwords) == len(items):
#     print(f"加载成功：共{len(headwords)}条")
# else:
#     print(f"【ERROR】加载失败{len(headwords)}，{len(items)}")

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     words = fields["word"]["value"]
#     if words.encode() in headwords:
#         word, html = items[headwords.index(words.encode())]
#         word, html = word.decode(), html.decode()
#         pqdoc = PyQuery(html)
#         explain_entrys = pqdoc("div > div.cobuild > div.definitions")
#         for a_tag in explain_entrys("div.def > a"):
#             # 创建一个新的<u>标签，并将<a>标签的文本内容赋值给它
#             span_tag = PyQuery("<span></span>")
#             span_tag.attr["class"] = a_tag.attrib["class"]
#             span_tag.text(a_tag.text)
#             explain_entrys(a_tag).replaceWith(span_tag)
#         a_hwd_sound_mdd = explain_entrys("a.hwd_sound")
#         a_tag_html = [
#             PyQuery(a_tag).html()
#             for a_tag in a_hwd_sound_mdd
#             if PyQuery(a_tag).html() != ""
#         ]
#         for a_tag in a_hwd_sound_mdd:
#             if PyQuery(a_tag).html() == "":
#                 a_hwd_sound_mdd(a_tag).remove()
#         # 如果a标签没有内容就啥也不做，反之去掉标签a。
#         if len(a_tag_html) > 0:
#             for index, a_tag in enumerate(a_hwd_sound_mdd):
#                 sub = a_tag_html[index]
#                 explain_entrys(a_tag).replaceWith(PyQuery(sub))
#             # PyQuery有定义__str__魔法方法，当试图将一个对象转换为字符串时会调用此方法。
#         explain = str(explain_entrys)
#         invoke(
#             "updateNote",
#             note={
#                 "id": noteId,
#                 "fields": {"柯林斯": explain},
#                 # "tags": tags,
#             },
#         )
#         print(fields["word"]["value"], "explain", f"{index+1}/{len(notesInfo)}")
#     else:
#         print(f"【未找到单词】：{words}")
#     # if "柯林斯" not in tags:
#     # tags.append("柯林斯")
#     # if "Mdict柯林斯" in tags:
#     #     tags.remove("Mdict柯林斯")

# >>>
# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     yuanshu = fields["原书"]["value"]
#     if yuanshu != "" and "english_sentiment" in tags:
#         pqdoc = PyQuery(yuanshu)
#         example_c_entrys = pqdoc("span.example_c")
#         ol_tag = PyQuery("<ol></ol>")
#         ol_tag.add_class("example_english_sentiment")
#         for example_c_entry in example_c_entrys:
#             li_tag = PyQuery("<li></li>")
#             matches = str_en_zh_split(example_c_entry.text)
#             if matches:
#                 li_tag.text(matches[0])
#                 ol_tag.append(li_tag)
#         if len(ol_tag.children()) != 0:
#             # tags.append("english_sentiment")
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"英文意境": str(ol_tag)},
#                     # "tags": tags,
#                 },
#             )
#             print(
#                 "es",
#                 f"{index+1}/{len(notesInfo)}",
#                 # ol_tag,
#             )

# >>>
# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# mdx = MDX("D:\\Software\\MDictPC\\doc\\Collins\ccald9.mdx")
# headwords = [*mdx]  # 单词名列表
# items = [*mdx.items()]  # 释义html源码列表
# if len(headwords) == len(items):
#     print(f"加载成功：共{len(headwords)}条")
# else:
#     print(f"【ERROR】加载失败{len(headwords)}，{len(items)}")

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     words = fields["word"]["value"]
#     if words.encode() in headwords:
#         word, html = items[headwords.index(words.encode())]
#         word, html = word.decode(), html.decode()
#         if "柯林斯" not in tags and str(html) != "":
#             tags.append("柯林斯9")
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"柯林斯": str(html)},
#                     "tags": tags,
#                 },
#             )
#             print(fields["word"]["value"], "explain", f"{index+1}/{len(notesInfo)}")
#     else:
#         print(f"【未找到单词】：{words}")

# >>>
# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# mdx = MDX("D:/Software/MDictPC/doc/mwa/mwa.mdx")
# headwords = [*mdx]  # 单词名列表
# items = [*mdx.items()]  # 释义html源码列表
# if len(headwords) == len(items):
#     print(f"[TRUE]加载成功：共{len(headwords)}条")
# else:
#     print(f"[ERROR]加载失败{len(headwords)}, {len(items)}")

# # if "pen".encode() in headwords:
# #     word, html = items[headwords.index("pen".encode())]
# #     word, html = word.decode(), html.decode()
# #     pqdoc = PyQuery(html)
# #     explain_entrys = pqdoc(
# #         "div.entry.entry_v2.boxy > div.sblocks > div > div > div > div.sense > div > ul > li:nth-child(-n+2) > div"
# #     )
# #     a = str(explain_entrys)
# #     pass

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     words: str = fields["word"]["value"]
#     if words.encode() in headwords:
#         # and "english_sentiment" not in tags
#         word, html = items[headwords.index(words.encode())]
#         word, html = word.decode(), html.decode()
#         # html = html.replace(r"\\", "")
#         pqdoc = PyQuery(html)
#         example_entrys = pqdoc(
#             "div.entry.entry_v2.boxy > div.sblocks > div > div > div > div.sense > div > ul > li:nth-child(-n+1) > div"
#         )
#         ol_tag = PyQuery("<ol></ol>")
#         ol_tag.add_class("english_sentiment")
#         for example_entry in example_entrys:
#             li_tag = PyQuery("<li></li>")
#             li_tag.append(example_entry)
#             ol_tag.append(li_tag)
#         # a = str(ol_tag)
#         if len(ol_tag.children()) != 0:
#             # if "english_sentiment" not in tags:
#             #     tags.append("english_sentiment")
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"英文意境": str(ol_tag)},
#                     # "tags": tags,
#                 },
#             )
#             print(
#                 f"explain: {len(example_entrys)}",
#                 fields["word"]["value"],
#                 f"{index+1}/{len(notesInfo)}",
#             )
#     else:
#         print(f"【未找到单词】：{words}")
#         # if "english_sentiment" in tags:
#         #     tags.remove("english_sentiment")
#         #     invoke(
#         #         "updateNote",
#         #         note={
#         #             "id": noteId,
#         #             "tags": tags,
#         #         },
#         #     )


# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     words: str = fields["word"]["value"]
#     if fields["柯林斯"]["value"] == "" and "Mdict柯林斯" in tags:
#         tags.remove("Mdict柯林斯")
#         invoke(
#             "updateNote",
#             note={
#                 "id": noteId,
#                 "tags": tags,
#             },
#         )
#         print(fields["word"]["value"], "up tags", f"{index+1}/{len(notesInfo)}")
# if fields["英文意境"]["value"] == "" and "english_sentiment" in tags:
#     tags.remove("english_sentiment")
#     invoke(
#         "updateNote",
#         note={
#             "id": noteId,
#             "tags": tags,
#         },
#     )
#     print(fields["word"]["value"], "up tags", f"{index+1}/{len(notesInfo)}")
# if "explain" in tags:
#     tags.remove("explain")
#     invoke(
#         "updateNote",
#         note={
#             "id": noteId,
#             "tags": tags,
#         },
#     )
#     print(fields["word"]["value"], "up tags", f"{index+1}/{len(notesInfo)}")

# mdx = MDX("D:/Software/MDictPC/doc/ode_glance/ode_glance.mdx")
# headwords = [*mdx]  # 单词名列表
# items = [*mdx.items()]  # 释义html源码列表
# if len(headwords) == len(items):
#     print(f"[TRUE]加载成功：共{len(headwords)}条")
# else:
#     print(f"[ERROR]加载失败{len(headwords)}, {len(items)}")


# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     word = fields["word"]["value"]
#     if "english_sentiment" not in tags and "english_sentiment_tidme" not in tags:
#         ol_tag = PyQuery("<ol></ol>")
#         ol_tag.add_class("english_sentiment")
#         exams = download_cambridge_words_exam(word)
#         if len(exams) != 0:
#             for en, zh in exams:
#                 div_tag = PyQuery("<div></div>")
#                 div_tag.add_class("vi_content")
#                 span_tag = PyQuery("<span></span>")
#                 span_tag.add_class("mw_zh")
#                 li_tag = PyQuery("<li></li>")
#                 span_tag.text(zh)
#                 div_tag.html(en + str(span_tag))
#                 li_tag.append(div_tag)
#                 ol_tag.append(li_tag)
#         else:
#             continue
#         a = str(ol_tag)
#         if len(ol_tag.children()) != 0:
#             tags.append("english_sentiment_cambridge")
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"英文意境": str(ol_tag)},
#                     "tags": tags,
#                 },
#             )
#             print("es", f"{index+1}/{len(notesInfo)}")



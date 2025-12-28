# import pandas as pd

# from supermemo_toolkit.utilscripts.ankinet import download_word_sound
from supermemo_toolkit.utilscripts.ankinet import invoke

# https://pypandas.cn/docs/getting_started/overview.html
#      大类          子类                                                 单词
# 0  具体名词  有关物的名词-时间类  time morning afternoon noon evening night toni...
# 1  具体名词  有关物的名词-气候类                       weather rain snow wind cloud
# 2  具体名词  有关物的名词-自然类  nature mountain air light water fire ice smoke...

# df = pd.read_excel(
#     "D:/Develop/repo/SuperMemo-Toolkit/tests/anki/1368/1368.xlsx", sheet_name="Sheet1"
# )
# print(df.head(3))
note_id_list = invoke("findNotes", query="deck:1368个单词就够了")
notesInfo = invoke("notesInfo", notes=note_id_list)

# for index, row in df.iterrows():
#     m_class = row["大类"]
#     m_sub_class = row["子类"]
#     word = row["单词"].split(" ")
#     deckName = f"1368::{m_class}"
#     invoke("createDeck", deck=deckName)
#     for item in word:
#         invoke(
#             "addNote",
#             note={
#                 "deckName": deckName,
#                 "modelName": "1368",
#                 "fields": {"单词": item, "大类": m_class, "小类": m_sub_class},
#                 "options": {
#                     "allowDuplicate": False,
#                     "duplicateScope": "deck",
#                     "duplicateScopeOptions": {
#                         "deckName": "Default",
#                         "checkChildren": False,
#                         "checkAllModels": False,
#                     },
#                 },
#             },
#         )
#         print("add", item)


# for noteInfo in notesInfo:
#     noteId = noteInfo["noteId"]
#     tag = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     word = fields["单词"]["value"]
#     # 下载单词音频
#     (file_name, file_data) = download_word_sound(word, 1)
#     if file_name != "" and file_data != "":
#         # 存储音频到anki
#         result_filename = invoke("storeMediaFile", filename=file_name, data=file_data)
#         if result_filename:
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"音频": f"[sound:{result_filename}]"},
#                 },
#             )
#             print(noteId, result_filename)


# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     a = fields["大类"]["value"]
#     b = fields["小类"]["value"].split("-")[0]
#     deck = f"1368个单词就够了::{a}::{b}"
#     invoke("changeDeck", cards=[noteId], deck=deck)
#     # invoke(
#     #     "updateNote",
#     #     note={"id": noteId, "tags": []},
#     # )
#     print(fields["单词"]["value"], f"{index + 1}/{len(notesInfo)}")


notesInfoMap = {
    noteInfo["fields"]["单词"]["value"]: noteInfo["noteId"]
    for noteInfo in invoke(
        "notesInfo", notes=invoke("findNotes", query="deck:26意境语义红宝石")
    )
}

for noteInfo in notesInfo:
    noteId = noteInfo["noteId"]
    tag = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["单词"]["value"]
    if word in notesInfoMap:
        # 获取id对应卡片的数据，写入到这个卡片中
        m_noteInfo = invoke("notesInfo", notes=[notesInfoMap[word]])[0]
        m_fields = m_noteInfo["fields"]
        us = m_fields["US"]["value"]
        uk = m_fields["UK"]["value"]
        sy = m_fields["释义"]["value"]
        yj = m_fields["语音音节"]["value"]
        # US、UK、释义、音节
        invoke(
            "updateNote",
            note={
                "id": noteId,
                "fields": {
                    "US": us,
                    "UK": uk,
                    "释义": sy,
                    "音节": yj,
                },
            },
        )
        print(word)

import os
import sys
import pandas as pd

sys.path.insert(0, os.path.normpath(sys.path[0] + "/../"))
from main import invoke  # noqa: E402

# https://pypandas.cn/docs/getting_started/overview.html#%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84
# | 维数  | 名称        | 描述                |
# | --- | --------- | ----------------- |
# | 1   | Series    | 带标签的一维同构数组        |
# | 2   | DataFrame | 带标签的，大小可变的，二维异构表格 |

df = pd.read_excel(
    "C:/Users/Snowy/Desktop/柯林斯词典词频分级词汇(1-5星).xlsx", sheet_name="1星-7623"
)
# word_list = df.iloc[:, 0].to_dict()
word_list = df.iloc[:, 0].to_list()
word_list = [x.strip() for x in word_list if isinstance(x, str)]


note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    if word in word_list:
        invoke(
            "updateNote",
            note={
                "id": noteId,
                "fields": {"重要程度": "1"},
            },
        )
        print(word, f"{index+1}/{len(notesInfo)}")

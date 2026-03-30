import json
import os
from supermemo_toolkit.utilscripts.ankinet import invoke
import numpy as np
from gensim.models import KeyedVectors

base_dir = os.path.expanduser("~/gensim-data")
counter_fitted_path = os.path.join(base_dir, "counter-fitted.kv")
fasttext_wiki_news_300_path = os.path.join(base_dir, "fasttext-wiki-news-300")
ft = KeyedVectors.load(counter_fitted_path, mmap="r")


def is_synonym(w1: str, w2: str, threshold: float = 0.65) -> tuple[bool, float]:
    """
    Counter-fitted 向量天然区分同义词和反义词：
    - 同义词 cos ≈ 0.6~0.9
    - 反义词 cos ≈ -0.3~0.2
    - 相关非同义 cos ≈ 0.2~0.5
    """
    if w1 not in ft or w2 not in ft:
        return False, 0.0
    v1, v2 = ft[w1], ft[w2]
    cos = float(np.dot(v1, v2) / (np.linalg.norm(v1) * np.linalg.norm(v2)))
    return cos >= threshold, cos


# ========== 4. 测试 ==========

# words = [
#     str(noteInfo["fields"]["orderKey"]["value"]).lower()
#     for noteInfo in invoke(
#         "notesInfo", notes=invoke("findNotes", query="deck:01意境语义红宝石")
#     )
# ]
# lines = []
# for idx, w1 in enumerate(words):
#     for w2 in words:
#         if w1 == w2:
#             continue
#         flag, score = is_synonym(w1, w2)
#         if flag:
#             line = f"{idx + 1},{w1},{w2},{score}\n"
#             lines.append(line)
#             print(line, end="")
# with open("synonym_words.csv", "w+", encoding="utf-8", newline="") as f:
#     f.writelines(lines)

# 表格处理后写入anki
with open("order_synonym_words.csv", "r+", encoding="utf-8") as f:
    lines = f.readlines()
synonym_words = {}
for line in lines[1:]:
    w1, w2, _ = line.split(",")
    if w1 not in synonym_words:
        synonym_words[w1] = [w2]
    else:
        synonym_words[w1].append(w2)
head3_synonym_words = {}
for w1, w2_list in synonym_words.items():
    head3_synonym_words[w1] = w2_list[:3]
note_id_list = invoke("findNotes", query="deck:01意境语义红宝石")
notesInfo = invoke("notesInfo", notes=note_id_list)
for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    fields = noteInfo["fields"]
    word = fields["orderKey"]["value"]
    invoke(
        "updateNote",
        note={
            "id": noteId,
            "fields": {"同义词": ""},
        },
    )
    if word in head3_synonym_words:
        tyc = ", ".join(head3_synonym_words.get(word))
        invoke(
            "updateNote",
            note={
                "id": noteId,
                "fields": {"同义词": tyc},
            },
        )
        print(f"{index + 1} / {len(notesInfo)}  {tyc}")

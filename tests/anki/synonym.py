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

words = [
    str(noteInfo["fields"]["orderKey"]["value"]).lower()
    for noteInfo in invoke(
        "notesInfo", notes=invoke("findNotes", query="deck:01意境语义红宝石")
    )
]
synonym_words = {}
for idx, w1 in enumerate(words):
    for w2 in words:
        if w1 == w2:
            continue
        flag, score = is_synonym(w1, w2)
        if flag:
            print(
                f"{idx + 1}\t{w1:<12} {w2:<12} | {'YES' if flag else 'NO':^6} | {score:+.4f}"
            )
            if w1 not in synonym_words:
                synonym_words[w1] = [w2]
            else:
                synonym_words[w1].append(w2)
with open("synonym_words.json", "w+", encoding="utf-8") as f:
    f.write(json.dumps(synonym_words, ensure_ascii=False, indent=4))

# 改写为表格
# lines = []
# for w1, words in synonym_words.items():
#     lines.extend(",".join([w1] + [w2 for w2 in words]))
# with open("synonym_words.csv", "w+", encoding="utf-8", newline="") as f:
#     f.writelines(lines)

# 表格处理后重写
# with open("synonym_words.csv", "r+", encoding="utf-8") as f:
#     lines = f.readlines()
# synonym_words = {}
# for line in lines:
#     w1, w2 = line.split(",")
#     if w1 not in synonym_words:
#         synonym_words[w1] = [w2]
#     else:
#         synonym_words[w1].append(w2)
# with open("synonym_words.json", "w+", encoding="utf-8") as f:
#     f.write(json.dumps(synonym_words, ensure_ascii=False, indent=4))

import Levenshtein
import pandas as pd
import json
from metaphone import doublemetaphone  # pip install metaphone
from supermemo_toolkit.utilscripts.ankinet import invoke


"""
    {{#易混词}}
    <div id="homophones">{{易混词}}</div>
    <script>
        if (document.getElementById("homophones")) {
            var hintDiv = document.getElementById("homophones");
            hintDiv.addEventListener("click", function () {
                this.classList.toggle("revealed");
            });
        }
    </script>
    {{/易混词}}
    #homophones {
        background-color: #e8e8e8;
        color: #e8e8e8;
        border-radius: 4px;
        padding: 0 5px;
        cursor: pointer;
        display: inline-block;
        transition: all 0.2s ease;
    }

    #homophones:hover {
        background-color: #d0d0d0;
        color: #d0d0d0;
    }

    #homophones.revealed {
        background-color: transparent;
        color: purple;
        font-size: 1.2rem;
        font-weight: bold;
        cursor: text;
    }

    .nightMode #homophones {
        background-color: #3a3a3a; /* 深灰色背景 */
        color: #3a3a3a; /* 文字同色隐藏 */
    }

    .nightMode #homophones:hover {
        background-color: #555; /* hover 时稍亮 */
        color: #555;
    }

    .nightMode #homophones.revealed {
        background-color: transparent;
        color: #c8a2c8;
        font-size: 1.2rem;
        font-weight: bold;
    }
"""

# 1. 预加载视觉相似度矩阵 (全局加载一次，不要放在函数里)
df_visual = pd.read_excel(
    r"tests/anki/res/Simpsonetal2012-SupplementaryMaterial.xlsx",
    sheet_name="Table-Lower",
)
# 构建字母到索引的映射
cols = df_visual.columns[2:55]
mdi = {v: k for k, v in df_visual.iloc[0, 2:55].to_dict().items()}


def get_visual_confusion_score(word1, word2):
    """
    基于编辑路径计算视觉混淆分。
    分数越低，越容易区分；分数越高，越容易混淆。
    """
    # 获取编辑操作序列: [('replace', 1, 1), ('insert', 2, 2), ...]
    edits = Levenshtein.editops(word1, word2)

    total_score = 0

    for op, i, j in edits:
        if op == "replace":
            # 替换操作：查表看相似度
            c1 = word1[i]
            c2 = word2[j]

            # 如果不在矩阵中，给予中等惩罚
            if c1 not in mdi or c2 not in mdi:
                score = 3.0
            else:
                # 矩阵中数值越大越相似
                score = df_visual.loc[mdi[c1], mdi[c2]]
            total_score += score

        elif op == "insert" or op == "delete":
            # 插入或删除：视觉上少了一块，也是一种混淆。
            # 给予一个固定惩罚值，比如 3.5 (假设满分是7，3.5代表中等混淆度)
            total_score += 3.5

    # 归一化分数：总分数 / 编辑距离长度
    # 如果编辑距离为0，分数为0
    dist = len(edits)
    if dist == 0:
        return 0

    # 混淆密度：单位编辑操作带来的视觉相似度
    # 如果平均分 > 4，说明改动的地方都很像（如 m->rn），极易混淆
    # 如果平均分 < 2，说明改动的地方差异很大（如 a->z），容易区分
    return total_score / dist


def is_phonetic_similar(word1, word2):
    """
    判断发音是否相似
    """
    p1 = doublemetaphone(word1)
    p2 = doublemetaphone(word2)

    # 只要有一个音素匹配就算相似
    if (p1[0] == p2[0]) or (p1[0] == p2[1]) or (p1[1] == p2[0]) or (p1[1] == p2[1]):
        return True
    return False


def print_similar_word_optimized():
    # 单词分布1-3、4-9（最多）、10-12（次多）、12-19
    words = [
        str(noteInfo["fields"]["orderKey"]["value"]).lower()
        for noteInfo in invoke(
            "notesInfo", notes=invoke("findNotes", query="deck:01意境语义红宝石")
        )
    ]

    # 优化：构建一个按长度分组的索引，减少不必要的计算
    len_dict = {}
    for w1 in words:
        len_word = len(w1)
        if len_word not in len_dict:
            len_dict[len_word] = []
        len_dict[len_word].append(w1)

    similarity_words = {}

    # 遍历每个单词
    for idx, w1 in enumerate(words):
        len_word = len(w1)

        # 只检查长度相近的候选词
        candidates = []
        for w_len in range(len_word - 3, len_word + 4):
            if w_len in len_dict:
                candidates.extend(len_dict[w_len])

        for w2 in candidates:
            if w1 == w2:
                continue

            # 1. 快速预筛：编辑距离
            dist = Levenshtein.distance(w1, w2)
            max_len = max(len(w1), len(w2))

            if dist > max_len * 0.3 or dist > 4:
                continue

            # 2. 过滤完全包含的词缀关系
            if (
                w1.startswith(w2)
                or w2.startswith(w1)
                or w1.endswith(w2)
                or w2.endswith(w1)
            ):
                continue

            # ==========================================
            # 新增防御机制：防止长词前缀/后缀替换被误判
            # ==========================================
            # 计算最长公共前缀 (LCP) 和 最长公共后缀 (LCS) 长度
            lcp_len = 0
            for c1, c2 in zip(w1, w2):
                if c1 == c2:
                    lcp_len += 1
                else:
                    break

            lcs_len = 0
            for c1, c2 in zip(reversed(w1), reversed(w2)):
                if c1 == c2:
                    lcs_len += 1
                else:
                    break

            # 如果公共前后缀加起来超过了单词长度的60%，且编辑距离>=2
            # 说明这俩词只是换了前缀或后缀 (如 protection/rejection, broadly/proudly)
            is_affix_swap = (lcp_len + lcs_len) >= max_len * 0.6 and dist >= 2

            # 3. 核心计算：视觉混淆度
            avg_visual_score = get_visual_confusion_score(w1, w2)

            # 如果是换前/后缀的结构，人类极易分辨，强制要求极高的视觉分(4.5)才放过
            if is_affix_swap and avg_visual_score < 4.5:
                continue

            # ==========================================
            # 新增防御机制：防止错误散落在单词各处被误判
            # ==========================================
            edits = Levenshtein.editops(w1, w2)
            diff_indices = set()
            for op, idx1, idx2 in edits:
                diff_indices.add(idx1)
                diff_indices.add(idx2)

            if len(diff_indices) > 1:
                span = max(diff_indices) - min(diff_indices) + 1
                # 如果错误跨度超过了单词长度的40%，说明改动很分散
                if span > max_len * 0.4:
                    # 极度分散的错误，要求极其相似（比如只有 m 和 rn 这种极端情况）
                    if avg_visual_score < 4.8:
                        continue

            # 4. 语音相似度计算
            is_sound_similar = is_phonetic_similar(w1, w2)

            # ==========================================
            # 判定逻辑 (加入长度动态阈值)
            # ==========================================
            # 动态阈值：单词越长，视觉容错率越高，要求的分数应该越严格
            dynamic_vis_threshold = 4.0 + max(0, (max_len - 5) * 0.15)

            is_confusing = False
            reason = ""

            if avg_visual_score >= dynamic_vis_threshold:
                is_confusing = True
                reason = "High Visual Similarity"
            elif avg_visual_score >= 3.5 and is_sound_similar and max_len <= 8:
                # 语音+视觉辅助，但不适用于太长的单词
                is_confusing = True
                reason = "Visual + Phonetic"
            elif dist == 1 and avg_visual_score >= 3.0 and max_len <= 7:
                # 单编辑距离，只对短词生效
                is_confusing = True
                reason = "Single Edit"

            if is_confusing:
                if w1 not in similarity_words:
                    similarity_words[w1] = [w2]
                else:
                    similarity_words[w1].append(w2)
                print(
                    f"{idx}/{len(words)} Found: {w1} <-> {w2} | Reason: {reason} | VisualScore: {avg_visual_score:.2f}"
                )

    # 输出结果
    with open("b.json", "w+", encoding="utf-8") as f:
        f.write(json.dumps(similarity_words, ensure_ascii=False, indent=4))


def sync():
    with open("b.json", "r+", encoding="utf-8") as f:
        db: dict = json.loads(f.read())
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
                "fields": {"易混词": ""},
            },
        )
        if word in db:
            yhc = ", ".join(db.get(word))
            invoke(
                "updateNote",
                note={
                    "id": noteId,
                    "fields": {"易混词": yhc},
                },
            )
            print(f"{index + 1} / {len(notesInfo)}  {yhc}")


print_similar_word_optimized()
# sync()

# import html
import spacy  # 导包
from nltk.stem import PorterStemmer
# import json
# import urllib.request
# from pyquery import PyQuery


nlp = spacy.load("en_core_web_trf")
# nlp = spacy.load("en_core_web_sm")
# 创建 Porter 词干提取器
stemmer = PorterStemmer()


def jaccard_similarity(set1, set2):
    intersection = len(set1 & set2)
    union = len(set1 | set2)
    return intersection / union


# word1 = "apple"
# word2 = "appel"


def cmp_2word(word1, word2):
    if word1 == word2:
        return True
    if jaccard_similarity(set(word1), set(word2)) < 0.75:
        return False
    else:
        # 剩下百分比[80, 100)交给它处理。
        doc1 = nlp(word1)
        doc2 = nlp(word2)
        # 先进行词形还原，若不行再进行词干提取
        if doc1[0].lemma_ == doc2[0].lemma_:
            return True
        elif stemmer.stem(doc1[0].text) == stemmer.stem(doc2[0].text):
            return True
        else:
            return False


# res = cmp_2word("impress", "impressed")
# pass


# def request(action, **params):
#     return {"action": action, "params": params, "version": 6}


# def invoke(action, **params):
#     requestJson = json.dumps(request(action, **params)).encode("utf-8")
#     response = json.load(
#         urllib.request.urlopen(
#             urllib.request.Request("http://127.0.0.1:8765", requestJson)
#         )
#     )
#     if len(response) != 2:
#         raise Exception("response has an unexpected number of fields")
#     if "error" not in response:
#         raise Exception("response is missing required error field")
#     if "result" not in response:
#         raise Exception("response is missing required result field")
#     if response["error"] is not None:
#         raise Exception(response["error"])
#     return response["result"]


# with open("./backup.json", "rb") as f:
#     raw_data = f.read()
#     json_data = json.loads(raw_data)


# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     word = fields["word"]["value"]
#     aabbyy = fields["意境嵌入词义"]["value"]
#     if not aabbyy or aabbyy == "":
#         for item in json_data.values():
#             # 处理文本
#             aabbyy_doc = PyQuery(item).children()
#             for li_tag in aabbyy_doc:
#                 mli = PyQuery(li_tag)
#                 mli("span.mw_zh").remove()
#                 a = str(mli)
#                 doc = nlp(html.unescape(mli.text()))
#                 filtered_sentence = [
#                     token.text
#                     for token in doc
#                     if not nlp.vocab[token.text].is_stop
#                     and not nlp.vocab[token.text].is_punct
#                 ]

#                 # 遍历文档中的词并打印词形还原形式
#                 for token in filtered_sentence:
#                     if cmp_2word(word, token):
#                         # 说明句子中有目标单词。
#                         # 不可行时间太长。
#                         b = str(li_tag)
#                         pass

#         print(f"{index+1}/{len(notesInfo)}")

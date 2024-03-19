import json
import os


def dir_folder(folder):
    file_list = []
    stack = [folder]
    while stack:
        current_path = stack.pop()
        for entry in os.scandir(current_path):
            if entry.is_file():
                file_list.append(entry.path)
            if entry.is_dir():
                stack.append(entry.path)
    return file_list


rconf_path = dir_folder("C:/Users/Snowy/Desktop/mdict")
wconf_path = "C:/Users/Snowy/Desktop/m.json"
m_sentences = dict()
# for rjson_path in rconf_path:
#     with open(rjson_path, "r", encoding="utf-8") as json_file:
#         text: str = json.load(json_file)["text"]
#         tiddlers: dict = json.loads(text)["tiddlers"]
#     for values in tiddlers.values():
#         if "word" in values:
#             word = values["word"]
#             word_json = json.loads(values["word_json"])
#             word_content = word_json["content"]["word"]["content"]
#             if "sentence" in word_content:
#                 sentences = word_content["sentence"]["sentences"]
#             else:
#                 sentences = []
#             if len(sentences) > 0:
#                 if word not in m_sentences:
#                     m_sentences.update({word: sentences})
#                 else:
#                     for item2 in sentences:
#                         if item2 not in m_sentences[word]:
#                             m_sentences[word].append(item2)


for rjson_path in rconf_path:
    with open(rjson_path, "r", encoding="utf-8") as json_file:
        text: str = json.load(json_file)["text"]
        tiddlers: dict = json.loads(text)["tiddlers"]
    for values in tiddlers.values():
        if "word" in values:
            word = values["word"]
            word_json = json.loads(values["word_json"])
            word_json["content"]["word"]["content"]
            word_content = word_json["content"]["word"]["content"]
            if "phrase" in word_content:
                phrases = word_content["phrase"]["phrases"]
            else:
                phrases = []
            if len(phrases) > 0:
                if word not in m_sentences:
                    m_sentences.update({word: phrases})
                else:
                    for item in phrases:
                        if item not in m_sentences[word]:
                            m_sentences[word].append(item)


with open(wconf_path, "w", encoding="utf-8") as json_file:
    json.dump(m_sentences, json_file, indent=4)

pass

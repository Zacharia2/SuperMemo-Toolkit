import json
import os
import re
import urllib.request
from bs4 import BeautifulSoup

def request(action, **params):
    return {"action": action, "params": params, "version": 6}


def invoke(action, **params):
    requestJson = json.dumps(request(action, **params)).encode("utf-8")
    response = json.load(
        urllib.request.urlopen(
            urllib.request.Request("http://127.0.0.1:8765", requestJson)
        )
    )
    if len(response) != 2:
        raise Exception("response has an unexpected number of fields")
    if "error" not in response:
        raise Exception("response is missing required error field")
    if "result" not in response:
        raise Exception("response is missing required result field")
    if response["error"] is not None:
        raise Exception(response["error"])
    return response["result"]


def is_md_ext_file(file_path):
    file_ext = os.path.splitext(file_path)[1].lower()
    return file_ext in [".md"]


def is_start_with_num(path):
    num_partten = r"\d\d"
    basename = os.path.basename(path)
    num = re.findall(num_partten, basename)
    if len(num) > 0 and int(num[0]) > 0:
        return True
    else:
        return False


def iter_dir(folder: str):
    file_list = []
    count_processed = 0

    stack = [folder]
    while stack:
        current_path = stack.pop()
        for entry in os.scandir(current_path):
            if (
                entry.is_file()
                and is_md_ext_file(entry.path)
                and is_start_with_num(entry.path)
            ):
                # 必须是md文件，且文件名称开头首先是数字，其次必须大于1（从01开始）。
                file_list.append(entry.path)
                count_processed += 1
                print(
                    "正在计算文件总数",
                    f"[{count_processed}]",
                    end="\r",
                )
            if entry.is_dir() and is_start_with_num(entry.path):
                stack.append(entry.path)
    print(f"\n共找到 {count_processed} 个文件")
    return file_list


def split_list(split_index: list, target_list: list) -> list:
    # 根据下标分割列表。
    result = list()
    count = 0
    indexs = [0] + split_index + [len(target_list)]
    for index, item in enumerate(indexs):
        # 分割次数 = 索引刀 + 1
        if count < len(split_index) + 1:
            result.append(target_list[indexs[index] : indexs[index + 1]])
            count += 1
    return result


def read_file(path_list):
    result_dict = dict()
    for path in path_list:
        RText = "D:/Dropbox/00-TMP/英语词义分类数据库（大学版）（带词汇表目录）/英语词义分类数据库（大学版）"
        class_path = path.split(RText)[1].split(".")[0].replace("\\", "/")
        with open(path, "r", encoding="utf-8") as f:
            origin_list = f.readlines()

        # 过滤列表
        filter_list = list()
        for item in origin_list:
            if re.search(r"class", item) is not None:
                filter_list.append(item)

        # Step 分割 Categorys
        index_category = list()
        for aindex, item in enumerate(filter_list):
            if "category" in item and aindex != 0:
                index_category.append(aindex)
        categorys = split_list(index_category, filter_list)

        # Step 分割 Vocabulary
        index_vocabulary = list()
        vocabulary_list = list()
        for category in categorys:
            for bindex, item in enumerate(category):
                if "vocabulary" in item and bindex != 0:
                    index_vocabulary.append(bindex)
            vocabulary = split_list(index_vocabulary, category)
            vocabulary_list.append(vocabulary)
            index_vocabulary.clear()

        # Start
        for category in vocabulary_list:
            for word_content in category:
                a_category: str
                if len(word_content) == 1 and "category" in word_content[0]:
                    soup = BeautifulSoup(word_content[0], "html.parser")
                    a_category = re.findall(r"\*\*(.*?)\*\*", soup.get_text())
                    if a_category is not None and a_category != []:
                        a_category = a_category[0].replace("：", "")
                    if a_category == []:
                        a_category = ""
                if len(word_content) == 2 and "vocabulary" in word_content[0]:
                    soup = BeautifulSoup(word_content[0], "html.parser")
                    index_word = re.findall(r"\*\*(.*?)\*\*", soup.get_text())[0]
                    cpath: str = class_path + "/" + a_category
                    # if a_voc in result_dict.keys():
                    #     result_dict[a_voc].append(((cpath, voc)))
                    # else:
                    #     result_dict.update({a_voc: [(cpath, voc)]})
                    # print(cpath + a_voc)
                    ankipath = cpath[1:].replace("/", "::")
                    if ankipath in result_dict.keys():
                        result_dict[ankipath].append((index_word, word_content))
                    else:
                        result_dict.update({ankipath: [(index_word, word_content)]})
                    print(ankipath + index_word)
    return result_dict


# mdict = read_file(
#     iter_dir(
#         "D:/Dropbox/00-TMP/英语词义分类数据库（大学版）（带词汇表目录）/英语词义分类数据库（大学版）"
#     )
# )


# mdict_bytes = json.dumps(mdict, ensure_ascii=False).encode()
# with open("./mdict.json", "wb") as f:
#     f.write(mdict_bytes)

with open("./mdict.json", "rb") as f:
    raw_data = f.read()
    json_data = json.loads(raw_data)

genid = 1
for key, value in json_data.items():
    for item in value:
        if len(item[1]) != 2:
            item[1].append("")
        if len(item[1]) != 3:
            item[1].append("")
        invoke("createDeck", deck=f"词义分类::{key}")
        invoke(
            "addNote",
            note={
                "deckName": f"词义分类::{key}",
                "modelName": "词义分类",
                "fields": {
                    "genid": f"{genid:06d}",
                    "class": key,
                    "word": item[0],
                    "field1": item[1][0],
                    "field2": item[1][1],
                    "field3": item[1][2],
                },
                # "options": {
                #     "allowDuplicate": True,
                #     "duplicateScope": f"词义分类::{key}",
                # },
            },
        )
        genid += 1
        print(key)


# note_id_list = invoke("findNotes", query="deck:词义分类")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     word = fields["word"]["value"]
#     invoke(
#         "updateNote",
#         note={
#             "id": noteId,
#             "fields": {"重要程度": "1"},
#         },
#     )
#     print(word, f"{index+1}/{len(notesInfo)}")

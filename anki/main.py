import base64
import hashlib
import json
import urllib.request
from bs4 import BeautifulSoup

import requests
import filetype

# import semantic_classification as sc

# path_list = sc.iter_dir(
#     "D:/Dropbox/00-TMP/英语词义分类数据库（大学版）（带词汇表目录）/英语词义分类数据库（大学版）"
# )
# mdict = sc.read_file(path_list)


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


# invoke("createDeck", deck="test1")
# result = invoke("deckNames")
# print(f"got list of decks: {result}")
# class = resultsSet、dictionary-entry-2
# <span class="HYPHENATION" _mstmutation="1">dic‧tion‧a‧ry</span>
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/121.0.0.0 Safari/537.36 Edg/121.0.0.0",
}


def download_words(words: str, us_or_uk: int):
    # usoruk=int(1.us or 2.uk)
    audio_mime = {
        "audio/aac": "aac",
        "audio/midi": "mid",
        "audio/mpeg": "mp3",
        "audio/mp3": "mp3",
        "audio/mp4": "m4a",
        "audio/ogg": "ogg",
        "audio/x-flac": "flac",
        "audio/x-wav": "wav",
        "audio/amr": "amr",
        "audio/x-aiff": "aiff",
    }
    try:
        url = f"https://dict.youdao.com/dictvoice?audio={words}&type={us_or_uk}"
        sha1_hash = hashlib.sha1()
        response = requests.get(url, stream=True, headers=headers)
        content_type = response.headers.get("content-type")
        # Read and update hash in chunks of 4K
        for byte_block in [
            response.content[i : i + 4096]
            for i in range(0, len(response.content), 4096)
        ]:
            sha1_hash.update(byte_block)
        if b'{"code": 403}' not in response.content:
            if content_type:
                file_name = (
                    f"youdao-{words}-{sha1_hash.hexdigest()}.{audio_mime[content_type]}"
                )
            else:
                try:
                    audio_kind = filetype.guess(response.content)
                    file_name = f"youdao-{words}-{sha1_hash.hexdigest()}.{audio_mime[audio_kind.mime]}"
                except Exception:
                    print(f"{words} 未下载！")
            return (file_name, base64.b64encode(response.content).decode())
        else:
            return None
    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
    except ValueError as e:
        print("响应解析异常: ", e)


def updata_segmentation_of_word(words):
    try:
        url = f"https://www.ldoceonline.com/dictionary/{words}"
        soup = BeautifulSoup(
            requests.get(url, stream=True, headers=headers).text, "html.parser"
        )
        # 注意是class_，不是class，因为class是python的关键字，所以后面要加个尾巴，防止冲突
        seg = soup.find("span", class_="HYPHENATION")
        if seg:
            text = seg.getText()
            return text
    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
    except ValueError as e:
        print("响应解析异常: ", e)


def download_words_explain(words: str):
    try:
        url = f"https://www.oed.com/search/dictionary/?scope=Entries&q={words}"
        response = requests.get(url, stream=True, headers=headers)
        soup = BeautifulSoup(response.text, "html.parser")
        explain_resultsSet = soup.find_all("div", class_="resultsSet")
        for explain in explain_resultsSet:
            resultsSetItemBody: list = explain.findAll(
                "div", class_="resultsSetItemBody"
            )
            for item in resultsSetItemBody:
                link = item.find("a")
                del link.attrs["href"]
            explain_words = "<b></b>".join(resultsSetItemBody)
            # print(explain_words)
            if resultsSetItemBody:
                return explain_words
    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
    except ValueError as e:
        print("响应解析异常: ", e)


def cmp_field(query_, key1, key2):
    note_id_list = invoke("findNotes", query=query_)
    notesInfo = invoke("notesInfo", notes=note_id_list)
    for noteInfo in notesInfo:
        # noteId = noteInfo["noteId"]
        # tag = noteInfo["tags"]
        fields = noteInfo["fields"]
        if fields[key1]["value"] != fields[key2]["value"]:
            print(fields[key1]["value"], "::", fields[key2]["value"])


# note_id_list = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for noteInfo in notesInfo:
#     noteId = noteInfo["noteId"]
#     tag = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if tag == ["缺失媒体文件"]:
#         # 下载单词音频
#         (word, data) = download_words(fields["单词"]["value"], 1)
#         # 存储音频到anki
#         result_filename = invoke("storeMediaFile", filename=word, data=data)
#         if result_filename:
#             # 更新笔记
#             anki_audio_value = f"[sound:{result_filename}]"
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"单词音频": anki_audio_value},
#                     "tags": [],
#                 },
#             )
#             print(noteId, result_filename)


# note_id_list = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for noteInfo in notesInfo:
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if "explain" not in tags:
#         explain = download_words_explain(fields["word"]["value"])
#         if explain:
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"英英释义": explain},
#                     "tags": ["explain"],
#                 },
#             )
#             print(fields["word"]["value"], "explain")

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

# note_id_list = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for noteInfo in notesInfo:
#     noteId = noteInfo["noteId"]
#     # tag = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if fields["word"]["value"] != fields["单词"]["value"]:
#         (word, data) = download_words(fields["word"]["value"], 1)
#         # 存储音频到anki
#         result_filename = invoke("storeMediaFile", filename=word, data=data)
#         if result_filename:
#             # 更新笔记
#             anki_audio_value = f"[sound:{result_filename}]"
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"单词音频": anki_audio_value},
#                 },
#             )
#             print(
#                 noteId,
#                 result_filename,
#                 fields["单词"]["value"] + "::" + fields["word"]["value"],
#             )

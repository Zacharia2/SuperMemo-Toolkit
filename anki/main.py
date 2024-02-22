import base64
import hashlib
import json
import urllib.request

import requests
import filetype


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
        response = requests.get(url, stream=True)
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


note_id_list = invoke(
    "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
)
notesInfo = invoke("notesInfo", notes=note_id_list)
for noteInfo in notesInfo:
    noteId = noteInfo["noteId"]
    tag = noteInfo["tags"]
    fields = noteInfo["fields"]
    if tag == ["缺失媒体文件"]:
        # 下载单词音频
        (word, data) = download_words(fields["单词"]["value"], 1)
        # 存储音频到anki
        result_filename = invoke("storeMediaFile", filename=word, data=data)
        if result_filename:
            # 更新笔记
            anki_audio_value = f"[sound:{result_filename}]"
            invoke(
                "updateNote",
                note={
                    "id": noteId,
                    "fields": {"单词音频": anki_audio_value},
                    "tags": [],
                },
            )
            print(noteId, result_filename)

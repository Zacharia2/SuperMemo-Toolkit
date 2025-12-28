import base64
import hashlib
import json
import urllib.request

import filetype
import requests
from bs4 import BeautifulSoup
from pyquery import PyQuery

# from readmdict import MDX


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


def str_en_zh_split(mstring: str):
    for i, s in enumerate(mstring):
        if not s.isascii():
            return (mstring[:i], mstring[i:])


def backward_erasure(onelist: list, savelen: int) -> list:
    """
    给一个列表, 从后往前删除, 并保留前savelen个。
    """
    mindex = len(onelist) - 1
    for i in range(mindex, -1, -1):
        llen = i + 1
        if llen <= savelen:
            break
        del onelist[i]
    return onelist


# a = str_en_zh_split(
#     "The hotel guests tried their best to ~ from the burning building.旅客们奋力从燃烧的大楼中逃出来。"
# )
# b = str_en_zh_split("The thief jumped into a car and made his ~.小偷跳上汽车逃走了。")
# invoke("createDeck", deck="test1")
# result = invoke("deckNames")
# print(f"got list of decks: {result}")
# class = resultsSet、dictionary-entry-2
# <span class="HYPHENATION" _mstmutation="1">dic‧tion‧a‧ry</span>
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/122.0.0.0 Safari/537.36 Edg/122.0.0.0",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
}


def download_word_sound(target_word: str, us_or_uk: int):
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
        url = f"https://dict.youdao.com/dictvoice?audio={target_word}&type={us_or_uk}"
        sha1_hash = hashlib.sha1()
        response = requests.get(url, stream=True, headers=headers)
        content_type = response.headers.get("content-type")
        content = response.content
        # Read and update hash in chunks of 4K
        for byte_block in [content[i : i + 4096] for i in range(0, len(content), 4096)]:
            sha1_hash.update(byte_block)
        if b'{"code": 403}' not in content:
            # 判断文件类型生成文件名。
            if content_type:
                file_name = f"youdao-{target_word}-{sha1_hash.hexdigest()[:8]}.{audio_mime[content_type]}"
            else:
                try:
                    audio_kind = filetype.guess(content)
                    file_name = f"youdao-{target_word}-{sha1_hash.hexdigest()[:8]}.{audio_mime[audio_kind.mime]}"
                except Exception:
                    print(f"{target_word} 未下载！")
            return (file_name, base64.b64encode(content).decode())
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


def updata_segmentation_of_word(words: str):
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


def download_oed_word_explain(words: str):
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


# dictionary / ldoceEntry Entry / Sense / DEF


# <style>
# .dsense_h,.ddef_block {padding-left: 10px;padding-right: 10px;}
# .dsense_h {margin-bottom: 12px;padding-top: 10px;color: #5d2fc1;font-size: 1rem;font-weight: 700;}
# .dexamp {position: relative;padding-left: 12px;display: block;}
# .dexamp::before {content: "•";position: absolute;top: 0;left: 0;}
# .def {line-height: 24px;font-size: 18px;}
# .dxref {margin-right: 3px;padding: 2px 6px;color: #fff;font-weight: 700;font-size: .75rem;text-align: center;background-color: #1d2956;border-radius: 50px;}
# .ddef_d {margin-top: 10px;font-size: 18px;line-height: 1.5;display: block;}
# .db {font-weight: 700;}
# .ddef_b {margin-bottom: 20px;font-size: 18px;}
# </style>
def download_cambridge_words_explain(words: str):
    # https://dictionary.cambridge.org/dictionary/learner-english/entertain
    try:
        url = f"https://dictionary.cambridge.org/dictionary/learner-english/{words}"
        response = requests.get(url, stream=True, headers=headers)
        soup = BeautifulSoup(response.text, "html.parser")
        explain_entry = soup.find_all("div", class_="entry")
        # 仅一个entry
        for explain in explain_entry:
            script_tags = explain.find_all("script")
            ad_ringlinkslot = explain.find_all("div", id="ad_ringlinkslot")
            del_tags = script_tags + ad_ringlinkslot
            for del_tag in del_tags:
                del_tag.decompose()
            pos_body = explain.find("div", class_="pos-body")
            if pos_body:
                # for pr in pos_body:
                # dsense_h = pr_dsense.find("h3", class_="dsense_h").getText().strip()
                # dsense_b = pos_body.find("div", class_="sense-body dsense_b")
                dwl_hax = pos_body.find("div", class_="dwl hax")
                dwl_hax.replace_with("", soup.new_tag("hr"))
                return str(pos_body)
    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
    except ValueError as e:
        print("响应解析异常: ", e)


def download_youdao_word_uk(word: str):
    try:
        url = f"https://dict.youdao.com/result?word={word}&lang=en"
        response = requests.get(url, stream=True, headers=headers)
        pqdoc = PyQuery(response.text)
        span_uk = pqdoc(".phone_con")
        per_phone = span_uk(".per-phone")
        for item in per_phone:
            phonetic = PyQuery(item)
            if "英" in phonetic.html():
                phonetic = str(phonetic(".phonetic").text())
                if phonetic and phonetic != "":
                    return phonetic
        # pron = str(span_uk("span.pron.dpron").text())

    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
    except ValueError as e:
        print("响应解析异常: ", e)
    pass


#  div.pos-body > div > div.sense-body.dsense_b > div > div.def-body.ddef_b > div:nth-child(-n+1)
def download_cambridge_words_exam(words: str):
    # https://dictionary.cambridge.org/dictionary/english-chinese-simplified/review
    try:
        url = f"https://dictionary.cambridge.org/dictionary/english-chinese-simplified/{words}"
        response = requests.get(url, stream=True, headers=headers)
        pqdoc = PyQuery(response.text)
        exam_entrys = pqdoc(
            "div.pos-body > div > div.sense-body.dsense_b > div > div.def-body.ddef_b > div:nth-child(-n+2)"
        )
        result = []
        # for exam in exam_entrys:
        #     py_zh = exam.find_class("trans")
        #     if len(py_zh) == 0:
        #         exam_entrys.remove(exam)
        for exam in exam_entrys:
            exam = PyQuery(exam)
            # text = str(exam)
            en = exam("span.eg.deg").text()
            zh = exam("span.trans.dtrans.dtrans-se").text()
            if zh == "":
                continue
            else:
                result.append((en, zh))
        return result
    except requests.exceptions.ConnectionError as e:
        print("网络连接异常: ", e)
    except requests.exceptions.Timeout as e:
        print("连接超时: ", e)
    except requests.exceptions.HTTPError as e:
        print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
    except ValueError as e:
        print("响应解析异常: ", e)


# c = download_cambridge_words_exam("review")
# pass

# def download_collins_words_explain(words: str):
# # https://www.collinsdictionary.com/dictionary/english/discuss
# try:
#     url = f"https://www.collinsdictionary.com/dictionary/english/{words}"
#     session = requests.Session()
#     response = session.get(url, stream=True, headers=headers)
#     if response.status_code != 403:
#         pqdoc = PyQuery(response.text)
#         explain_entrys = pqdoc(
#             f"#{words}__1 > div.content.definitions.cobuild.br > div.hom"
#         )
#         # 删除广告以及多余内容
#         explain_entrys(".thes").remove()
#         explain_entrys(".mpuslot_b-container").remove()
#         explain_entrys("img").remove()
#         return str(explain_entrys)
#     else:
#         print("code: 403")
#         return None
# except requests.exceptions.ConnectionError as e:
#     print("网络连接异常: ", e)
# except requests.exceptions.Timeout as e:
#     print("连接超时: ", e)
# except requests.exceptions.HTTPError as e:
#     print(f"HTTP错误, 状态码: {e.response.status_code}, {e}")
# except ValueError as e:
#     print("响应解析异常: ", e)

# 查词，返回单词和html文件


def cmp_field(query_, key1, key2):
    note_id_list = invoke("findNotes", query=query_)
    notesInfo = invoke("notesInfo", notes=note_id_list)
    for noteInfo in notesInfo:
        # noteId = noteInfo["noteId"]
        # tag = noteInfo["tags"]
        fields = noteInfo["fields"]
        if fields[key1]["value"] != fields[key2]["value"]:
            print(fields[key1]["value"], "::", fields[key2]["value"])


# path_list = sc.iter_dir(
#     "D:/Dropbox/00-TMP/英语词义分类数据库（大学版）（带词汇表目录）/英语词义分类数据库（大学版）"
# )
# mdict = sc.read_file(path_list)

# def u_mdx(path:str):
#     mdx = MDX(path)
#     headwords = [*mdx]  # 单词名列表
#     items = [*mdx.items()]  # 释义html源码列表
#     if len(headwords) == len(items):
#         print(f"加载成功：共{len(headwords)}条")
#     else:
#         print(f"【ERROR】加载失败{len(headwords)}，{len(items)}")
#     return headwords,items

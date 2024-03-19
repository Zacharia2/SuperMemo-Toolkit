import base64
import hashlib
import json

import urllib.request
from bs4 import BeautifulSoup

import requests
import filetype

from pyquery import PyQuery
from readmdict import MDX

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


def str_en_zh_split(mstring: str):
    for i, s in enumerate(mstring):
        if not s.isascii():
            return (mstring[:i], mstring[i:])


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
        content = response.content
        # Read and update hash in chunks of 4K
        for byte_block in [content[i : i + 4096] for i in range(0, len(content), 4096)]:
            sha1_hash.update(byte_block)
        if b'{"code": 403}' not in content:
            if content_type:
                file_name = (
                    f"youdao-{words}-{sha1_hash.hexdigest()}.{audio_mime[content_type]}"
                )
            else:
                try:
                    audio_kind = filetype.guess(content)
                    file_name = f"youdao-{words}-{sha1_hash.hexdigest()}.{audio_mime[audio_kind.mime]}"
                except Exception:
                    print(f"{words} 未下载！")
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


def updata_segmentation_of_words(words: str):
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


def download_oed_words_explain(words: str):
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
            text = str(exam)
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


# >>>
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
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if "剑桥LE" not in tags:
#         explain = download_cambridge_words_explain(fields["word"]["value"])
#         if explain:
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"剑桥LE英英释义": explain},
#                     "tags": ["剑桥LE"],
#                 },
#             )
#             print(fields["word"]["value"], "explain", f"{index+1}/{len(notesInfo)}")

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

# note_id_list1 = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo1 = invoke("notesInfo", notes=note_id_list1)

# words = dict()
# for noteInfo in notesInfo1:
#     words.update({noteInfo["fields"]["word"]["value"]: noteInfo["noteId"]})

# >>>
# note_id_list2 = invoke("findNotes", query="deck:Anki创享岛-2024恋练有词")
# notesInfo2 = invoke("notesInfo", notes=note_id_list2)
# wait_list = dict()
# for index, noteInfo in enumerate(notesInfo2):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if fields["英"]["value"] not in words:
#         yin = fields["音"]["value"]
#         yi = fields["译"]["value"]
#         zu = fields["组"]["value"].replace(" ","-")
#         wait_list.update({fields["英"]["value"]: (yin, yi, zu)})

# for word, tup in wait_list.items():
#     (yin, yi, zu) = tup
#     invoke(
#         "addNote",
#         note={
#             "deckName": "2024红宝书考研词汇（必考词+基础词+超纲词）::D - 扩展词",
#             "modelName": "新模板 6.0",
#             "fields": {
#                 "word": word,
#                 "单词": word,
#                 "US": yin,
#                 "释义": yi,
#             },
#             "options": {
#                 "allowDuplicate": False,
#                 "duplicateScope": "deck",
#                 "duplicateScopeOptions": {
#                     "deckName": "Default",
#                     "checkChildren": False,
#                     "checkAllModels": False,
#                 },
#             },
#             "tags": ["2024恋练有词", zu],
#         },
#     )
#     print(word, "add")


# pass
# >>>
# note_id_list = invoke(
#     "findNotes", query="deck:2024红宝书考研词汇（必考词+基础词+超纲词）"
# )
# notesInfo = invoke("notesInfo", notes=note_id_list)
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     if "剑桥LE" not in tags:
#         explain = download_cambridge_words_explain(fields["word"]["value"])
#         if explain:
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"剑桥LE英英释义": explain},
#                     "tags": ["剑桥LE"],
#                 },
#             )
#             print(fields["word"]["value"], "explain", f"{index+1}/{len(notesInfo)}")


# >>> download_collins_words_explain
# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# mdx = MDX("D:\\Software\\MDictPC\\doc\\Collins\ccald9.mdx")
# headwords = [*mdx]  # 单词名列表
# items = [*mdx.items()]  # 释义html源码列表
# if len(headwords) == len(items):
#     print(f"加载成功：共{len(headwords)}条")
# else:
#     print(f"【ERROR】加载失败{len(headwords)}，{len(items)}")

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     words = fields["word"]["value"]
#     if words.encode() in headwords:
#         word, html = items[headwords.index(words.encode())]
#         word, html = word.decode(), html.decode()
#         pqdoc = PyQuery(html)
#         explain_entrys = pqdoc("div > div.cobuild > div.definitions")
#         for a_tag in explain_entrys("div.def > a"):
#             # 创建一个新的<u>标签，并将<a>标签的文本内容赋值给它
#             span_tag = PyQuery("<span></span>")
#             span_tag.attr["class"] = a_tag.attrib["class"]
#             span_tag.text(a_tag.text)
#             explain_entrys(a_tag).replaceWith(span_tag)
#         a_hwd_sound_mdd = explain_entrys("a.hwd_sound")
#         a_tag_html = [
#             PyQuery(a_tag).html()
#             for a_tag in a_hwd_sound_mdd
#             if PyQuery(a_tag).html() != ""
#         ]
#         for a_tag in a_hwd_sound_mdd:
#             if PyQuery(a_tag).html() == "":
#                 a_hwd_sound_mdd(a_tag).remove()
#         # 如果a标签没有内容就啥也不做，反之去掉标签a。
#         if len(a_tag_html) > 0:
#             for index, a_tag in enumerate(a_hwd_sound_mdd):
#                 sub = a_tag_html[index]
#                 explain_entrys(a_tag).replaceWith(PyQuery(sub))
#             # PyQuery有定义__str__魔法方法，当试图将一个对象转换为字符串时会调用此方法。
#         explain = str(explain_entrys)
#         invoke(
#             "updateNote",
#             note={
#                 "id": noteId,
#                 "fields": {"柯林斯": explain},
#                 # "tags": tags,
#             },
#         )
#         print(fields["word"]["value"], "explain", f"{index+1}/{len(notesInfo)}")
#     else:
#         print(f"【未找到单词】：{words}")
#     # if "柯林斯" not in tags:
#     # tags.append("柯林斯")
#     # if "Mdict柯林斯" in tags:
#     #     tags.remove("Mdict柯林斯")

# >>>
# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     yuanshu = fields["原书"]["value"]
#     if yuanshu != "" and "english_sentiment" in tags:
#         pqdoc = PyQuery(yuanshu)
#         example_c_entrys = pqdoc("span.example_c")
#         ol_tag = PyQuery("<ol></ol>")
#         ol_tag.add_class("example_english_sentiment")
#         for example_c_entry in example_c_entrys:
#             li_tag = PyQuery("<li></li>")
#             matches = str_en_zh_split(example_c_entry.text)
#             if matches:
#                 li_tag.text(matches[0])
#                 ol_tag.append(li_tag)
#         if len(ol_tag.children()) != 0:
#             # tags.append("english_sentiment")
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"英文意境": str(ol_tag)},
#                     # "tags": tags,
#                 },
#             )
#             print(
#                 "es",
#                 f"{index+1}/{len(notesInfo)}",
#                 # ol_tag,
#             )

# >>>
# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# mdx = MDX("D:\\Software\\MDictPC\\doc\\Collins\ccald9.mdx")
# headwords = [*mdx]  # 单词名列表
# items = [*mdx.items()]  # 释义html源码列表
# if len(headwords) == len(items):
#     print(f"加载成功：共{len(headwords)}条")
# else:
#     print(f"【ERROR】加载失败{len(headwords)}，{len(items)}")

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     words = fields["word"]["value"]
#     if words.encode() in headwords:
#         word, html = items[headwords.index(words.encode())]
#         word, html = word.decode(), html.decode()
#         if "柯林斯" not in tags and str(html) != "":
#             tags.append("柯林斯9")
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"柯林斯": str(html)},
#                     "tags": tags,
#                 },
#             )
#             print(fields["word"]["value"], "explain", f"{index+1}/{len(notesInfo)}")
#     else:
#         print(f"【未找到单词】：{words}")

# >>>
# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# mdx = MDX("D:/Software/MDictPC/doc/mwa/mwa.mdx")
# headwords = [*mdx]  # 单词名列表
# items = [*mdx.items()]  # 释义html源码列表
# if len(headwords) == len(items):
#     print(f"[TRUE]加载成功：共{len(headwords)}条")
# else:
#     print(f"[ERROR]加载失败{len(headwords)}, {len(items)}")

# # if "pen".encode() in headwords:
# #     word, html = items[headwords.index("pen".encode())]
# #     word, html = word.decode(), html.decode()
# #     pqdoc = PyQuery(html)
# #     explain_entrys = pqdoc(
# #         "div.entry.entry_v2.boxy > div.sblocks > div > div > div > div.sense > div > ul > li:nth-child(-n+2) > div"
# #     )
# #     a = str(explain_entrys)
# #     pass

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     words: str = fields["word"]["value"]
#     if words.encode() in headwords:
#         # and "english_sentiment" not in tags
#         word, html = items[headwords.index(words.encode())]
#         word, html = word.decode(), html.decode()
#         # html = html.replace(r"\\", "")
#         pqdoc = PyQuery(html)
#         example_entrys = pqdoc(
#             "div.entry.entry_v2.boxy > div.sblocks > div > div > div > div.sense > div > ul > li:nth-child(-n+1) > div"
#         )
#         ol_tag = PyQuery("<ol></ol>")
#         ol_tag.add_class("english_sentiment")
#         for example_entry in example_entrys:
#             li_tag = PyQuery("<li></li>")
#             li_tag.append(example_entry)
#             ol_tag.append(li_tag)
#         # a = str(ol_tag)
#         if len(ol_tag.children()) != 0:
#             # if "english_sentiment" not in tags:
#             #     tags.append("english_sentiment")
#             invoke(
#                 "updateNote",
#                 note={
#                     "id": noteId,
#                     "fields": {"英文意境": str(ol_tag)},
#                     # "tags": tags,
#                 },
#             )
#             print(
#                 f"explain: {len(example_entrys)}",
#                 fields["word"]["value"],
#                 f"{index+1}/{len(notesInfo)}",
#             )
#     else:
#         print(f"【未找到单词】：{words}")
#         # if "english_sentiment" in tags:
#         #     tags.remove("english_sentiment")
#         #     invoke(
#         #         "updateNote",
#         #         note={
#         #             "id": noteId,
#         #             "tags": tags,
#         #         },
#         #     )


# note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     tags: list = noteInfo["tags"]
#     fields = noteInfo["fields"]
#     words: str = fields["word"]["value"]
#     if fields["柯林斯"]["value"] == "" and "Mdict柯林斯" in tags:
#         tags.remove("Mdict柯林斯")
#         invoke(
#             "updateNote",
#             note={
#                 "id": noteId,
#                 "tags": tags,
#             },
#         )
#         print(fields["word"]["value"], "up tags", f"{index+1}/{len(notesInfo)}")
# if fields["英文意境"]["value"] == "" and "english_sentiment" in tags:
#     tags.remove("english_sentiment")
#     invoke(
#         "updateNote",
#         note={
#             "id": noteId,
#             "tags": tags,
#         },
#     )
#     print(fields["word"]["value"], "up tags", f"{index+1}/{len(notesInfo)}")
# if "explain" in tags:
#     tags.remove("explain")
#     invoke(
#         "updateNote",
#         note={
#             "id": noteId,
#             "tags": tags,
#         },
#     )
#     print(fields["word"]["value"], "up tags", f"{index+1}/{len(notesInfo)}")

# mdx = MDX("D:/Software/MDictPC/doc/ode_glance/ode_glance.mdx")
# headwords = [*mdx]  # 单词名列表
# items = [*mdx.items()]  # 释义html源码列表
# if len(headwords) == len(items):
#     print(f"[TRUE]加载成功：共{len(headwords)}条")
# else:
#     print(f"[ERROR]加载失败{len(headwords)}, {len(items)}")


note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    if "english_sentiment" not in tags and "english_sentiment_tidme" not in tags:
        ol_tag = PyQuery("<ol></ol>")
        ol_tag.add_class("english_sentiment")
        exams = download_cambridge_words_exam(word)
        if len(exams) != 0:
            for en, zh in exams:
                div_tag = PyQuery("<div></div>")
                div_tag.add_class("vi_content")
                span_tag = PyQuery("<span></span>")
                span_tag.add_class("mw_zh")
                li_tag = PyQuery("<li></li>")
                span_tag.text(zh)
                div_tag.html(en + str(span_tag))
                li_tag.append(div_tag)
                ol_tag.append(li_tag)
        else:
            continue
        a = str(ol_tag)
        if len(ol_tag.children()) != 0:
            tags.append("english_sentiment_cambridge")
            invoke(
                "updateNote",
                note={
                    "id": noteId,
                    "fields": {"英文意境": str(ol_tag)},
                    "tags": tags,
                },
            )
            print("es", f"{index+1}/{len(notesInfo)}")

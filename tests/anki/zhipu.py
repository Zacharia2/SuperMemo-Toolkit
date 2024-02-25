from zhipuai import ZhipuAI
import json
import urllib.request

client = ZhipuAI(
    api_key="814ab8281baaff6d09c828b0bbd72887.VvuNGWalXxSRDsaz"
)  # 填写您自己的APIKey

# Create a simple, easy-to-understand English phrase that encapsulates the essence of the given word without using the word itself, making sure a 6-year-old child in the U.S. can comprehend it. Provide only two parts: the phrase and its Chinese meaning, separated by a line break.\n\nExample:\nPhrase: Make code run\nMeaning: 让代码运行起来
def get_words(word: str):
    response = client.chat.completions.create(
        model="glm-4",  # 填写需要调用的模型名称
        messages=[
            {
                "role": "system",
                "content": "Create a simple, easy-to-understand English phrase, using no more than 5 words, that encapsulates the essence of the given word without using the word itself, ensuring a 6-year-old child in the U.S. can comprehend it. Provide only two parts: the phrase and its Chinese meaning, separated by a line break.\n\nExample:\nPhrase: Make code run\nMeaning: 让代码运行起来",
            },
            {
                "role": "user",
                "content": "location",
            },
            {
                "role": "assistant",
                "content": "Phrase: Where you are now\nMeaning: 你现在在的地方",
            },
            {
                "role": "user",
                "content": word,
            },
        ],
    )

    result: str = response.choices[0].message.content or ""
    ans_list: list = result.split("\n") or ""
    new_list = list()
    for item in ans_list:
        if (
            item.startswith("词组: ")
            or item.startswith("释义: ")
            or item.startswith("Phrase: ")
            or item.startswith("Meaning: ")
        ):
            new_list.append(item.split(": ")[1])
    print(result)
    return new_list


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


note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    # if "同义词组" in tags:
    #     tags.remove("同义词组")
    # if "同义句" not in tags:
    if "同义词组" not in tags:
        # tags.remove("同义词组")
        tags.append("同义词组")
        a = get_words(word)
        if len(a) >= 2:
            invoke(
                "updateNote",
                note={
                    "id": noteId,
                    "fields": {"同义词组": a[0], "同义词组释义": a[1]},
                    "tags": tags,
                },
            )
            print("同义词组", f"{index+1}/{len(notesInfo)}, {a}")


# messages=[
#             {
#                 "role": "system",
#                 "content": "你是一个乐于解答各种问题的助手，你的任务是为用户提供专业、准确、有见地的建议。",
#             },
#             {
#                 "role": "user",
#                 "content": "请根据用户给出的一个单词，思考其最基本和核心的含义。然后创造一个简单、易于理解的英语词组，但不包含给出的单词，使得一个美国6岁的孩子也能理解其意义。你的回答应该只包含两个部分：首先是创造的词组，紧接着是这个词组的中文释义。严格按照例子执行。\n\n例子：\n\n词组: Happy stuff inside\n释义: 里面的快乐东西\n",
#             },
#             {
#                 "role": "user",
#                 "content": "location",
#             },
#             {
#                 "role": "assistant",
#                 "content": "词组: Where you are now\n释义: 你现在在的地方",
#             },
#             {
#                 "role": "user",
#                 "content": word,
#             },
#         ],

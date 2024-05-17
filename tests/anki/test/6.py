import ast
from openai import OpenAI
import json
import urllib.request


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


client = OpenAI(
    # #将这里换成你在aihubmix api keys拿到的密钥
    api_key="sk-EonFLRSFSs0w8Llt4cA95aB8529d47D884Ac0aC684C4084f",
    # 这里将官方的接口访问地址，替换成aihubmix的入口地址
    base_url="https://aihubmix.com/v1",
)


# Create a simple, easy-to-understand English phrase that encapsulates the essence of the given word without using the word itself, making sure a 6-year-old child in the U.S. can comprehend it. Provide only two parts: the phrase and its Chinese meaning, separated by a line break.\n\nExample:\nPhrase: Make code run\nMeaning: 让代码运行起来
def get_words(word: str):
    response = client.chat.completions.create(
        model="gpt-3.5-turbo-0125",  # 填写需要调用的模型名称gpt-3.5-turbo-0125
        messages=[
            {
                "role": "user",
                # "content": f"Find the closest synonyms, related words, and antonyms for the word '{word}'. Sort the results by relevance. Provide the output in a structured format, for example: {{'synonyms': ['synonym1', 'synonym2'], 'related': ['related1', 'related2'], 'antonyms': ['antonym1', 'antonym2']}}",
                "content": "You are an expert in English vocabulary for postgraduate entrance exams in China."
                + "Please prioritize words that are frequently tested and expected to be known by candidates appearing for postgraduate entrance exams in China."
                + f"Please provide the closest synonyms, related words, and antonyms for the word '{word}'."
                + "Sort the results by relevance. Provide the output in a structured format, for example: {'synonyms': ['synonym1', 'synonym2'], 'related': ['related1', 'related2'], 'antonyms': ['antonym1', 'antonym2']}",
            }
        ],
    )

    try:
        response_content = response.choices[0].message.content
        # 将响应内容转换为字典
        word_relationships = ast.literal_eval(response_content)
        return word_relationships
    except Exception as e:
        print(f"Error parsing response: {e}")
        return None


note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    anki_tjf = fields["同近反"]["value"]
    if anki_tjf == "":
        tjf = get_words(word)
        if tjf:
            filed_tjf = str(tjf)
            tags.append("ky-tjf")
            invoke(
                "updateNote",
                note={
                    "id": noteId,
                    "fields": {"同近反": filed_tjf},
                    "tags": tags,
                },
            )
            print("同近反", f"{index+1}/{len(notesInfo)}")

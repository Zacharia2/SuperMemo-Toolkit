import pystache.defaults
from supermemo_toolkit.utilscripts.ankinet import invoke
from premailer import transform
import pystache
# note_id_list = invoke("findNotes", query="deck:24意境语义红宝石")
# notesInfo = invoke("notesInfo", notes=note_id_list)

# # modelName = notesInfo[29]["modelName"]
# findModelsByName = invoke("findModelsByName", modelNames=["Basic"])

# model.type\model.tmpls\model.css
# findModelsByName[0]['type'] 模型类型
# findModelsByName[0]['css'] CSS
# findModelsByName[0]['tmpls'][0]['name']
# findModelsByName[0]['tmpls'][0]['qfmt'] 问题模版
# findModelsByName[0]['tmpls'][0]['afmt'] 答案模版
# findModelsByName[0]['tmpls'][0]['did']
# findModelsByName[0]['tmpls'][0]['bqfmt']
# findModelsByName[0]['tmpls'][0]['bafmt']
# 第一个[0]对应的是请求的是一个列表，与列表下标对应的回应。
# 第二个[0]对应的就是模版下面的卡片了。默认是一个卡片。
# 然后就是mustache.render渲染卡片绑定笔记字段。
# 然后根据SuperMemo的模版情况，设置anki笔记的CSS，如何存放。
# https://github.com/anki2smArchive/anki2sm/blob/561035dd9f0077316cf7a4c3d7daa616fa7bfccf/anki2smV2.py#L368-L416
# <style>在QA中都有了。premailer.transform将样式属性直接嵌入到 HTML 元素中
# for index, noteInfo in enumerate(notesInfo):
#     noteId = noteInfo["noteId"]
#     fields = noteInfo["fields"]


# anki2sm ：选择卡组，选择输出路径。
# sm2anki：选择xml，选择卡组。


def list():
    desk = set()
    deckNames: str[list] = invoke("deckNames")
    for deckname in deckNames:
        desk.add(deckname.split("::")[0])
    for name in desk:
        print(f"deckNames: {name}")


def a2s(deck: str):
    note_id_list = invoke("findNotes", query=f"deck:{deck}")
    notesInfo = invoke("notesInfo", notes=note_id_list)
    if len(notesInfo) == 0:
        print(f"{deck} notes is 0")
        return
    findModelsByName = invoke(
        "findModelsByName", modelNames=[notesInfo[0]["modelName"]]
    )
    Model = findModelsByName[0]

    card_tmpls = 0
    type = Model["type"]
    css = Model["css"]
    name = Model["tmpls"][card_tmpls]["name"]
    qfmt = Model["tmpls"][card_tmpls]["qfmt"]
    afmt = Model["tmpls"][card_tmpls]["afmt"]

    for noteInfo in notesInfo:
        fields = noteInfo["fields"]
        note_fields = {}
        for name, value in fields.items():
            note_fields.update({name: value["value"]})
        # 将字段嵌入到模版中。
        # 将样式嵌入到元素中。
        # 渲染模版并得到静态结果无JS代码。
        # 需要模拟anki的js环境。这个js该如何处理，我需要的是静态的无js的。
        renderer = pystache.Renderer(
            escape=lambda u: u, file_encoding=pystache.defaults.DELIMITERS
        )
        if type == 0:
            questionTg = (
                f"<style>{css}</style>"
                + "<section class='card' style=\" height:100%; width:100%; margin:0; \">"
                + renderer.render(qfmt, note_fields)
                + "</section>"
            )
            answerTag = (
                f"<style>{css}</style>"
                + "<section class='card' style=\" height:100%; width:100%; margin:0; \">"
                + renderer.render(afmt, note_fields)
                + "</section>"
            )
            questionTg = transform(questionTg)
            answerTag = transform(answerTag)

        elif type == 1:
            questionTg = (
                f"<style>{css}</style>"
                + "<section class='card' style=\" height:100%; width:100%; margin:0; \">"
                + renderer.render(qfmt, note_fields)
                + "</section>"
            )
            answerTag = (
                f"<style>{css}</style>"
                + "<section class='card' style=\" height:100%; width:100%; margin:0; \">"
                + renderer.render(afmt, note_fields)
                + "</section>"
            )
            questionTg = transform(questionTg)
            answerTag = transform(answerTag)


a2s("24意境语义红宝石")

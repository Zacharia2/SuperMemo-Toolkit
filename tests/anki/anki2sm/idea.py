from tests.anki.main import invoke

# buildColTree

deckNames = invoke("deckNames")
note_id_list = invoke("findNotes", query="deck:24意境语义红宝石")
notesInfo = invoke("notesInfo", notes=note_id_list)

# modelName = notesInfo[29]["modelName"]
findModelsByName = invoke(
    "findModelsByName", modelNames=["Basic"]
)

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
for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    fields = noteInfo["fields"]

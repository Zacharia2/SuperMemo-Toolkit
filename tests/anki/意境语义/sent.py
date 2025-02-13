import re
import pandas as pd

from until.cmp_2word import cmp_2word
from main import invoke

df = pd.read_excel("C:/Users/Snowy/Desktop/2000.xlsx", sheet_name="Sheet1")
# word_list = df.iloc[:, 0].to_dict()
# sent_dataFrame = df.iloc[1:60, 0:4].to_dict()
# sent_dataFrame = [row.to_dict() for index, row in df.iloc[0:60, 0:4].iterrows()]
aa_sent_dataFrame = [row.to_dict() for index, row in df.iloc[0:100, 0:3].iterrows()]
# word_list = [x.strip() for x in sent_dataFrame["词集"] if isinstance(x, str)]

# for index, sent in enumerate(sent_dataFrame):
#     words = str(sent["词集"]).split("、")
#     sent_dataFrame[index]["词集"] = words

for index, sent in enumerate(aa_sent_dataFrame):
    matches = [x for x in re.findall(r"\[(.*?)\]", sent["句子"])]
    aa_sent_dataFrame[index]["词集"] = matches

# sent_list = sent_dataFrame + aa_sent_dataFrame

note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    SentID = fields["SentID"]["value"]
    invoke(
        "updateNote",
        note={
            "id": noteId,
            "fields": {
                "SentID": "",
                "Sent": "",
                "Trans": "",
            },
        },
    )
    print(f"clearly:: {index + 1}/{len(notesInfo)}")

count = 0
for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    for sigsent in aa_sent_dataFrame:
        for cword in sigsent["词集"]:
            if cmp_2word(word, cword):
                count += 1
                replaced_text = re.sub(
                    r"\[.{0,2}" + cword + r".{0,2}\]",
                    f'<span class="curr_word"><b>{cword}</b></span>',
                    sigsent["句子"],
                )
                replaced_text = re.sub(
                    r"\[(.*?)\]", r'<span class="other_word">\1</span>', replaced_text
                )
                num = int(sigsent["序列"])
                meaning = re.sub(r"\s+", "", sigsent["句意"])
                invoke(
                    "updateNote",
                    note={
                        "id": noteId,
                        "fields": {
                            "SentID": f"{num:04d}",
                            "Sent": replaced_text,
                            "Trans": meaning,
                        },
                    },
                )
                print(f"{count}::{word}:{cword}, {index + 1}/{len(notesInfo)}")

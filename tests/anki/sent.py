import os
import re
import sys
import pandas as pd

from until.cmp_2word import cmp_2word

sys.path.insert(0, os.path.normpath(sys.path[0] + "/../"))
from main import invoke  # noqa: E402

df = pd.read_excel("C:/Users/Snowy/Desktop/2000.xlsx", sheet_name="Sheet1")
# word_list = df.iloc[:, 0].to_dict()
# sent_dataFrame = df.iloc[1:60, 0:4].to_dict()
sent_dataFrame = [row.to_dict() for index, row in df.iloc[0:60, 0:4].iterrows()]
aa_sent_dataFrame = [row.to_dict() for index, row in df.iloc[60:100, 0:3].iterrows()]
# word_list = [x.strip() for x in sent_dataFrame["词集"] if isinstance(x, str)]

for index, sent in enumerate(sent_dataFrame):
    words = str(sent["词集"]).split("、")
    sent_dataFrame[index]["词集"] = words

for index, sent in enumerate(aa_sent_dataFrame):
    matches = [x for x in re.findall(r"\[(.*?)\]", sent["句子"])]
    aa_sent_dataFrame[index]["词集"] = matches

sent_list = sent_dataFrame + aa_sent_dataFrame

note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

count = 0
for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    word = fields["word"]["value"]
    for sigsent in sent_list:
        for cword in sigsent["词集"]:
            if cmp_2word(word, cword):
                count += 1
                replaced_text = re.sub(
                    r"\[" + cword + r"\]",
                    f'<font color="red"><b>{cword}</b></font>',
                    sigsent["句子"],
                )
                replaced_text = re.sub(
                    r"\[(.*?)\]", r'<font color="blue">\1</font>', replaced_text
                )
                num = int(sigsent["序列"])
                invoke(
                    "updateNote",
                    note={
                        "id": noteId,
                        "fields": {
                            "SentID": f"{num:04d}",
                            "Sent": replaced_text,
                            "Trans": sigsent["句意"],
                        },
                    },
                )
                print(f"{count}::{word}:{cword}, {index+1}/{len(notesInfo)}")

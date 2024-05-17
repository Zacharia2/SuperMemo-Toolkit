import os
import re
import sys

sys.path.insert(0, os.path.normpath(sys.path[0] + "/../"))
from main import invoke  # noqa: E402

note_id_list = invoke("findNotes", query="deck:2024红宝书考研词汇")
notesInfo = invoke("notesInfo", notes=note_id_list)

max_id: int = 0
for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
    fields = noteInfo["fields"]
    Group: str = fields["所在组"]["value"]  # 必考词 Unit 06
    mlist = re.split(r"\s+", Group)
    if mlist[0] == "必考词":
        unit = f"{mlist[1]} {mlist[2]}"
        curr_deck = f"2024红宝书考研词汇::A - 必考词::{unit}"
    elif mlist[0] == "基础词":
        unit = f"{mlist[1]} {mlist[2]}"
        curr_deck = f"2024红宝书考研词汇::B - 基础词::{unit}"
    elif mlist[0] == "超纲词":
        curr_deck = f"2024红宝书考研词汇::C - 超纲词::{mlist[1]}"
    else:
        curr_deck = "2024红宝书考研词汇::D - 扩展词"
    invoke("changeDeck", cards=[noteId], deck=curr_deck)
    print(f"{curr_deck},,{Group},,{index+1}/{len(notesInfo)}")

# for i in range(100):
#     curr_id = f"SentID:{int(i+1):04d}"
#     sent_cards = invoke("findCards", query=curr_id)
#     if len(sent_cards) > 0:
#         curr_deck = f"2024红宝书考研词汇::Sentence100::Set{int(i+1):04d}"
#         invoke("createDeck", deck=curr_deck)
#         invoke("changeDeck", cards=sent_cards, deck=curr_deck)

#     print(i + 1)

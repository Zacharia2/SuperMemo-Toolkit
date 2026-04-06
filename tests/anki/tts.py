import base64
import re
import edge_tts
from supermemo_toolkit.utilscripts.ankinet import invoke, download_word_sound


def makeNameSafe(name):
    illegalFilenameCharacters = r"/<|>|\:|\"|\/|\\|\||\?|\*|\^|\s|\s/g"
    fixedTitle = re.sub(illegalFilenameCharacters, "_", name)
    return fixedTitle


def sentence():
    note_id_list = invoke("findNotes", query="deck:01意境语义红宝石")
    notesInfo = invoke("notesInfo", notes=note_id_list)
    for index, noteInfo in enumerate(notesInfo):
        noteId = noteInfo["noteId"]
        fields = noteInfo["fields"]
        lj: str = fields["例句"]["value"]
        if len(fields["例句音频U"]["value"]) != 0:
            continue
        lj_stripped = lj.strip().replace("<b>", "").replace("</b>", "")
        file_name = makeNameSafe(lj_stripped).replace(".", "") + ".mp3"
        communicate = edge_tts.Communicate(
            text=lj_stripped, voice="en-US-ChristopherNeural"
        )  # en-US-EricNeural
        buffer = bytearray()
        for chunk in communicate.stream_sync():
            if chunk["type"] == "audio":
                buffer.extend(chunk["data"])  # type: ignore
        file_data = base64.b64encode(bytes(buffer)).decode()
        if file_name != "" and file_data != "":
            result_filename = invoke(
                "storeMediaFile", filename=file_name, data=file_data
            )
            if result_filename:
                invoke(
                    "updateNote",
                    note={
                        "id": noteId,
                        "fields": {
                            "例句音频U": f"{result_filename}",
                            "例句音频S": f"[sound:{result_filename}]",
                        },
                    },
                )
                print(f"{index + 1}/{len(notesInfo)}::{result_filename}")


def word():
    note_id_list = invoke("findNotes", query="deck:01意境语义红宝石")
    notesInfo = invoke("notesInfo", notes=note_id_list)
    for noteInfo in notesInfo:
        noteId = noteInfo["noteId"]
        tag = noteInfo["tags"]
        fields = noteInfo["fields"]
        word = fields["orderKey"]["value"]
        sound = fields["单词音频"]["value"]
        if sound == "":
            # 下载单词音频
            (file_name, file_data) = download_word_sound(word, 1)
            if file_name != "" and file_data != "":
                # 存储音频到anki
                result_filename = invoke(
                    "storeMediaFile", filename=file_name, data=file_data
                )
                if result_filename:
                    invoke(
                        "updateNote",
                        note={
                            "id": noteId,
                            "fields": {"单词音频": f"[sound:{result_filename}]"},
                        },
                    )
                    print(noteId, result_filename)


sentence()

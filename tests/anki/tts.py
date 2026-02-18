import base64
import re
import edge_tts
from supermemo_toolkit.utilscripts.ankinet import invoke


def makeNameSafe(name):
    illegalFilenameCharacters = r"/<|>|\:|\"|\/|\\|\||\?|\*|\^|\s|\s/g"
    fixedTitle = re.sub(illegalFilenameCharacters, "_", name)
    return fixedTitle


note_id_list = invoke("findNotes", query="deck:26意境语义红宝石")
notesInfo = invoke("notesInfo", notes=note_id_list)
for index, noteInfo in enumerate(notesInfo):
    noteId = noteInfo["noteId"]
    tags: list = noteInfo["tags"]
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
        result_filename = invoke("storeMediaFile", filename=file_name, data=file_data)
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

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


def str_en_zh_split(mstring: str):
    for i, s in enumerate(mstring):
        if not s.isascii():
            return (mstring[:i], mstring[i:])


def backward_erasure(onelist: list, savelen: int) -> list:
    """
    给一个列表, 从后往前删除, 并保留前savelen个。
    """
    mindex = len(onelist) - 1
    for i in range(mindex, -1, -1):
        llen = i + 1
        if llen <= savelen:
            break
        del onelist[i]
    return onelist

def find_non_ascii_chars(s: str):
    """
    返回字符串中所有非 ASCII 字符的列表。
    如果只需要唯一字符，可将结果转为 set。
    """
    return [ch for ch in s if ord(ch) >= 128]


def to_html_entity(text: str) -> str:
    mapping = {
        "…": "...",
        "·": "&middot;",
        "◀": "&#9664;",  # 左三角无标准命名实体
        "—": "&mdash;",
        "▶": "&#9654;",  # 右三角
        "−": "&minus;",
        "🔖": "&#128278;",  # 书签 Unicode: U+1F516
        "📷": "&#128247;",  # 相机 U+1F4F7
        "✂": "&#9986;",  # 剪刀 U+2702
        "⚡": "&#9889;",  # 闪电 U+26A1
        "→": "&rarr;",
        "✓": "&check;",
        "✕": "&times;",  # 乘号，也可用 '&#10005;'
    }
    for k, v in mapping.items():
        text = text.replace(k, v)
    return text


p = r"D:\SuperMemo\bin\PDF\PDFEditor.htm"

with open(p, "r", encoding="utf-8") as f:
    raw = f.read()
    a = list(set(find_non_ascii_chars(raw)))
    raw = to_html_entity(raw)
    b = list(set(find_non_ascii_chars(raw)))
with open(p, "w", encoding="utf-8") as f1:
    f1.write(raw)

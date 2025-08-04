import html
import re


# ParentTitle、ElementInfo Title
# Parent（ID）、ID
def parseNodeAsText(text: str):
    state_stack = []  # Element、ElementInfo、Component、RepHist

    # 初始化状态
    elements = []
    element_map = {}

    for line in text.splitlines():
        line = line.strip()
        # 开始行
        if line.startswith("Begin"):
            Sign, Tag, Id = (x.strip() for x in line.split(" "))
            state_stack.append(Sign + Tag)  # BeginElement
            if Tag == "Element":
                element_map[Tag] = {}
                element_map[Tag]["ID"] = Id
            elif Tag == "ElementInfo":
                element_map[Tag] = {}
            elif Tag == "Component":
                element_map[Tag] = {}
                element_map[Tag]["ID"] = Id
            elif Tag == "RepHist":
                element_map[Tag] = []
        # 结束行
        elif line.startswith("End"):
            Sign, Tag, Id = (x.strip() for x in line.split(" "))
            stackTag = state_stack.pop()
            if stackTag == "BeginElement":
                elements.append(element_map[Tag])
                element_map = {}
            elif stackTag == "BeginElementInfo":
                element_map["Element"]["ElementInfo"] = element_map[Tag]
            elif stackTag == "BeginComponent":
                element_map["Element"]["Component"] = element_map[Tag]
            elif stackTag == "BeginRepHist":
                element_map["Element"]["RepHist"] = element_map[Tag]
        # 属性行
        else:
            # 现在位于什么区段的开始行之下？
            # 如果栈内没有说明本元素区段结束，继续下一个元素区段。
            if len(state_stack) == 0:
                continue
            elif state_stack[-1] == "BeginElement":
                key, value = line.strip().split("=", 1)
                element_map["Element"][key] = value
            elif state_stack[-1] == "BeginElementInfo":
                key, value = line.strip().split("=", 1)
                element_map["ElementInfo"][key] = value
            elif state_stack[-1] == "BeginComponent":
                key, value = line.strip().split("=", 1)
                element_map["Component"][key] = value
            elif state_stack[-1] == "BeginRepHist":
                element_map["RepHist"].append(line.strip())
    return elements


def stringifyNode(elements):
    result = []
    for element in elements:
        ID = element.get("ID")
        result.append(f"Begin Element {ID}")

        for key, value in element.items():
            if isinstance(value, dict):
                if key == "Component":
                    result.append(f"  Begin {key} {value.get('ID')}")
                else:
                    result.append(f"  Begin {key} {ID}")
                for s_key, s_value in value.items():
                    if s_key != "ID":
                        result.append(f"    {s_key}={s_value}")
                if key == "Component":
                    result.append(f"  End {key} {value.get('ID')}")
                else:
                    result.append(f"  End {key} {ID}")
            elif isinstance(value, list):
                result.append(f"  Begin {key} {ID}")
                for item in value:
                    result.append(f"    {item}")
                result.append(f"  End {key} {ID}")
            elif key != "ID":
                result.append(f"  {key}={value}")
        result.append(f"End Element {ID}")
        result.append("")
    result.pop()
    return "\n".join(result)


def node_tcomp(needfix: str, patch: dict):
    """根据patch修补NodeAsText

    Args:
        needfix (str): filePath
        patch (Map): id->Title
    """
    with open(
        needfix,
        mode="r",
        encoding="utf-8",
        errors="ignore",
    ) as fs:
        nodeText = fs.read()

    nodes = parseNodeAsText(nodeText)
    unfind = set()
    for el in nodes:
        ID = el.get("ID").strip("#").strip()
        Parent = el.get("Parent")
        ParentTitle = patch.get(Parent)
        Title = patch.get(ID)
        el["ParentTitle"] = ParentTitle or el["ParentTitle"]
        el["ElementInfo"]["Title"] = Title or el["ElementInfo"]["Title"]
        if not ParentTitle:
            unfind.add(Parent)
        if not Title:
            unfind.add(ID)
    print(unfind)

    with open(needfix, mode="w", encoding="utf-8") as fs:
        fs.write(stringifyNode(nodes))


def parse(text):
    ref_dict = {}
    q_text: str = html.unescape(text)
    reference = re.search(
        r"<FONT class=reference>(.*?)</FONT>",
        re.split(r"<hr[\s\S]*?SuperMemo>", q_text)[-1],
        re.DOTALL,
    )
    if reference:
        ref_contents = reference.group(1).replace("\n", "").split("<br>")
        for ref_item in ref_contents:
            key, value = ref_item.split(":", 1)
            key = key.strip("#").strip()
            value = value.strip()
            ref_dict[key] = value
    return ref_dict


# def haved_Title(el):
#     for item in el.children:
#         if item.name == "Title":
#             return True
#     return False

# def tcomp(needfix, output):
#     with open(needfix, mode="r") as fs:
#         xml = fs.read()
#     soup = BeautifulSoup(xml, "xml")
#     # - SuperMemoElement
#     #   - Title
#     #   - Content
#     #     - Question
#     questions = soup.find_all("Question")
#     for question in questions:
#         el = question.parent.parent
#         if haved_Title(el):
#             continue
#         # 排除掉有Title的el
#         ref_dict = parse(question.text)
#         new_title = soup.new_tag("Title")
#         # TODO 有两个问题，一个是元素没设置ref，但父设置了，所以用的父的ref
#         # 另一个问题是没有ref，但我导入图书的时候设计了title但没有生成ref。
#         # 总之title是存放在知识树中的，导出XML会没有。
#         new_title.string = ref_dict.get("Title") or "111"
#         el.insert(0, new_title)
#     with open(output, mode="w", encoding="utf-8") as fs:
#         fs.write(str(soup))


# infile = "C:/Users/Snowy/Desktop/1.xml"
# inhtm = "C:/Users/Snowy/Desktop/1.htm"
# infile = "C:/Users/Snowy/Desktop/NodeAsText.txt"
# outfile = "C:/Users/Snowy/Desktop/5566.xml"
# tcomp(infile, outfile)
# fixNodeAsText(infile, patch)

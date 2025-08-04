from bs4 import BeautifulSoup
import re
import copy
# ParentTitle、ElementInfo Title
# Parent（ID）、ID


def parseNodeAsText(file: str):
    with open(
        file,
        mode="r",
        encoding="utf-8",
        errors="replace",
    ) as fs:
        nodeText = fs.read()
    state_stack = []  # Element、ElementInfo、Component、RepHist

    # 初始化状态
    elements = []
    element_map = {}

    for line in nodeText.splitlines():
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


def haved_Title(el):
    for item in el.children:
        if item.name == "Title":
            return True
    return False


def parse_toc_htm(file: str):
    with open(file, mode="r", encoding="GB18030") as fs:
        htm = fs.read()
    titles = [x for x in re.split(r"<[^>]+>", htm, flags=re.DOTALL) if x != ""]
    return titles[1:]


def node_tcomp(nodefile: str, tocfile: str):
    titles = parse_toc_htm(tocfile)
    nodes = parseNodeAsText(nodefile)
    copyNodes = copy.deepcopy(nodes)
    # TODO nodes和titles对齐的问题。
    c = len(titles) - len(copyNodes)
    if c <= 3:
        for i in range(0, c):
            copyNodes.insert(0, {"ID": ""})
    patch = {}
    for i in reversed(range(len(titles))):
        patch[copyNodes[i]["ID"].lstrip("#")] = titles[i]
        if c != 0 and i == 1:
            # 第一个Node的Parent值。
            patch[copyNodes[i + 1]["Parent"]] = titles[i]
    for node in nodes:
        id = node.get("ID").lstrip("#").strip()
        parent_id = node.get("Parent")
        title = patch.get(id)
        parent_title = patch.get(parent_id)
        node["ParentTitle"] = parent_title or node["ParentTitle"]
        node["ElementInfo"]["Title"] = title or node["ElementInfo"]["Title"]
        if "Component" in node:
            HTMFile = node["Component"]["HTMFile"]
            with open(HTMFile, "r") as fs:
                HTMFile = fs.read()
            soup = BeautifulSoup(HTMFile, "html.parser")
            name = "".join(soup.text[0:100].split("\n"))
            node["Component"]["HTMName"] = name

    with open(nodefile, mode="w", encoding="utf-8") as fs:
        fs.write(stringifyNode(nodes))


def xml_tcomp(xmlfile: str, tocfile: str):
    with open(xmlfile, mode="r", encoding="utf-8") as fs:
        xml = fs.read()
    soup = BeautifulSoup(xml, "xml")
    ids = soup.find_all("ID")  # 前序排列的ids
    titles = parse_toc_htm(tocfile)
    for i, id in enumerate(ids):
        # - SuperMemoElement
        #   - Title
        #   - ID
        el = id.parent
        if haved_Title(el):
            continue
        new_title = soup.new_tag("Title")
        new_title.string = titles[i]
        el.insert(0, new_title)
    with open(xmlfile, mode="w", encoding="utf-8") as fs:
        fs.write(str(soup))


# [Warning] 这一切的前提是 全部按照前序排列。
infile = "C:/Users/Snowy/Desktop/NodeAsText1.txt"
inhtm = "C:/Users/Snowy/Desktop/reading-and-review (document contents).htm"
inxfile = "C:/Users/Snowy/Desktop/reading-and-review (阅读复习).xml"
node_tcomp(infile, inhtm)
# xml_tcomp(inxfile, inhtm)
# with open(
#     infile,
#     mode="r",
#     encoding="utf-8",
#     errors="replace",
# ) as fs:
#     nodeText = fs.read()
#     pass

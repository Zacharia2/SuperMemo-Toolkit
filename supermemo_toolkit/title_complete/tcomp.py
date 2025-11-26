from bs4 import BeautifulSoup
import re
import copy
# ParentTitle、ElementInfo Title
# Parent（ID）、ID


def parseNodeAsText(nodeText: str):
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
    with open(
        nodefile,
        mode="r",
        encoding="utf-8",
        errors="replace",
    ) as fs:
        nodeText = fs.read()
    nodes = parseNodeAsText(nodeText)
    copyNodes = copy.deepcopy(nodes)
    # 倒序对齐，不足自动填充。
    EQUAL, NO_ROOT_PARENT_IS_ROOT, NO_ROOT_AND_PARENT = range(3)
    diff_sum = len(titles) - len(copyNodes)
    patch = {}
    if diff_sum == NO_ROOT_AND_PARENT:
        # 插入ROOT和PARENT
        copyNodes = [{"ID": ""}, {"ID": ""}] + copyNodes
        for i in reversed(range(len(titles))):
            patch[copyNodes[i]["ID"].lstrip("#")] = titles[i]
            if i == 1:
                # copyNodes[002]填充前第一个Node(ParentNode)的Parent值。
                patch[copyNodes[i + 1]["Parent"]] = titles[i]
    elif diff_sum == NO_ROOT_PARENT_IS_ROOT:
        # 插入PARENT_IS_ROOT，titles有而nodes没有，仅填充nodes。
        copyNodes.insert(0, {"ID": ""})
        for i in reversed(range(len(titles))):
            patch[copyNodes[i]["ID"].lstrip("#")] = titles[i]
    elif diff_sum == EQUAL:
        for i in reversed(range(len(titles))):
            patch[copyNodes[i]["ID"].lstrip("#")] = titles[i]
    else:
        print("标题列表长度超出定义, 标题和ID列表长度无法对齐, 结束执行")
        return

    for node in nodes:
        parent_id = node.get("Parent")
        id = node.get("ID").lstrip("#").strip()

        parent_title: str = patch.get(parent_id) or node["ParentTitle"]
        title: str = patch.get(id) or node["ElementInfo"]["Title"]

        # 目前已知下划线可以，中文句号，英文null、分号、句号、空格不可以

        parent_title = re.sub(r"(\d+)", r"_\1_", parent_title)
        parent_title = re.sub(r"_{2,}", "_", parent_title)
        node["ParentTitle"] = re.sub(r"\s", "_", parent_title) + "_"

        title = re.sub(r"(\d+)", r"_\1_", title)
        title = re.sub(r"_{2,}", "_", title)
        node["ElementInfo"]["Title"] = re.sub(r"\s", "_", title) + "_"

        if "Component" in node:
            HTMFile = node["Component"]["HTMFile"]
            with open(HTMFile, "r") as fs:
                HTMFile = fs.read()
            soup = BeautifulSoup(HTMFile, "html.parser")
            name = "".join(soup.text[0:100].split("\n"))
            node["Component"]["HTMName"] = name

    with open(nodefile, mode="w", encoding="utf-8") as fs:
        fs.write(stringifyNode(nodes))
    print("Node处理完成。")


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
    print("XML处理完成。")


# [Warning] 这一切的前提是 全部按照前序排列。
# infile = "C:/Users/Snowy/Desktop/NodeAsText.txt"
# inhtm = "C:/Users/Snowy/Desktop/reading-and-review (document contents).htm"
# inxfile = "C:/Users/Snowy/Desktop/reading-and-review (阅读复习).xml"
# node_tcomp(infile, inhtm)
# xml_tcomp(inxfile, inhtm)
# with open(infile, mode="r", encoding="utf-8") as fs:
#     nodeText = fs.read()
#     pass

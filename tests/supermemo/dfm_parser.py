def indent(text, amount, ch=" "):
    padding = amount * ch
    return "".join(padding + line for line in text.splitlines(True))


def getIndentation(aStr):
    result = 0
    for char in aStr:
        if char != " ":
            break
        result += 1
    return result


class LineReader:
    """模拟文件对象的行读取，基于字符串列表"""

    def __init__(self, lines):
        self.lines = lines  # list of str, 每行包含换行符
        self.pos = 0

    def readline(self):
        if self.pos >= len(self.lines):
            return ""
        line = self.lines[self.pos]
        self.pos += 1
        return line

    def peek_line(self):
        if self.pos >= len(self.lines):
            return ""
        return self.lines[self.pos]


class DelphiObject:
    def __init__(self, name, aType):
        self.name = name
        self.objectType = aType
        self.tag = ""
        self.inherited = False
        self.fields = []
        self.children = []

    def toString(self, aIndent=0):
        nm = "object"
        if self.inherited:
            nm = "inherited"
        tg = ""
        if self.tag:
            tg = f" {self.tag}"
        result = f"{nm} {self.name}: {self.objectType}{tg}\n"
        inner = ""
        for aField in self.fields:
            inner = inner + aField.toString(aIndent).rstrip() + "\n"
        for aChild in self.children:
            inner = inner + aChild.toString(aIndent)
        result = result + indent(inner, 2)
        result = result + "end\n"
        return indent(result, aIndent)

    def __str__(self):
        return self.toString()


class DelphiField:
    def __init__(self, aName):
        self.name = aName
        self.value = None
        self.fieldType = ""

    def toString(self, aIndent=0):
        if not self.fieldType:
            val = self.value
            if isinstance(val, str) and "\n" in val:
                lines = val.splitlines(True)
                indented_lines = []
                for i, line in enumerate(lines):
                    if i == 0 and line == "\n":
                        indented_lines.append(line)
                    else:
                        indented_lines.append("  " + line)
                val = "".join(indented_lines)
            result = f"{self.name} = {val}"
        else:
            result = f"{self.name} = {self.printValueAsList()}"
        return indent(result, aIndent)

    def printValueAsList(self):
        aStartToken = "["
        aEndToken = "]"
        aEOLToken = ", "
        aSOLToken = ""
        if self.fieldType == "ARRAY":
            aStartToken = "<"
            aEndToken = ">"
            aEOLToken = "\n"
            aSOLToken = "\n"
        elif self.fieldType == "STRINGS":
            aStartToken = "("
            aEndToken = ")"
            aEOLToken = "\n"
            aSOLToken = "\n"
        elif self.fieldType == "DATA":
            aStartToken = "{"
            aEndToken = "}"
            aEOLToken = "\n"
            aSOLToken = "\n"
        result = aStartToken
        if isinstance(self.value, list):
            if len(self.value):
                result = result + aSOLToken
                inner = ""
                for aItem in self.value:
                    inner = inner + str(aItem) + aEOLToken
                if self.fieldType != "SET":
                    result = result + indent(inner, 2)
                else:
                    result = result + inner
                result = result[: -len(aEOLToken)]
        else:
            result = result + str(self.value) + aEOLToken
        result = result + aEndToken
        return result

    def __str__(self):
        return self.toString()


class DelphiItem:
    def __init__(self):
        self.fields = []

    def toString(self, aIndent=0):
        result = "item\n"
        inner = ""
        for aField in self.fields:
            inner = inner + f"{aField[0]} = {aField[1]}\n"
        result = result + indent(inner, 2)
        result = result + "end"
        return indent(result, aIndent)

    def __str__(self):
        return self.toString()


def parseItems(lines):
    result = []
    currItem = None
    for line in lines:
        if len(line) == 0:
            continue
        tokens = line.lstrip().split()
        if tokens[0] == "item":
            currItem = DelphiItem()
        elif tokens[0] == "end" or tokens[0][0:-1] == "end":
            result.append(currItem)
        else:
            currItem.fields.append((tokens[0], tokens[2]))
    return result


def parseField(reader, aLine):
    aIndentation = getIndentation(aLine)
    tokens = aLine.lstrip().split(" ", 2)
    aField = DelphiField(tokens[0])
    aValue = tokens[2]
    if aValue[0] == "<":
        aField.fieldType = "ARRAY"
        aField.value = []
        itemLines = []
        if aValue[1] != ">":
            aBrackets = 0
            while True:
                line = reader.readline()
                itemLines.append(line)
                if len(line) == 0:
                    break
                if "<" in line:
                    aBrackets += 1
                if line[-2] == ">":
                    print(f"Brackets: {aBrackets}")
                    if aBrackets > 0:
                        aBrackets -= 1
                    else:
                        break
            items = parseItems(itemLines)
            aField.value = items

    elif aValue[0] == "[":
        aField.fieldType = "SET"
        if aValue[1] == "]":
            aField.value = []
        else:
            aField.value = aValue[1:-2].split(", ")
            if not isinstance(aField.value, list):
                aField.value = [aField.value]
    elif aValue[0] == "(":
        aField.fieldType = "STRINGS"
        aField.value = []
        if aValue[1] != ")":
            aCurrIndent = aIndentation
            eol = False
            while not eol:
                line = reader.readline()
                if len(line) == 0:
                    continue
                aCurrIndent = getIndentation(line)
                eol = line[-2] == ")"
                if eol:
                    line = line[:-1]
                aField.value.append(line.lstrip()[:-1])
    elif aValue[0] == "{":
        aField.fieldType = "DATA"
        aField.value = []
        if aValue[-2] == "}":
            aField.value.append(aValue[1:-2])
        elif aValue[1] != "}":
            eol = False
            while not eol:
                line = reader.readline()
                if len(line) == 0:
                    continue
                eol = line[-2] == "}"
                if eol:
                    line = line[:-1]
                aField.value.append(line.lstrip()[:-1])

    else:
        aTrimmedVal = aValue[:-1]
        if len(aTrimmedVal) == 0:
            aNewVal = "\n"
            aCurrIndent = aIndentation
            while True:
                line = reader.peek_line()
                if len(line) == 0:
                    reader.readline()
                    continue
                aCurrIndent = getIndentation(line)
                if aCurrIndent <= aIndentation:
                    break
                reader.readline()
                aNewVal = aNewVal + line.lstrip()
            aField.value = aNewVal
        else:
            aField.value = aValue[:-1]

    return aField


def parseObject(reader, aLine, aIndentation):
    lineTokens = aLine.lstrip().split()
    if lineTokens[1].endswith(":"):
        aObject = DelphiObject(lineTokens[1][:-1], lineTokens[2])
    else:
        aObject = DelphiObject("", lineTokens[1])
    print("--OBJECT: " + aObject.name)
    aObject.inherited = lineTokens[0] == "inherited"
    if len(lineTokens) > 3:
        aObject.tag = lineTokens[3]
    aCurrIndent = aIndentation
    while True:
        line = reader.readline()
        aCurrIndent = getIndentation(line)
        if aCurrIndent < aIndentation:
            break
        tokens = line.lstrip().split()
        if tokens[0] == "end":
            break
        print(tokens[0])
        if tokens[0] == "object" or tokens[0] == "inherited":
            aChild = parseObject(reader, line, aCurrIndent + 2)
            aObject.children.append(aChild)
        elif tokens[1] == "=":
            aField = parseField(reader, line)
            aObject.fields.append(aField)
            print("PARSED FIELD")
    return aObject

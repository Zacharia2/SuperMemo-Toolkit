import xml.etree.ElementTree as ET


def create_supermemo_element(parent_element, element_data):
    supermemo_element = ET.SubElement(parent_element, "SuperMemoElement")

    for key, value in element_data.items():
        if key == "SuperMemoElement":
            for sub_element_data in value:
                create_supermemo_element(supermemo_element, sub_element_data)
        elif key == "Content":
            content = ET.SubElement(supermemo_element, "Content")
            for sub_key, sub_value in value.items():
                sub_element = ET.SubElement(content, sub_key)
                sub_element.text = str(sub_value)
        else:
            sub_element = ET.SubElement(supermemo_element, key)
            sub_element.text = str(value)


def create_xml(data):
    root = ET.Element("SuperMemoCollection")

    count = ET.SubElement(root, "Count")
    count.text = str(len(data))

    for element_data in data:
        create_supermemo_element(root, element_data)

    tree = ET.ElementTree(root)
    tree.write("example.xml", encoding="utf-8", xml_declaration=True)


data = [
    {
        "ID": 1,
        "Title": "书籍名称",
        "Type": "Concept",
        "SuperMemoElement": [
            {
                "ID": 2,
                "Title": "标题",
                "Type": "Topic",
                "Content": {"Question": "问题", "Answer": "答案"},
            },
            {
                "ID": 3,
                "Title": "标题",
                "Type": "Topic",
                "Content": {"Question": "问题", "Answer": "答案"},
                "SuperMemoElement": [
                    {
                        "ID": 4,
                        "Title": "标题",
                        "Type": "Topic",
                        "Content": {"Question": "问题", "Answer": "答案"},
                    }
                ],
            },
        ],
    }
]

create_xml(data)

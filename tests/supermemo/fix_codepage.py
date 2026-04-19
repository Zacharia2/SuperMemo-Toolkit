#!/usr/bin/env python3
"""
insert_active_codepage.py
向 Windows 清单文件的 <asmv3:windowsSettings> 中插入 UTF-8 活动代码页声明。
"""

from lxml import etree

# 命名空间定义
NS_ASMV3 = "urn:schemas-microsoft-com:asm.v3"
NS_WIN_SETTINGS = "http://schemas.microsoft.com/SMI/2019/WindowsSettings"

# 注册命名空间前缀，使序列化输出更整洁（可选）
etree.register_namespace("asmv3", NS_ASMV3)
# 不为 activeCodePage 所在命名空间注册前缀，以便生成无前缀的 xmlns 属性


def insert_active_codepage(xml_path: str):
    """解析清单文件，插入 activeCodePage 元素。"""
    tree = etree.parse(xml_path, etree.XMLParser(remove_blank_text=True))
    root = tree.getroot()

    # 查找 <asmv3:windowsSettings>
    windows_settings = root.find(f".//{{{NS_ASMV3}}}windowsSettings")

    if windows_settings is None:
        # 若不存在，先查找或创建 <asmv3:application>
        application = root.find(f".//{{{NS_ASMV3}}}application")
        if application is None:
            # 根元素下直接创建 application 容器（通常清单已有，此处兜底）
            application = etree.SubElement(root, f"{{{NS_ASMV3}}}application")
        windows_settings = etree.SubElement(
            application, f"{{{NS_ASMV3}}}windowsSettings"
        )

    # 检查是否已存在 activeCodePage 元素（同一命名空间）
    existing = windows_settings.find(f".//{{{NS_WIN_SETTINGS}}}activeCodePage")
    if existing is not None:
        print("activeCodePage 元素已存在，跳过插入。")
    else:
        # 创建新元素：无前缀，带 xmlns 属性
        active_cp = etree.Element("activeCodePage", xmlns=NS_WIN_SETTINGS)
        active_cp.text = "UTF-8"
        windows_settings.append(active_cp)
        # 可选：将元素插入到其他设置之后，保持顺序（直接 append 到末尾）
        print("已插入 activeCodePage 元素。")

    # 写回文件，保留 XML 声明和 standalone 属性
    with open(xml_path, "wb") as f:
        # 自定义声明
        declaration = b'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'
        f.write(declaration)

        # 写入树内容，不输出声明，保持格式（pretty_print 可选）
        tree.write(f, encoding="UTF-8", xml_declaration=False, pretty_print=True)

    print(f"文件已保存至: {xml_path}")


if __name__ == "__main__":
    pass

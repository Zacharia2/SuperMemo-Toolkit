from bs4 import BeautifulSoup


def split_section(html, doc_id):
    soup = BeautifulSoup(html, "html.parser")
    elements_with_id = soup.find(id=doc_id)
    tag_name = elements_with_id.name
    # 获取带有id属性的元素
    element_with_id = soup.find(tag_name, id=doc_id)
    # 提取这一节内容
    # 把它自己（分割标记）也放进去。
    content = str(element_with_id)
    if element_with_id is not None:
        for sibling in element_with_id.find_next_siblings():
            if sibling.name == tag_name:
                break
            else:
                content += str(sibling)

    return content


def getContent(book, href):
    """输入文件href路径, 返回文件, 或者文件的节选。

    Args:
        href (str): 文件href路径


    Returns:
        str: 文件 或者 文件的节选。
    """
    # 若有锚点。说明是一个文件中的一节。
    # 用id属性的元素对应的tag分割文档。
    # resolve ：暂时忽略锚点的情况:'Text/Section0001_0012.xhtml#toc_1
    if href.find("#") != -1:
        doc_id = href.split("#")[-1]
        doc_href = href.split("#")[0]
        doc = book.get_item_with_href(doc_href)
        # 分割文本
        section = split_section(doc.content.decode("utf-8"), doc_id)
        # SuperMemo接受任意的超文本。
        return section
    else:
        # 没有锚点。说明是一个文件。
        doc = book.get_item_with_href(href)
        if doc:
            Content = doc.content.decode("utf-8")
        else:
            Content = ""
    return Content

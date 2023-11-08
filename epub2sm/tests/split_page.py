from bs4 import BeautifulSoup

html = """
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title></title>
  <link href="../Styles/stylesheets.css" rel="stylesheet" type="text/css"/>
</head>

<body>
  <h1 class="firstTitle">引言</h1>
  <p class="quotation">真正清醒自主的个人成长</p>
  <p class="content">真正清醒自主的个人成长</p>

  <h3 class="thirdTitle sigil_not_in_toc" id="toc_1">创建StevePavlina.com网站</h3>
  <p class="content">真正清醒自主的个人成长</p>
  <p class="content">真正清醒自主的个人成长</p>
  
  <h3 class="thirdTitle sigil_not_in_toc" id="toc_2">聪明人的个人成长，到底指什么</h3>
  <p class="content">真正清醒自主的个人成长</p>
  <div class="border">
    <p class="quotation">一体=真实+爱</p>
  </div>
  <p class="content">由此我们最终得出：<span class="bold">真正清醒自主的个人成长，就是让人能够更好地遵循真实、爱与能量这些基础原则的成长。</span></p>
<chapterlast></chapterlast></body>
</html>
"""


def split_section(html, doc_id):
    soup = BeautifulSoup(html, "html.parser")
    elements_with_id = soup.find(id=doc_id)
    tag_name = elements_with_id.name
    # 获取带有id属性的元素
    element_with_id = soup.find(tag_name, id=Id)
    # 提取这一节内容
    content = ""
    if element_with_id is not None:
        for sibling in element_with_id.find_next_siblings():
            if sibling.name == tag_name:
                break
            else:
                content += str(sibling)

    return content


soup = BeautifulSoup(html, "html.parser")
Ids = ["toc_1", "toc_2"]
# 获取带有id属性的元素
# elements_with_id = soup.find_all("h3", id=True)

for Id in Ids:
    print(split_section(html, Id))

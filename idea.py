Element = dict(ID='',
               Title='',
               Type='',
               Content={
                   'Question': '',
                   'Answer': ''
               },
               SuperMemoElement={})
# Element['Content'] = dict(Question='',Answer='')



# mXML_Element['ID'].text = 'dfadfa'

# Id = SubElement(SuperMemoElement, 'ID')
# Title = SubElement(SuperMemoElement, 'Title')
# Type = SubElement(SuperMemoElement, 'Type')

# Content = SubElement(SuperMemoElement, 'Content')
# Question = SubElement(Content, 'Question')
# Answer = SubElement(Content, 'Answer')

# 这个可能需要独立的方法
# Sub_SuperMemoElement = SubElement(SuperMemoElement, 'SuperMemoElement')

# 关于赋值可能由字典的值决定。
# Id.text = '1'
# Question.text ='Question Content'
# Answer.text = 'Answer Content'




# # 获取书籍的toc信息
# toc = book.toc

# # 创建字典用于保存层级关系
# doc_dict = defaultdict(list)


# # 递归遍历toc信息，获取文档并保存到字典中
# def get_documents(chapters, parent=""):
#     for chapter in chapters:
#         if isinstance(chapter, epub.Link) or isinstance(chapter, epub.Section):
#             title = chapter.title
#             doc_href = chapter.href
#             doc = book.get_item_with_href(doc_href)
#             doc_content = doc.content.decode("utf-8")  # 获取文档内容
#             doc_dict[parent].append({title: doc_content})
#         if isinstance(chapter, tuple):
#             get_documents(chapter, title)


# # 获取文档并保存到字典中
# get_documents(toc)

# # 打印字典结构
# def print_doc_dict(doc_dict, node="", level=0):
#     if node not in doc_dict:
#         return
#     indent = "  " * level
#     for doc in doc_dict[node]:
#         title = list(doc.keys())[0]
#         content = doc[title]
#         print(f"{indent}- {title}")
#         print(f"{indent}  {content}")
#         print_doc_dict(doc_dict, node=title, level=level + 1)


# # 输出字典结构
# print_doc_dict(doc_dict)
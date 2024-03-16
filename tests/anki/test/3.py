from bs4 import BeautifulSoup
from pyquery import PyQuery as pq

html = """
☀ <span class="category">**国家 国土：**</span>
<span class="vocabulary">**country**</span> ['kʌntrɪ] 
<span class="definition">n. [C] 国家、国。是此义的基础用词，使用范围最广：</span>beautiful, great country 美丽的国家；伟大的国家 / developed country 发达国家 / home, native, own country 祖国 / host country 东道国 / neighbouring/neighboring country 邻国 / sovereign country（尤美）主权国家 / neutral country 中立国 / Western country 西方国家 / English-speaking country 讲英语的国家 / member country 成员国 / socialist country 社会主义国家 / I love my country. 我爱我的祖国。/ The two countries signed a basic treaty of cooperation. 两国签署了一项基本的合作条约。/ Over 30 countries participated in the Games. 有30多个国家参加了这次运动会。
"""

# 使用BeautifulSoup解析HTML
soup = BeautifulSoup(html, "lxml")

# 找到特定的元素
link1 = soup.find("span", class_="category")

# 获取该元素之后的裸文本
# .next_sibling可以获得元素的下一个兄弟节点
# .strip()用于去除字符串首尾的空白字符
# 如果下一个兄弟节点不是文本节点，则递归查找直到找到文本节点为止
bare_text_after_link1 = link1.next_sibling.strip()
while bare_text_after_link1 and not bare_text_after_link1.strip():
    bare_text_after_link1 = bare_text_after_link1.next_sibling.strip()

print(bare_text_after_link1)

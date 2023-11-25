from bs4 import BeautifulSoup


doc = "&#36229;&#38142;&#25509; &lt;a&gt;...&lt;/a&gt; &#12289;&#23556;&#39057;&#35782;&#21035;&#25216;&#26415; RFID"

# 超链接 <a>...</a> 、射频识别技术 RFID
# &#36229;&#38142;&#25509; &lt;a&gt;...&lt;/a&gt; &#12289;&#23556;&#39057;&#35782;&#21035;&#25216;&#26415; RFID
# MarkupResemblesLocatorWarning: The input looks more like a filename than markup. You may want to open this file and pass the filehandle into Beautiful Soup.

soup = BeautifulSoup(doc, "html.parser")

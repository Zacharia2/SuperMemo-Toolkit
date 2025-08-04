# tcomp

NodeAsText，是一个很好的转移卡片的方式，可以完整的携带所有信息包括引用，所以非常有修复价值。

三个乱码部分位于

1. ParentTitle
2. Begin ElementInfo -> Title
3. Begin Component -> HTMName

~~选中分支，处理分支，导出为文本，勾选ID和Title。不，也不完全可以。他不导出folder元素。不选。~~


- 阅读复习（ROOT）（node没有这个）
  - 推送阅读（Parent）
  - 五种时间：重建人生秩序（Children，往下都正常）


有一个好消息是NodeAsText是前序排列，这样文档目录也使用前序排列，文档目录对齐NodeAsText（倒序对齐）
最终生成列表。这样更容易。

写一个解析文档目录的程序，然后转换为有序列表。
NodeAsText解析后读取ID，形成一个列表
然后从后往前对应。删除多余文档目录生成的列表。最后映射起来就好
作为下一步的内容补丁。


XML也用Table of contents修复吧。把XML元素引用前序排列（已验证是前序排列。有序的，因为图书导入就是有序的）变成列表，然后和列表化的
Table of contents一一对应即可。
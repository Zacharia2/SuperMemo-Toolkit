# tcomp

SuperMemo 导出时，可以携带 SuperMemoReference。可以利用这个对重建 SuperMemo 导出集合的 title。

```xml
<Question> 12.3.7 向接收单位移交档案时，应编制移交清单，移交、接收双方应签字并盖章后方可交接。<br><br><hr>
    <SuperMemoReference>
        <H5 dir='ltr' align='left'>
        <Font size="1" style="color: transparent">#SuperMemo Reference:</Font>
        <br>
        <FONT class= 'reference'>
            #Title: 12 工程计价成果与档案管理 : 12.3 工程计价档案<br>
            #Date: Imported on Apr 30, 2025,06:31:18<br>
            #Source: Edge import<br>
            #Link: <a href="file://F:/标准文件/GBT50500-2024建设工程工程量清单计价标准_可搜索.pdf">file://F:/标准文件/GBT50500-2024建设工程工程量清单计价标准_可搜索.pdf</a>
        </FONT>
    </SuperMemoReference>
</Question>
```

导出为文档形式会导出一个目录，一个所有元素的列表。他们唯一共同之处就是标题一样。
所以可以用标题作为索引构建 XML 文档。

NodeAsText，是一个很好的转移卡片的方式，可以完整的携带所有信息包括引用，所以非常有修复价值。

三个乱码部分位于

1. ParentTitle
2. Begin ElementInfo -> Title
3. Begin Component -> HTMName

Title、ParentTitle 可以从

- 导出为文档中获得，（目录全，列表不全）
- XML（Title无法从这个中补齐。）但是有树的结构可以获得ID。配合文档目录合并树试试。
- NodeAsText，HTMName：HTML 内容的前 50 字符（一定有）
- NodeAsText拥有的 Reference 获得。(可能没有)。不用了。

文档目录构建树 合并 XML的ID树，最后 输出 ID->Title列表。

有一个好消息是NodeAsText是前序排列，这样文档目录也使用前序排列，并对其NodeAsText。这样更容易。


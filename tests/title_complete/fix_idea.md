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
NodeAsText 包含 Reference，有 Reference 可以用 Reference 修复自己乱码的一部分。还需要别的，比如 XML 有标题的修复他。然后还需要导出为文档修复他。

三个乱码部分位于 1. Begin Component>HTMName、2. Begin ElementInfo>Title、3. ParentTitle

HTMName可以读取HTML内容的前50字符作为名字。Title、ParentTitle可以从XML Title和导出为文档中获得，以及自己拥有的Reference获得。

导出为文档也修复，导出为 XML 的标题问题。因为他们都有 ID。只需要找 ID 对应的即可。

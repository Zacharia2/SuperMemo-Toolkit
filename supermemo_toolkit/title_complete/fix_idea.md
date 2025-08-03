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


[TODO] 用导出为文档修复，XML，NodeAsText 他们的标题乱码问题。

导出为文档形式会导出一个目录，一个所有元素的列表。他们唯一共同之处就是标题一样。
所以可以用标题作为索引构建XML文档。

导出为文档，中 一个所有元素的列表包含`Topic #1,847: 学习就是调整心理模型的参数`,所以可以用来修复导出为源码的NodeAsText文档。不仅要修复自己的Title，也要修复ParentTitle。ParentTitle有Parent这个ID。

导出为文档也修复，导出为XML的标题问题。因为他们都有ID。只需要找ID对应的即可。

# supermemo-toolkit(smtk)

SuperMemo工具组件，增强工具。

功能说明、下载安装使用文档：https://docs.qq.com/doc/DQnRpb0VNUEVvR3dl

## PathPix

> supermemo图链整理工具。

PathPix：任意类型的网络图片整理为受支持的五种格式的图片，并网络和本地图片收集起来转换为相对路径，存放在elements文件夹中。

其中，网页内嵌图片由pathpix管理，元素注册表图片由图片注册表管理。pathpix管理的图片文件，可以导入图片注册表中。

## E2SM

![](./docs/Snipaste_2024-01-17_08-43-18.png)

从epub图书生成xml格式的sm-book图书。

生成的书籍图片文件夹放到SM集合的`elements/local_pic`文件夹下即可。

```pwsh
smtk e2sm -t epub_file out_folder  #（需要图书有良好的目录，没有需使用calibre生成并整理目录）
smtk e2sm -l epub_file out_folder  #（有书即可，不按照EPUB目录文件生成，而是按照EPUB图书内文档文件的线性顺序生成，比较适合PDF版epub，效果查看文件：./docs/Snipaste_2024-03-24_09-17-23.png）
```

## latex2img

latex 公式转图片。

```
smtk imtex <formula_text> <outpath>
smtk imtex "$\sum_{i=0}^\infty x_i$" ./a.png
```

## Install



## LICENSE

本软件遵守开源协议，协议类型为：GPLv2。

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Zacharia2/SuperMemo-Toolkit&type=Date)](https://star-history.com/#Zacharia2/SuperMemo-Toolkit&Date)

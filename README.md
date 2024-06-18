# supermemo-toolkit(smtk)

SuperMemo 增强工具（CLI命令行）。包含图链整理、EPUB图书转换导入、Latex公式转图片等。

功能说明、下载安装使用文档：https://docs.qq.com/doc/DQnRpb0VNUEVvR3dl

## PathPix

> supermemo图链整理工具。

PathPix：任意类型的网络图片整理为受支持的五种格式的图片，并网络和本地图片收集起来转换为相对路径，存放在elements文件夹中。

其中，网页内嵌图片由pathpix管理，元素注册表图片由图片注册表管理。pathpix管理的图片文件，可以导入图片注册表中。

## E2SM

![](./docs/Snipaste_2024-01-17_08-43-18.png)

从epub图书生成xml格式的sm-book图书。

生成的**书籍图片文件夹**放到SM集合的`your_collection/elements/local_pic`文件夹下即可。

一般情况下集合默认全路径为：`Root_SuperMemo/systems/your_collection`。

无论怎样，只需要将**图片文件夹**放在你的集合文件夹下的`elements/local_pic`文件夹中。

```pwsh
smtk e2sm --toc epub_file out_folder  #（需要图书有良好的目录，没有需使用calibre生成并整理目录）
smtk e2sm --linear epub_file out_folder  #（有书即可，不按照EPUB目录文件生成，而是按照EPUB图书内文档文件的线性顺序生成，比较适合PDF版epub，效果查看文件：./docs/Snipaste_2024-03-24_09-17-23.png）
smtk e2sm --topic epub_file out_folder  #（有书即可，EPUB转换为一个SuperMemo Topic，一本书即是一篇文章，配合SuperMemo阅读点使用更佳。）
```

## latex2img

latex 公式转图片。

```
smtk imtex <formula_text> <outpath>
smtk imtex "$\sum_{i=0}^\infty x_i$" ./a.png
```

## Install

pipx：python whl格式软件包安装管理器。pipx安装应用请务必联网。

### 安装步骤：

1. 安装Python最新版，目前版本是3.12.2
2. 安装pipx最终独立Python应用安装管理器，通过pip（要求版本 ≥ v19.0）：`python3 -m pip install --user pipx`
   1. 配置pipx，执行ensurepath。
   2. pipx程序所在文件夹：`<USER folder>\AppData\Roaming\Python\Python3x\Scripts`
   3. 转到上述文件夹，执行`.\pipx.exe ensurepath`，将上述路径和文件夹添加到您的搜索路径中。
   4. 重新启动您的终端会话并输入pipx命令验证是否运行。
3. 下载`supermemo_toolkit-py3-none-any.whl`
4. 执行`pipx install supermemo_toolkit-py3-none-any.whl`等待安装成功。
5. 安装成功后，可以执行`smtk`命令验证是否安装成功。

问题1：若出现ERROR: No matching distribution found for XXX，一般是网络问题，切换PYPI源即可，可以使用下列方式切换PYPI源。

```bash
# 切换阿里源
pip config set global.index-url http://mirrors.aliyun.com/pypi/simple/
pip config set install.trusted-host mirrors.aliyun.com
# 换回默认源
pip config unset global.index-url
```

问题2：执行`python3 -m pip`报错：No module named 'pip'，可以通过下列方式解决。

```bash
python -m ensurepip

python -m pip install --upgrade pip
```

### 关于更新：

同样使用pipx应用安装管理器，执行`pipx install save-path/your-app.whl --force`显示成功后即可更新成功。

## LICENSE

本软件遵守开源协议，协议类型为：GPLv2。

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=Zacharia2/SuperMemo-Toolkit&type=Date)](https://star-history.com/#Zacharia2/SuperMemo-Toolkit&Date)

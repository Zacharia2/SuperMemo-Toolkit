# SuperMemoKit

SuperMemo工具组件


## PathPix

> supermemo图链整理小工具。

PathPix功能说明、下载安装使用文档：https://docs.qq.com/doc/DQnRpb0VNUEVvR3dl

网页内嵌图片由pathpix管理，元素注册表图片由图片注册表管理。pathpix管理的图片文件，可以导入图片注册表中。

## subTree 方式

```bash
# 简化远程子仓库地址,设置别名
git remote add -f pathpix https://github.com/Zacharia2/pathpix.git
# 添加 subtree
git subtree add --prefix=pathpix pathpix main 
# 从源仓库拉取更新 subtree
git subtree pull --prefix=pathpix https://github.com/Zacharia2/pathpix.git main 
git subtree pull --prefix=pathpix pathpix main 
# 推送修改到源仓库
git subtree pull --prefix=pathpix pathpix main --squash
git subtree push --prefix=pathpix pathpix main 
```
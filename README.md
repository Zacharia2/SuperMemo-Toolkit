# SuperMemoKit

SuperMemo工具组件


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
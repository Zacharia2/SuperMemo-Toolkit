json.decoder.JSONDecodeError: Invalid \\escape: line 1 column 1 (char 1)

### 异常解读

该异常的格式一般为：

json.decoder.JSONDecodeError: Invalid \\escape: line 1 column 1 (char 1)  
注意后面的数字 line 123456789(数字可以为任意值)， column 123456789(数字可以为任意值)，char 123456789 (数字可以为任意值)

异常的中文释义:  
JSONDecodeError（JSON 解码错误）`Invalid \escape`：无效字符反斜线 ，也就是说你的待格式字符串中包含一个`\`

该异常一般出现在 JSON 格式化的情况下，如果 JSON 中出现特殊字符易出现该 BUG。

### 异常解决方案

解决办法非常简单，通过字符串替换函数，将反斜线`\`替换掉即可。

```python
s = json_str.replace('\\', '\\\\')
db = json.loads(s)
```

此类问题解决方案相对一致，其余字符类可以参照此问题的解决方案，模仿即可。

### 附录

本系列文章只供记录 Python 日常开发过程中 偶遇 BUG，提供给学生作为参考数据与解决方案用，属于记录型博客，查阅到的读者希望可解决你的问题。

错误提示样板，可以与你的错误进行比对。

```python
Traceback (most recent call last):
  File "g:/MyFiles/xiaoke/idnex2.py", line 25, in <module>
    get_db()
  File "g:/MyFiles/xiaoke/idnex2.py", line 20, in get_db
    db = json.loads(json_db)
  File "F:\P3.6\lib\json\__init__.py", line 354, in loads
    return _default_decoder.decode(s)
  File "F:\P3.6\lib\json\decoder.py", line 339, in decode
    obj, end = self.raw_decode(s, idx=_w(s, 0).end())
  File "F:\P3.6\lib\json\decoder.py", line 355, in raw_decode
    obj, end = self.scan_once(s, idx)
json.decoder.JSONDecodeError: Invalid \escape: line 32397 column 33 (char 836514)
```
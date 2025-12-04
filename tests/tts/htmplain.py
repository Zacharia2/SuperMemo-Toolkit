# import html2text
from bs4 import BeautifulSoup

html_doc = """
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HTML 标签综合测试页面</title>
    <meta name="description" content="这是一个用于测试HTML解析的页面">
    <style>
        /* CSS样式 - 理想情况下应被忽略 */
        body { font-family: sans-serif; }
        .hidden { display: none; }
    </style>
    <script type="application/javascript">
        // JavaScript脚本 - 理想情况下应被忽略
        console.log("这是一个脚本块");
    </script>
</head>
<body>

    <header>
        <h1>这是一个主标题 (H1)</h1>
        <nav>
            <ul>
                <li><a href="#section1">链接到第一部分</a></li>
                <li><a href="https://example.com" target="_blank">外部链接</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section id="section1">
            <h2>文本与语义标签 (H2)</h2>
            <p>这是一个段落，包含 <b>粗体</b>、<i>斜体</i>、<mark>高亮</mark>、<code>代码</code>、<sup>上标</sup> 和 <sub>下标</sub> 文本。</p>
            <blockquote>
                "这是一个引用块，用于展示一段独立的引述。"
            </blockquote>
            <pre>
预格式化文本
    保留空格和换行。
            </pre>
            <hr>
            <address>
                联系方式：contact@example.com
            </address>
        </section>

        <section>
            <h2>列表 (H2)</h2>
            <h3>无序列表 (H3)</h3>
            <ul>
                <li>咖啡</li>
                <li>茶
                    <ul>
                        <li>绿茶</li>
                        <li>红茶</li>
                    </ul>
                </li>
                <li>牛奶</li>
            </ul>
            <h3>有序列表 (H3)</h3>
            <ol>
                <li>第一步</li>
                <li>第二步</li>
                <li>第三步</li>
            </ol>
        </section>

        <section>
            <h2>表格 (H2)</h2>
            <table border="1">
                <caption>用户信息表</caption>
                <thead>
                    <tr>
                        <th>姓名</th>
                        <th>年龄</th>
                        <th>城市</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>张三</td>
                        <td>28</td>
                        <td>北京</td>
                    </tr>
                    <tr>
                        <td>李四</td>
                        <td>34</td>
                        <td>上海</td>
                    </tr>
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="3">共2位用户</td>
                    </tr>
                </tfoot>
            </table>
        </section>

        <section>
            <h2>表单 (H2)</h2>
            <form action="/submit" method="post">
                <fieldset>
                    <legend>个人信息</legend>
                    <label for="username">用户名:</label>
                    <input type="text" id="username" name="username" placeholder="请输入用户名">
                    <br><br>
                    <label for="password">密码:</label>
                    <input type="password" id="password" name="password">
                    <br><br>
                    <label for="email">邮箱:</label>
                    <input type="email" id="email" name="email" value="test@example.com" readonly>
                    <br><br>
                    <input type="hidden" name="csrf_token" value="secret_token">
                </fieldset>
                <br>
                <fieldset>
                    <legend>选择项</legend>
                    <input type="checkbox" id="subscribe" name="subscribe" checked>
                    <label for="subscribe">订阅邮件</label>
                    <br>
                    <input type="radio" id="male" name="gender" value="male">
                    <label for="male">男</label>
                    <input type="radio" id="female" name="gender" value="female">
                    <label for="female">女</label>
                    <br><br>
                    <label for="city">城市:</label>
                    <select id="city" name="city">
                        <optgroup label="中国">
                            <option value="beijing" selected>北京</option>
                            <option value="shanghai">上海</option>
                        </optgroup>
                        <optgroup label="美国">
                            <option value="newyork">纽约</option>
                        </optgroup>
                    </select>
                    <br><br>
                    <label for="bio">个人简介:</label><br>
                    <textarea id="bio" name="bio" rows="4" cols="50">这里是默认文本。</textarea>
                </fieldset>
                <br>
                <button type="submit">提交</button>
                <button type="reset">重置</button>
            </form>
        </section>

        <div class="hidden">
            这个 div 的 class 是 "hidden"，CSS 可能会隐藏它。它的内容应该被提取吗？
        </div>

    </main>

    <footer>
        <p>&copy; 2023 测试页面。所有权利保留。</p>
    </footer>

</body>
</html>

"""

# 1. 创建 BeautifulSoup 对象，指定解析器
soup = BeautifulSoup(html_doc, "lxml")

# 2. 获取 <body> 标签内的所有文本
#    这是最常用的方式，因为它会自动忽略 <head> 中的脚本和样式
body_text = soup.get_text(separator="\n", strip=True)

# 3. 打印结果
print(body_text)


# text_maker = html2text.HTML2Text()
# text_maker.ignore_links = True
# text_maker.bypass_tables = False
# text_maker.ignore_images = True
# text_maker.ignore_emphasis = True

# parsedText = text_maker.handle(html_doc).translate(str.maketrans("#*-", "   "))
# print(parsedText)
# pass

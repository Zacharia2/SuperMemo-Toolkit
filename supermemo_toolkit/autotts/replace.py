import html
import unicodedata

import regex

# ===== 纯文本 / 符号替换（无需正则，固定字面量） =====
replace_list: list[tuple[str, str]] = [
    # 图片/插图占位符
    ("[...]", "，什么，"),
    # 注释/脚注标记（固定写法）
    ("[footnote]", "，注，"),
    ("[/footnote]", ""),
    ("[note]", "，注释，"),
    ("[/note]", ""),
    # 引用标记
    ("[quote]", "，引用，"),
    ("[/quote]", ""),
    ("[blockquote]", "，引用，"),
    ("[/blockquote]", ""),
    # 特殊标点/符号
    ("«", ""),
    ("»", ""),
    ("„", ""),
    ("“", ""),
    ("”", ""),
    # 书名号：直接去掉，保留书名内容；不再绕成引号再删
    ("《", ""),
    ("》", ""),
    ("「", ""),
    ("」", ""),
    ("『", ""),
    ("』", ""),
    ("‹", ""),
    ("›", ""),
    ("──", ""),
    ("※", "参见"),
    ("☆", ""),
    ("★", ""),
    ("●", ""),
    ("○", ""),
    ("◆", ""),
    ("■", ""),
    ("□", ""),
    ("△", ""),
    # 花朵 / 装饰符（TTS 无意义，直接删）
    ("❀", ""),
    ("✿", ""),
    ("❁", ""),
    ("✾", ""),
    ("❃", ""),
    ("❋", ""),
    ("✽", ""),
    ("✼", ""),
    ("❊", ""),
    ("❉", ""),
    ("✻", ""),
    ("✺", ""),
    ("❆", ""),
    ("❄", ""),
    ("✤", ""),
    ("✣", ""),
    ("✢", ""),
    ("✱", ""),
    ("✲", ""),
    ("✳", ""),
    ("✴", ""),
    ("✵", ""),
    # 数学/逻辑符号
    ("→", " 到 "),
    ("←", " 来自 "),
    ("↑", ""),
    ("↓", ""),
    ("⇒", " 因此 "),
    ("∀", ""),
    ("∃", ""),
    ("∈", ""),
    ("⊂", ""),
    ("∞", " 无穷 "),
    ("±", " 正负 "),
    ("×", " 乘 "),
    ("÷", " 除 "),
    ("≤", " 小于等于 "),
    ("≥", " 大于等于 "),
    ("≠", " 不等于 "),
    ("∫", ""),
    ("∑", ""),
    ("∏", ""),
    # 希腊字母
    ("α", "阿尔法"),
    ("β", "贝塔"),
    ("γ", "伽马"),
    ("δ", "德尔塔"),
    ("π", "派"),
    ("φ", "斐"),
    ("ω", "欧米伽"),
    ("θ", "西塔"),
    ("λ", "拉姆达"),
    ("μ", "缪"),
    ("σ", "西格玛"),
    ("τ", "陶"),
    ("η", "伊塔"),
    ("ξ", "克西"),
    ("ζ", "泽塔"),
    ("ν", "纽"),
    ("ρ", "罗"),
    ("υ", "宇普西龙"),
    ("κ", "卡帕"),
    ("χ", "希"),
    ("ψ", "普西"),
    ("ε", "艾普西龙"),
    # 版权/前言信息（中文，直接替换的短词已移出行首锚定规则）
    ("©", ""),
    ("®", ""),
    ("™", ""),
    ("§", ""),
    ("¶", ""),
    ("´", ""),
    ("¨", ""),
    ("ˆ", ""),
    ("˜", ""),
    ("•", ""),
    ("·", ""),
    # 版权/前言信息（英文长词，正文误命中概率低，保持直接替换）
    ("Copyright", ""),
    ("All rights reserved", ""),
    ("LCCN", ""),
    ("DOI", ""),
    ("Library of Congress", ""),
    ("British Library", ""),
    ("Cataloguing in Publication", ""),
    ("Printed in", ""),
    ("Published by", ""),
    ("First edition", ""),
    ("Reprint", ""),
    (" Paperback", ""),
    ("Hardcover", ""),
    # 目录相关（英文长词/全大写，直接替换）
    ("CONTENTS", ""),
    ("Table of Contents", ""),
    ("CONTINUE", ""),
    ("NEXT", ""),
    ("PREVIOUS", ""),
    ("BACK", ""),
    ("HOME", ""),
    # 页眉页脚（全大写/首字母大写，直接替换）
    ("HEADER", ""),
    ("FOOTER", ""),
    # 广告/推荐（英文长词，直接替换）
    ("ADVERTISEMENT", ""),
    ("Also by", ""),
    ("Excerpt from", ""),
    ("Look inside", ""),
    ("Preview", ""),
    # HTML 实体（固定小写字面量，直接替换即可）
    ("&amp;", "和"),
    ("&lt;", ""),
    ("&gt;", ""),
    ("&quot;", ""),
    ("&apos;", ""),
    ("&nbsp;", ""),
    ("&mdash;", "——"),
    ("&ndash;", "–"),
    ("&hellip;", "…"),
    ("&laquo;", ""),
    ("&raquo;", ""),
    ("&lsquo;", ""),
    ("&rsquo;", ""),
    ("&ldquo;", ""),
    ("&rdquo", ""),
    ("&bull;", ""),
    ("&middot;", ""),
    ("&copy;", ""),
    ("&reg;", ""),
    ("&trade;", ""),
    ("&euro;", "欧元"),
    ("&pound;", "英镑"),
    ("&yen;", "日元"),
    ("&cent;", "分"),
    ("&sect;", ""),
    ("&para;", ""),
    ("&deg;", "度"),
    ("&acute;", ""),
    ("&uml;", ""),
    ("&circ;", ""),
    ("&tilde;", ""),
    ("&ensp;", ""),
    ("&emsp;", ""),
    ("&thinsp;", ""),
    # ---- 分数符号 ----
    ("½", "二分之一"),
    ("⅓", "三分之一"),
    ("⅔", "三分之二"),
    ("¼", "四分之一"),
    ("¾", "四分之三"),
    ("⅛", "八分之一"),
    ("⅜", "八分之三"),
    ("⅝", "八分之五"),
    ("⅞", "八分之七"),
    # ---- 温度符号（中文行兜底；英文行由函数优先处理） ----
    ("°C", "摄氏度"),
    ("°F", "华氏度"),
    ("℃", "摄氏度"),
    ("℉", "华氏度"),
    ("°", "度"),
    # ---- 拉丁缩写展开 ----
    ("e.g.", "for example"),
    ("i.e.", "that is"),
    ("etc.", "et cetera"),
    ("vs.", "versus"),
    ("cf.", "compare"),
    ("et al.", "and others"),
    ("viz.", "namely"),
    ("ca.", "circa"),
    ("vol.", "volume"),
    ("Dr.", "Doctor"),
    ("Mr.", "Mister"),
    ("Mrs.", "Missus"),
    ("Ms.", "Miss"),
    ("Jr.", "Junior"),
    ("Sr.", "Senior"),
    # ---- 常见度量衡缩写（英文） ----
    (" km", " kilometers"),
    (" cm", " centimeters"),
    (" mm", " millimeters"),
    (" µm", " micrometers"),
    (" nm", " nanometers"),
    (" kg", " kilograms"),
    (" mg", " milligrams"),
    (" ml", " milliliters"),
    (" mL", " milliliters"),
    (" Hz", " hertz"),
    (" kHz", " kilohertz"),
    (" MHz", " megahertz"),
    (" GB", " gigabytes"),
    (" MB", " megabytes"),
    (" KB", " kilobytes"),
    (" TB", " terabytes"),
]

# ===== 正则替换（仅标签类 / HTML，含字母的忽略大小写） =====
regex_replace_list: list[tuple[regex.Pattern[str], str]] = [
    # ===== HTML 文档头 / 注释 / 脚本整段删除（最优先） =====
    (regex.compile(r"(?is)<!DOCTYPE[^>]*>"), ""),
    (regex.compile(r"(?is)<!--.*?-->"), ""),
    (regex.compile(r"(?is)<head\b[^>]*>.*?</head>"), ""),
    (regex.compile(r"(?is)<title\b[^>]*>.*?</title>"), ""),
    (regex.compile(r"(?is)<meta\b[^>]*/?>"), ""),
    (regex.compile(r"(?is)<style\b[^>]*>.*?</style>"), ""),
    (regex.compile(r"(?is)<script\b[^>]*>.*?</script>"), ""),
    (regex.compile(r"(?is)<link\b[^>]*/?>"), ""),
    # ===== 中文页眉/目录/广告等短词：只删除独立成行的，避免误伤正文 =====
    (regex.compile(r"(?m)^\s*版权信息\s*$"), ""),
    (regex.compile(r"(?m)^\s*版权所有\s*$"), ""),
    (regex.compile(r"(?m)^\s*目\s*录\s*$"), ""),
    (regex.compile(r"(?m)^\s*广告\s*$"), ""),
    (regex.compile(r"(?m)^\s*推荐\s*$"), ""),
    (regex.compile(r"(?m)^\s*节选自\s*$"), ""),
    # ===== 英文页码/页眉：只删除独立成行的 =====
    (regex.compile(r"(?im)^\s*Page\s+\d+\s*$"), ""),
    (regex.compile(r"(?im)^\s*Page\s*$"), ""),
    # ===== 拼音注音删除（命中条件：括号内含带声调的拉丁元音） =====
    (
        regex.compile(
            r"[（(][^（()）\n]*[āáǎàēéěèīíǐìōóǒòūúǔùǖǘǚǜêńňǹ][^（()）\n]*[）)]"
        ),
        "",
    ),
    # ===== 行内格式标签（strong/b/i/em/u/font/small/big/mark/del/ins/strike） =====
    (regex.compile(r"(?i)</?strong\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?b\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?i\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?em\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?u\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?font\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?small\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?big\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?mark\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?del\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?ins\b[^>]*>"), ""),
    (regex.compile(r"(?i)</?strike\b[^>]*>"), ""),
    # ===== 空段落处理（必须在 <p> / <br/> 规则之前，避免产生 "。，" 噪音） =====
    (regex.compile(r"(?i)<p\b[^>]*>\s*<br\s*/?>\s*</p>"), "。"),
    # ===== 方括号标签 =====
    (regex.compile(r"(?i)\[img\]"), "，插图，"),
    (regex.compile(r"(?i)\[/img\]"), ""),
    (regex.compile(r"(?i)\[image\]"), "，图片，"),
    (regex.compile(r"(?i)\[/image\]"), ""),
    (regex.compile(r"(?i)\[figure\]"), "，插图，"),
    (regex.compile(r"(?i)\[/figure\]"), ""),
    (regex.compile(r"(?i)\[picture\]"), "，图片，"),
    (regex.compile(r"(?i)\[/picture\]"), ""),
    # 超链接
    (regex.compile(r"(?i)\[url\]"), ""),
    (regex.compile(r"(?i)\[/url\]"), ""),
    (regex.compile(r"(?i)\[link\]"), ""),
    (regex.compile(r"(?i)\[/link\]"), ""),
    # 脚注（固定写法 + 变体）
    (regex.compile(r"(?i)\[fn\]"), ""),
    (regex.compile(r"(?i)\[/fn\]"), ""),
    (regex.compile(r"\[\^[^\]]*\]"), ""),  # [^1]、[^abc]、[^*]
    (regex.compile(r"\^\[[^\]]*\]"), ""),  # ^[1]、^[abc]
    (regex.compile(r"\[\d+\]"), ""),  # [1]、[2]、[123] 上标引用
    # 元数据/标题
    (regex.compile(r"(?i)\[title\]"), ""),
    (regex.compile(r"(?i)\[/title\]"), ""),
    (regex.compile(r"(?i)\[author\]"), ""),
    (regex.compile(r"(?i)\[/author\]"), ""),
    (regex.compile(r"(?i)\[date\]"), ""),
    (regex.compile(r"(?i)\[/date\]"), ""),
    (regex.compile(r"(?i)\[publisher\]"), ""),
    (regex.compile(r"(?i)\[/publisher\]"), ""),
    # 目录/导航/分页
    (regex.compile(r"(?i)\[toc\]"), ""),
    (regex.compile(r"(?i)\[/toc\]"), ""),
    (regex.compile(r"(?i)\[nav\]"), ""),
    (regex.compile(r"(?i)\[/nav\]"), ""),
    (regex.compile(r"(?i)\[pagebreak\]"), "。"),
    (regex.compile(r"(?i)\[/pagebreak\]"), ""),
    (regex.compile(r"(?i)\[pb\]"), ""),
    (regex.compile(r"(?i)\[/pb\]"), ""),
    (regex.compile(r"(?i)\[page\]"), ""),
    (regex.compile(r"(?i)\[/page\]"), ""),
    # 章节/段落
    (regex.compile(r"(?i)\[chapter\]"), ""),
    (regex.compile(r"(?i)\[/chapter\]"), ""),
    (regex.compile(r"(?i)\[section\]"), ""),
    (regex.compile(r"(?i)\[/section\]"), ""),
    (regex.compile(r"(?i)\[paragraph\]"), ""),
    (regex.compile(r"(?i)\[/paragraph\]"), ""),
    # 公式/代码
    (regex.compile(r"(?i)\[math\]"), ""),
    (regex.compile(r"(?i)\[/math\]"), ""),
    (regex.compile(r"(?i)\[latex\]"), ""),
    (regex.compile(r"(?i)\[/latex\]"), ""),
    (regex.compile(r"(?i)\[formula\]"), ""),
    (regex.compile(r"(?i)\[/formula\]"), ""),
    (regex.compile(r"(?i)\[code\]"), "，代码，"),
    (regex.compile(r"(?i)\[/code\]"), ""),
    (regex.compile(r"(?i)\[sourcecode\]"), ""),
    (regex.compile(r"(?i)\[/sourcecode\]"), ""),
    # 表格/列表
    (regex.compile(r"(?i)\[table\]"), "，表格，"),
    (regex.compile(r"(?i)\[/table\]"), ""),
    # SuperMemo 内部标记（全部统一归零）
    (regex.compile(r"(?i)\[clip\]"), ""),
    (regex.compile(r"(?i)\[/clip\]"), ""),
    (regex.compile(r"(?i)\[sound\]"), ""),
    (regex.compile(r"(?i)\[/sound\]"), ""),
    (regex.compile(r"(?i)\[video\]"), ""),
    (regex.compile(r"(?i)\[/video\]"), ""),
    (regex.compile(r"(?i)\[email\]"), ""),
    (regex.compile(r"(?i)\[/email\]"), ""),
    (regex.compile(r"(?i)\[attachment\]"), ""),
    (regex.compile(r"(?i)\[/attachment\]"), ""),
    (regex.compile(r"(?i)\[file\]"), ""),
    (regex.compile(r"(?i)\[/file\]"), ""),
    (regex.compile(r"(?i)\[object\]"), ""),
    (regex.compile(r"(?i)\[/object\]"), ""),
    (regex.compile(r"(?i)\[meta\]"), ""),
    (regex.compile(r"(?i)\[/meta\]"), ""),
    (regex.compile(r"(?i)\[info\]"), ""),
    (regex.compile(r"(?i)\[/info\]"), ""),
    (regex.compile(r"(?i)\[key\]"), ""),
    (regex.compile(r"(?i)\[/key\]"), ""),
    (regex.compile(r"(?i)\[answer\]"), ""),
    (regex.compile(r"(?i)\[/answer\]"), ""),
    (regex.compile(r"(?i)\[question\]"), ""),
    (regex.compile(r"(?i)\[/question\]"), ""),
    (regex.compile(r"(?i)\[template\]"), ""),
    (regex.compile(r"(?i)\[/template\]"), ""),
    (regex.compile(r"(?i)\[element\]"), ""),
    (regex.compile(r"(?i)\[/element\]"), ""),
    (regex.compile(r"(?i)\[component\]"), ""),
    (regex.compile(r"(?i)\[/component\]"), ""),
    (regex.compile(r"(?i)\[condition\]"), ""),
    (regex.compile(r"(?i)\[/condition\]"), ""),
    (regex.compile(r"(?i)\[if\]"), ""),
    (regex.compile(r"(?i)\[/if\]"), ""),
    (regex.compile(r"(?i)\[then\]"), ""),
    (regex.compile(r"(?i)\[/then\]"), ""),
    (regex.compile(r"(?i)\[else\]"), ""),
    (regex.compile(r"(?i)\[/else\]"), ""),
    (regex.compile(r"(?i)\[for\]"), ""),
    (regex.compile(r"(?i)\[/for\]"), ""),
    (regex.compile(r"(?i)\[while\]"), ""),
    (regex.compile(r"(?i)\[/while\]"), ""),
    (regex.compile(r"(?i)\[do\]"), ""),
    (regex.compile(r"(?i)\[/do\]"), ""),
    (regex.compile(r"(?i)\[end\]"), ""),
    (regex.compile(r"(?i)\[/end\]"), ""),
    (regex.compile(r"(?i)\[macro\]"), ""),
    (regex.compile(r"(?i)\[/macro\]"), ""),
    (regex.compile(r"(?i)\[execute\]"), ""),
    (regex.compile(r"(?i)\[/execute\]"), ""),
    (regex.compile(r"(?i)\[script\]"), ""),
    (regex.compile(r"(?i)\[/script\]"), ""),
    (regex.compile(r"(?i)\[javascript\]"), ""),
    (regex.compile(r"(?i)\[/javascript\]"), ""),
    (regex.compile(r"(?i)\[vbscript\]"), ""),
    (regex.compile(r"(?i)\[/vbscript\]"), ""),
    (regex.compile(r"(?i)\[activex\]"), ""),
    (regex.compile(r"(?i)\[/activex\]"), ""),
    (regex.compile(r"(?i)\[ocx\]"), ""),
    (regex.compile(r"(?i)\[/ocx\]"), ""),
    (regex.compile(r"(?i)\[activexcontrol\]"), ""),
    (regex.compile(r"(?i)\[/activexcontrol\]"), ""),
    (regex.compile(r"(?i)\[webbrowser\]"), ""),
    (regex.compile(r"(?i)\[/webbrowser\]"), ""),
    (regex.compile(r"(?i)\[internet\]"), ""),
    (regex.compile(r"(?i)\[/internet\]"), ""),
    (regex.compile(r"(?i)\[network\]"), ""),
    (regex.compile(r"(?i)\[/network\]"), ""),
    (regex.compile(r"(?i)\[database\]"), ""),
    (regex.compile(r"(?i)\[/database\]"), ""),
    (regex.compile(r"(?i)\[spreadsheet\]"), ""),
    (regex.compile(r"(?i)\[/spreadsheet\]"), ""),
    (regex.compile(r"(?i)\[presentation\]"), ""),
    (regex.compile(r"(?i)\[/presentation\]"), ""),
    (regex.compile(r"(?i)\[document\]"), ""),
    (regex.compile(r"(?i)\[/document\]"), ""),
    (regex.compile(r"(?i)\[folder\]"), ""),
    (regex.compile(r"(?i)\[/folder\]"), ""),
    (regex.compile(r"(?i)\[group\]"), ""),
    (regex.compile(r"(?i)\[/group\]"), ""),
    (regex.compile(r"(?i)\[category\]"), ""),
    (regex.compile(r"(?i)\[/category\]"), ""),
    (regex.compile(r"(?i)\[tag\]"), ""),
    (regex.compile(r"(?i)\[/tag\]"), ""),
    (regex.compile(r"(?i)\[label\]"), ""),
    (regex.compile(r"(?i)\[/label\]"), ""),
    (regex.compile(r"(?i)\[comment\]"), ""),
    (regex.compile(r"(?i)\[/comment\]"), ""),
    (regex.compile(r"(?i)\[reminder\]"), ""),
    (regex.compile(r"(?i)\[/reminder\]"), ""),
    (regex.compile(r"(?i)\[alarm\]"), ""),
    (regex.compile(r"(?i)\[/alarm\]"), ""),
    (regex.compile(r"(?i)\[calendar\]"), ""),
    (regex.compile(r"(?i)\[/calendar\]"), ""),
    (regex.compile(r"(?i)\[task\]"), ""),
    (regex.compile(r"(?i)\[/task\]"), ""),
    (regex.compile(r"(?i)\[project\]"), ""),
    (regex.compile(r"(?i)\[/project\]"), ""),
    # ===== HTML 标签 =====
    (regex.compile(r"(?i)<html\b[^>]*>"), ""),
    (regex.compile(r"(?i)</html>"), ""),
    (regex.compile(r"(?i)<body\b[^>]*>"), ""),
    (regex.compile(r"(?i)</body>"), ""),
    (regex.compile(r"(?i)<p\b[^>]*>"), "\n"),
    (regex.compile(r"(?i)</p>"), "。"),
    (regex.compile(r"(?i)<br\s*/?>"), "，"),
    (regex.compile(r"(?i)<hr\s*/?>"), "……"),
    (regex.compile(r"(?i)<h[1-6]\b[^>]*>"), "\n"),
    (regex.compile(r"(?i)</h[1-6]>"), "。"),
    (regex.compile(r"(?i)<div\b[^>]*>"), "\n"),
    (regex.compile(r"(?i)</div>"), ""),
    (regex.compile(r"(?i)<span\b[^>]*>"), ""),
    (regex.compile(r"(?i)</span>"), ""),
    (regex.compile(r"(?i)<blockquote\b[^>]*>"), "，引用，"),
    (regex.compile(r"(?i)</blockquote>"), ""),
    (regex.compile(r"(?i)<q\b[^>]*>"), "「"),
    (regex.compile(r"(?i)</q>"), "」"),
    (regex.compile(r"(?i)<math\b[^>]*>"), ""),
    (regex.compile(r"(?i)</math>"), ""),
    (regex.compile(r"(?i)<mml:math\b[^>]*>"), ""),
    (regex.compile(r"(?i)</mml:math>"), ""),
    (regex.compile(r"(?i)<code\b[^>]*>"), "，代码，"),
    (regex.compile(r"(?i)</code>"), ""),
    (regex.compile(r"(?i)<pre\b[^>]*>"), "，代码块，"),
    (regex.compile(r"(?i)</pre>"), ""),
    (regex.compile(r"(?i)<table\b[^>]*>"), "，表格开始，"),
    (regex.compile(r"(?i)</table>"), "，表格结束，"),
    (regex.compile(r"(?i)<tr\b[^>]*>"), ""),
    (regex.compile(r"(?i)</tr>"), "，"),
    (regex.compile(r"(?i)<t[dh]\b[^>]*>"), "，"),
    (regex.compile(r"(?i)</t[dh]>"), ""),
    (regex.compile(r"(?i)<caption\b[^>]*>"), "，表题，"),
    (regex.compile(r"(?i)</caption>"), "，"),
    (regex.compile(r"(?i)<ul\b[^>]*>"), ""),
    (regex.compile(r"(?i)</ul>"), ""),
    (regex.compile(r"(?i)<ol\b[^>]*>"), ""),
    (regex.compile(r"(?i)</ol>"), ""),
    (regex.compile(r"(?i)<li\b[^>]*>"), ""),
    (regex.compile(r"(?i)</li>"), "。\n"),
    (regex.compile(r"(?i)<dl\b[^>]*>"), ""),
    (regex.compile(r"(?i)</dl>"), ""),
    (regex.compile(r"(?i)<dt\b[^>]*>"), ""),
    (regex.compile(r"(?i)</dt>"), "："),
    (regex.compile(r"(?i)<dd\b[^>]*>"), ""),
    (regex.compile(r"(?i)</dd>"), ""),
    (regex.compile(r"(?i)<page\b[^>]*>"), ""),
    (regex.compile(r"(?i)</page>"), ""),
    # ===== 页码标注 =====
    (regex.compile(r"【第\d+页】"), ""),
    (regex.compile(r"第\s*\d+\s*页"), ""),
    # ===== HTML 上标 / 下标标签 =====
    (regex.compile(r"(?i)<SUP>[^<]*</SUP>"), ""),
    (regex.compile(r"(?i)</?SUP>"), ""),
    (regex.compile(r"(?i)<SUB>[^<]*</SUB>"), ""),
    (regex.compile(r"(?i)</?SUB>"), ""),
    # ===== ISBN 整段删除 =====
    (regex.compile(r"(?i)(?<![A-Za-z0-9])ISBN(?:[- :]*[\dXx]){9,}"), ""),
    # ===== 重复标点折叠 =====
    (regex.compile(r"[？?]{2,}"), "？"),
    (regex.compile(r"[！!]{2,}"), "！"),
    (regex.compile(r"[,，]{2,}"), "，"),
    (regex.compile(r"[.。]{3,}"), "……"),
    (regex.compile(r"…{2,}"), "……"),
    (regex.compile(r"[~～]{2,}"), "～"),
    (regex.compile(r"[。.]{2,}"), "。"),
    # ===== Markdown 粗体 / 斜体 / 行内代码 =====
    (regex.compile(r"\*\*([^*\n]+)\*\*"), r"\1"),
    (regex.compile(r"(?<!\*)\*([^*\n]+)\*(?!\*)"), r"\1"),
    (regex.compile(r"__([^_\n]+)__"), r"\1"),
    (regex.compile(r"`([^`\n]+)`"), r"\1"),
    # ===== Markdown 标题 / 图片 / 链接 =====
    (regex.compile(r"(?m)^#{1,6}\s+"), ""),
    (regex.compile(r"!\[([^\]]*)\]\([^)]*\)"), ""),
    (regex.compile(r"\[([^\]]+)\]\([^)]*\)"), r"\1"),
    # ===== URL / Email =====
    (regex.compile(r"(?i)https?://\S+"), ""),
    (regex.compile(r"(?i)(?<![A-Za-z0-9])www\.\S+"), ""),
    (regex.compile(r"(?i)\b[\w.+-]+@[\w-]+\.[\w.-]+\b"), ""),
    # ===== 拉丁缩写（带 lookaround + 后跟数字才展开） =====
    (regex.compile(r"(?i)(?<![A-Za-z])p\.\s+(?=\d)"), "page "),
    (regex.compile(r"(?i)(?<![A-Za-z])pp\.\s+(?=\d)"), "pages "),
    (regex.compile(r"(?i)(?<![A-Za-z])No\.\s*(?=\d)"), "Number "),
    (regex.compile(r"(?i)(?<![A-Za-z])no\.\s*(?=\d)"), "number "),
    # ===== 全角空格 → 逗号（诗句四字句之间停顿） =====
    (regex.compile(r"\u3000+"), "，"),
    # ===== 半角空白压缩 =====
    (regex.compile(r"[ \t]+"), " "),
]

# ============================================================
# 辅助函数（数字 / 罗马 / 日期 / 时间 / 序数 / 货币 / 温度）
# ============================================================

_ONES = [
    "zero",
    "one",
    "two",
    "three",
    "four",
    "five",
    "six",
    "seven",
    "eight",
    "nine",
    "ten",
    "eleven",
    "twelve",
    "thirteen",
    "fourteen",
    "fifteen",
    "sixteen",
    "seventeen",
    "eighteen",
    "nineteen",
]
_TENS = [
    "",
    "",
    "twenty",
    "thirty",
    "forty",
    "fifty",
    "sixty",
    "seventy",
    "eighty",
    "ninety",
]
_SCALES = [(10**9, "billion"), (10**6, "million"), (10**3, "thousand"), (1, "")]


def _int_to_words(n: int) -> str:
    """整数转英文词（支持到十亿级，负数加 minus）。"""
    if n < 0:
        return "minus " + _int_to_words(-n)
    if n < 20:
        return _ONES[n]
    if n < 100:
        return _TENS[n // 10] + ("" if n % 10 == 0 else "-" + _ONES[n % 10])
    if n < 1000:
        rest = n % 100
        return (
            _ONES[n // 100]
            + " hundred"
            + ("" if rest == 0 else " and " + _int_to_words(rest))
        )
    for value, name in _SCALES:
        if n >= value:
            rest = n % value
            head = _int_to_words(n // value) + (" " + name if name else "")
            return head + ("" if rest == 0 else " " + _int_to_words(rest))
    return str(n)


def _number_to_words(s: str) -> str:
    """字符串数字（可能含逗号/小数点）转英文词。"""
    s = s.replace(",", "")
    if "." in s:
        int_part, dec_part = s.split(".", 1)
        return (
            _int_to_words(int(int_part or 0))
            + " point "
            + " ".join(_ONES[int(d)] for d in dec_part)
        )
    return _int_to_words(int(s))


_ORDINAL_IRREGULAR = {
    1: "first",
    2: "second",
    3: "third",
    4: "fourth",
    5: "fifth",
    6: "sixth",
    7: "seventh",
    8: "eighth",
    9: "ninth",
    10: "tenth",
    11: "eleventh",
    12: "twelfth",
}

_ORDINAL_LAST = {
    "zero": "zeroth",
    "one": "first",
    "two": "second",
    "three": "third",
    "four": "fourth",
    "five": "fifth",
    "six": "sixth",
    "seven": "seventh",
    "eight": "eighth",
    "nine": "ninth",
    "ten": "tenth",
    "eleven": "eleventh",
    "twelve": "twelfth",
}


def _ordinal_word(w: str) -> str:
    if w in _ORDINAL_LAST:
        return _ORDINAL_LAST[w]
    if w.endswith("y"):
        return w[:-1] + "ieth"
    if w.endswith("t"):
        return w + "h"
    return w + "th"


def _int_to_ordinal(n: int) -> str:
    if n in _ORDINAL_IRREGULAR:
        return _ORDINAL_IRREGULAR[n]
    w = _int_to_words(n)
    parts = w.split(" ")
    last = parts[-1]
    if "-" in last:
        head, tail = last.rsplit("-", 1)
        parts[-1] = head + "-" + _ordinal_word(tail)
    else:
        parts[-1] = _ordinal_word(last)
    return " ".join(parts)


# ---- 罗马数字 ----
_ROMAN_MAP = [
    (1000, "M"),
    (900, "CM"),
    (500, "D"),
    (400, "CD"),
    (100, "C"),
    (90, "XC"),
    (50, "L"),
    (40, "XL"),
    (10, "X"),
    (9, "IX"),
    (5, "V"),
    (4, "IV"),
    (1, "I"),
]
_ROMAN_VALID = {v for _, v in _ROMAN_MAP}
# 扩充排除表：这些大写组合在正文/英文语境中很常见，不宜当成罗马数字
_ROMAN_EXCLUDE = {
    "MIX",
    "DIV",
    "CD",
    "DC",
    "MM",
    "CM",
    "XC",
    "LX",
    "XL",
}
# 用 lookaround 替代 \b，避免中文字符旁 \b 失效
_ROMAN_RE = regex.compile(r"(?<![A-Za-z])([IVXLCDM]{2,15})(?![A-Za-z])")


def _roman_to_int(s: str) -> int:
    total, i = 0, 0
    while i < len(s):
        if i + 1 < len(s) and s[i : i + 2] in _ROMAN_VALID:
            total += next(n for n, v in _ROMAN_MAP if v == s[i : i + 2])
            i += 2
        else:
            total += next(n for n, v in _ROMAN_MAP if v == s[i])
            i += 1
    return total


def _int_to_roman(n: int) -> str:
    """标准罗马数字表示（与 _roman_to_int 互逆）。"""
    result = ""
    for val, sym in _ROMAN_MAP:
        while n >= val:
            result += sym
            n -= val
    return result


def _expand_roman_numerals(text: str, *, to_digits: bool = False) -> str:
    """
    罗马数字展开。
    - to_digits=False：英文行，转英文单词（IV -> four）
    - to_digits=True：中文行，转阿拉伯数字（第IV章 -> 第4章），交给 TTS/中文 TN 读
    """

    def _repl(m):
        s = m.group(1)
        if s in _ROMAN_EXCLUDE:
            return s
        n = _roman_to_int(s)
        if not (1 <= n <= 3999):
            return s
        if _int_to_roman(n) != s:
            return s
        return str(n) if to_digits else _int_to_words(n)

    return _ROMAN_RE.sub(_repl, text)


# ---- 货币 ----
# 注意：¥ 在中国书籍里基本是人民币，不是日元
_CURRENCY_NAMES = {
    "$": ("dollar", "dollars", "cent", "cents"),
    "€": ("euro", "euros", "cent", "cents"),
    "£": ("pound", "pounds", "penny", "pence"),
    "¥": ("yuan", "yuan", "fen", "fen"),
    "￥": ("yuan", "yuan", "fen", "fen"),
    "₩": ("won", "won", "jeon", "jeon"),
    "₹": ("rupee", "rupees", "paisa", "paise"),
}
_CURRENCY_RE = regex.compile(r"([$€£¥￥₩₹])\s*([\d,]+)(?:\.(\d{1,2}))?")


def _expand_currencies(text: str) -> str:
    def _repl(m):
        sym = m.group(1)
        names = _CURRENCY_NAMES.get(sym)
        if not names:
            return m.group(0)
        major_s, major_p, minor_s, minor_p = names
        n = int(m.group(2).replace(",", ""))
        dec = m.group(3)
        major = major_s if n == 1 else major_p
        if dec:
            cents = int(dec.ljust(2, "0"))
            if cents:
                minor = minor_s if cents == 1 else minor_p
                return f"{_int_to_words(n)} {major} and {_int_to_words(cents)} {minor}"
        return f"{_int_to_words(n)} {major}"

    return _CURRENCY_RE.sub(_repl, text)


# ---- 温度（支持 °C / °F / ℃ / ℉，允许负号和小数） ----
_TEMP_RE = regex.compile(r"(-?\d+(?:\.\d+)?)\s*(°\s*[CFcf]|℃|℉)(?![A-Za-z0-9])")


def _expand_temperatures(text: str) -> str:
    def _repl(m):
        v = m.group(1)
        unit = m.group(2)
        is_c = "C" in unit.upper() or "℃" in unit
        name = "degrees Celsius" if is_c else "degrees Fahrenheit"
        return f"{_number_to_words(v)} {name}"

    return _TEMP_RE.sub(_repl, text)


# ---- 日期（MM/DD/YYYY 与 YYYY-MM-DD，年份限定 1000–2999） ----
_MONTHS = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
]
_DATE_SLASH_RE = regex.compile(r"(?<!\d)(\d{1,2})/(\d{1,2})/(\d{2,4})(?!\d)")
_DATE_ISO_RE = regex.compile(r"(?<!\d)(\d{4})-(\d{2})-(\d{2})(?!\d)")


def _expand_dates(text: str) -> str:
    def _repl_slash(m):
        mo, dy, yr = int(m.group(1)), int(m.group(2)), int(m.group(3))
        if yr < 100:
            yr += 2000 if yr < 50 else 1900
        if not (1 <= mo <= 12 and 1 <= dy <= 31):
            return m.group(0)
        if not (1000 <= yr <= 2999):
            return m.group(0)
        return f"{_MONTHS[mo - 1]} {_int_to_ordinal(dy)}, {_int_to_words(yr)}"

    def _repl_iso(m):
        yr, mo, dy = int(m.group(1)), int(m.group(2)), int(m.group(3))
        if not (1 <= mo <= 12 and 1 <= dy <= 31):
            return m.group(0)
        if not (1000 <= yr <= 2999):
            return m.group(0)
        return f"{_MONTHS[mo - 1]} {_int_to_ordinal(dy)}, {_int_to_words(yr)}"

    text = _DATE_SLASH_RE.sub(_repl_slash, text)
    return _DATE_ISO_RE.sub(_repl_iso, text)


# ---- 时间 ----
_TIME_AMPM_RE = regex.compile(
    r"(?<!\d)(\d{1,2}):(\d{2})\s*([AaPp])\.?[Mm]\.?(?![A-Za-z])"
)
_TIME_24_RE = regex.compile(r"(?<!\d)([01]?\d|2[0-3]):([0-5]\d)(?!\d)")


def _expand_times(text: str) -> str:
    def _repl_ampm(m):
        h, mi = int(m.group(1)), int(m.group(2))
        ampm = "A M" if m.group(3).upper() == "A" else "P M"
        return (
            f"{_int_to_words(h)} {_int_to_words(mi)} {ampm}"
            if mi
            else f"{_int_to_words(h)} {ampm}"
        )

    def _repl_24(m):
        h, mi = int(m.group(1)), int(m.group(2))
        if h == 0:
            return f"zero {_int_to_words(mi)}" if mi else "midnight"
        return f"{_int_to_words(h)} {_int_to_words(mi)}" if mi else _int_to_words(h)

    text = _TIME_AMPM_RE.sub(_repl_ampm, text)
    return _TIME_24_RE.sub(_repl_24, text)


# ---- 序数词（1st / 2nd / 3rd / 4th ...） ----
_ORDINAL_RE = regex.compile(
    r"(?<![A-Za-z0-9])(\d+)(st|nd|rd|th)(?![A-Za-z])", regex.IGNORECASE
)


def _expand_ordinals(text: str) -> str:
    return _ORDINAL_RE.sub(lambda m: _int_to_ordinal(int(m.group(1))), text)


# ---- 纯基数词 / 小数（最后执行） ----
_NUMBER_RE = regex.compile(
    r"(?<![A-Za-z0-9.])(\d{1,3}(?:,\d{3})+|\d+)(\.\d+)?(?![A-Za-z0-9]|\.\d)"
)


def _expand_numbers(text: str) -> str:
    def _repl(m):
        return _number_to_words(m.group(1) + (m.group(2) or ""))

    return _NUMBER_RE.sub(_repl, text)


# ============================================================
# 语言分流：中文行不把数字/日期/货币/温度展开成英文
# ============================================================

_CJK_CHAR_RE = regex.compile(r"[\u3400-\u4dbf\u4e00-\u9fff\uf900-\ufaff]")
_LATIN_CHAR_RE = regex.compile(r"[A-Za-z]")


def _is_cjk_dominant(segment: str) -> bool:
    """
    判断一行/一段是否以中文为主。
    纯英文返回 False；中文行即使夹杂英文书名，只要中文字符不太少也按中文处理。
    """
    cjk = len(_CJK_CHAR_RE.findall(segment))
    latin = len(_LATIN_CHAR_RE.findall(segment))
    if cjk == 0:
        return False
    return cjk * 2 >= latin


def _apply_language_sensitive_expansions(text: str, expand_digits: bool) -> str:
    """
    按行分流：
    - 中文行：只把罗马数字转成阿拉伯数字（第IV章 -> 第4章），数字/日期保留给中文 TTS 或后续 TN。
    - 英文行：走原来的英文数字、日期、时间、序数、货币、温度展开。
    """
    lines = text.split("\n")
    out: list[str] = []
    for line in lines:
        if _is_cjk_dominant(line):
            line = _expand_roman_numerals(line, to_digits=True)
        else:
            line = _expand_currencies(line)
            line = _expand_temperatures(line)
            line = _expand_dates(line)
            line = _expand_times(line)
            line = _expand_ordinals(line)
            line = _expand_roman_numerals(line, to_digits=False)
            if expand_digits:
                line = _expand_numbers(line)
        out.append(line)
    return "\n".join(out)


# ============================================================
# 排版收尾（换行统一 + 段落断句）
# ============================================================


def _finalize_layout(text: str) -> str:
    """把结构换行转成 TTS 可识别的标点。

    段落之间（\\n\\n）→ 句号；行末无标点 → 逗号。
    目的是让 TTS 在诗句行、段落、题解之间有正确的停顿，
    而不是把 \\r\\n 当成空白忽略、导致全文连读。
    """
    # 换行符统一：Windows \r\n、Mac 老式 \r → \n
    text = text.replace("\r\n", "\n").replace("\r", "\n")
    # 去掉首尾空白（必须在 \n\n → 。\n 之前）
    text = text.strip()
    # 压缩连续空行
    text = regex.sub(r"\n{3,}", "\n\n", text)
    # 行首缩进：半角/全角空格都删掉，避免句首产生孤立逗号
    text = regex.sub(r"(?m)^[ \t\u3000]+", "", text)
    # 行内全角空格 → 逗号（诗句四字句之间停顿）
    text = regex.sub(r"\u3000+", "，", text)
    # 半角空白压缩
    text = regex.sub(r"[ \t]+", " ", text)
    # 清理行首孤立标点（删标签后可能残留 ，、；：）
    text = regex.sub(r"(?m)^[，、；：]+", "", text)
    # 段落之间 → 句号（长停顿）
    text = regex.sub(r"\n\n", "。\n", text)
    # 兜底：连续句号压成一个
    text = regex.sub(r"。{2,}", "。", text)
    # 行末无标点 → 逗号（短停顿）
    text = regex.sub(r"(?<=[^\s，。！？；：、,.!?;:…])\n", "，\n", text)
    return text


# ============================================================
# 主流程（顺序敏感，勿随意调换）
# ============================================================


def normalize_text(text: str, *, expand_digits: bool = True) -> str:
    """
    TTS 文本规范化主入口。

    参数:
        text: 原始文本
        expand_digits: 英文行是否展开纯基数词（默认 True）
    """
    # 1. NFC 归一化（必须最先）
    text = unicodedata.normalize("NFC", text)

    # 2. &amp; 特殊处理：必须在 unescape 之前，
    #    否则 "&amp;" 会变成孤立的 "&"，TTS 可能读成 "and" 或静默。
    # text = text.replace("&amp;", "和")

    # 3. HTML 实体解码：一次性处理 &#22686; &#x589E; &lt; &quot; &nbsp; 等所有实体。
    #    SuperMemo 的 htm 文件通常全部用数字实体存储，这一步是整个流程的关键。
    # text = html.unescape(text)

    # 4. 不可见 / 控制字符（含 U+00A0 nbsp，unescape 后会出现）
    text = regex.sub(
        r"[\u00a0\u00ad\u180e\u2000-\u200f\u202a-\u202e\u202f\u205f\u2060-\u2064\ufeff]",
        " ",
        text,
    )

    # 5. 标签 / Markdown / 缩略 / 标点 / 空白压缩（regex_replace_list）
    for pat, rep in regex_replace_list:
        text = pat.sub(rep, text)

    # 6. 按语言分流：中文行不把数字/日期转英文；
    #    英文行执行货币 / 温度 / 日期 / 时间 / 序数 / 罗马 / 基数展开。
    #    这一步必须在 replace_list 的 "°C" 等兜底替换之前，
    #    否则英文行的 20°C 会被提前拆坏。
    text = _apply_language_sensitive_expansions(text, expand_digits)

    # 7. 字面量替换（符号、希腊字母、拉丁缩写、度量衡、带圈数字）
    for a, b in replace_list:
        text = text.replace(a, b)

    # 8. 排版收尾（换行 → 标点）
    text = _finalize_layout(text)
    return text.strip()


if __name__ == "__main__":
    sample = (
        "泮水\r\n"
        "鲁僖公饮于泮宫并举行受俘仪式，此诗赞颂他有德有威。\r\n\r\n\r\n"
        "思乐泮水，薄采其芹\r\n"
        "鲁侯戾止，言观其旂\r\n"
        "第IV章 2024年10月22日\r\n"
        "English line: On 10/22/2024, the temperature was 20°C."
    )
    print(normalize_text(sample))

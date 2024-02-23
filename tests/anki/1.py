import re


a = [
    '<span class="definition">vt. ',
    "相关词义延伸：\n",
    "· pool可指从不同的人那里收集。\n",
]
b = list()
for item in a:
    t = re.search(r"class", item)
    if t is not None:
        b.append(item)
print(b)

# 不能这样做
# for item in a:
#     t = re.search(r"class", item)
#     if t is None:
#         a.remove(item)
#         print(t)
# print(a)
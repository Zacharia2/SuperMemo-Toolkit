import pandas as pd
from readmdict import MDX

mdx = MDX("D:\\Software\\MDictPC\\doc\\Collins\cobuild2024.mdx")
headwords = [*mdx]  # 单词名列表
items = [*mdx.items()]  # 释义html源码列表
if len(headwords) == len(items):
    print(f"加载成功：共{len(headwords)}条")
else:
    print(f"【ERROR】加载失败{len(headwords)}，{len(items)}")

df = pd.read_excel("C:/Users/Snowy/Desktop/单词 - 副本.xlsx", sheet_name="Sheet1")

word_list = df.iloc[:, 0].to_dict()

for index, word in word_list.items():
    if word.encode() in headwords:
        word, html = items[headwords.index(word.encode())]
        word, html = word.decode(), html.decode()
        df.iat[index, 2] = html


print(df.head())

df.to_excel("C:/Users/Snowy/Desktop/单词 - 副本.xlsx", sheet_name="Sheet1", index=False)

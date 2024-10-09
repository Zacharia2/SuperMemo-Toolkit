# -*- coding: utf-8 -*-

import os
from io import BytesIO
from PIL import Image, ImageOps
import matplotlib.font_manager as mfm
from matplotlib import mathtext

"""
author: Python与数据挖掘 (知乎) 
links: https://zhuanlan.zhihu.com/p/383951999
"""


def latex2img(text, size=32, color=(0.1, 0.1, 0.1), out=None, **kwds):
    """LaTex数学公式转图片

    text        - 文本字符串，其中数学公式须包含在两个$符号之间
    size        - 字号，整型，默认32
    color       - 颜色，浮点型三元组，值域范围[0,1]，默认深黑色
    out         - 文件名，仅支持后缀名为.png的文件名。若维None，则返回PIL图像对象
    kwds        - 关键字参数
                    dpi         - 输出分辨率（每英寸像素数），默认72
                    family      - 系统支持的字体，None表示当前默认的字体
                    weight      - 笔画轻重，可选项包括：normal（默认）、light和bold
    """

    assert (
        out is None or os.path.splitext(out)[1].lower() == ".png"
    ), "仅支持后缀名为.png的文件名"

    for key in kwds:
        if key not in ["dpi", "family", "weight"]:
            raise KeyError("不支持的关键字参数：%s" % key)

    dpi = kwds.get("dpi", 72)
    family = kwds.get("family", None)
    weight = kwds.get("weight", "normal")

    bfo = BytesIO()  # 创建二进制的类文件对象
    prop = mfm.FontProperties(family=family, size=size, weight=weight)
    mathtext.math_to_image(text, bfo, prop=prop, dpi=dpi)
    im = Image.open(bfo)  # 打开二进制的类文件对象，返回一个PIL图像对象

    r, g, b, a = im.split()  # 分离出RGBA四个通道
    # 反转RGB通道
    r = ImageChops.invert(r)
    g = ImageChops.invert(g)
    b = ImageChops.invert(b)
    # 生成新的alpha通道
    a = ImageChops.add(ImageChops.add(r, g), b).convert('L')
    a = ImageChops.scale(a, 1/3)
    # 设置颜色
    r = ImageChops.multiply(r, Image.new('L', (1, 1), int(color[0]*255)))
    g = ImageChops.multiply(g, Image.new('L', (1, 1), int(color[1]*255)))
    b = ImageChops.multiply(b, Image.new('L', (1, 1), int(color[2]*255)))

    # 合并通道
    im = Image.merge('RGBA', (r, g, b, a))

    if out is None:
        return im
    else:
        im.save(out)  # PIL图像对象保存为文件
        print("latex2img:: 生成的图片已保存为%s" % out)


# if __name__ == "__main__":
#     text = r"$\sum_{i=0}^\infty x_i$"
#     latex2img(text, size=48, color=(0.1, 0.8, 0.8), out=r"d:\demo.png")

#     text = r"$\sum_{n=1}^\infty\frac{-e^{i\pi}}{2^n}$"
#     im = latex2img(text, size=48, color=(0.9, 0.1, 0.1))
#     im.show()

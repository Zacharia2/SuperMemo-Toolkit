# -*- coding: utf-8 -*-

import os
from io import BytesIO
from PIL import Image
import numpy as np
import matplotlib.font_manager as mfm
from matplotlib import mathtext


# https://zhuanlan.zhihu.com/p/383951999
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
    r, g, b = 255 - np.array(r), 255 - np.array(g), 255 - np.array(b)  # RGB通道反白
    a = r / 3 + g / 3 + b / 3  # 生成新的alpha通道
    r, g, b = r * color[0], g * color[1], b * color[2]  # RGB通道设置为目标颜色

    im = np.dstack((r, g, b, a)).astype(np.uint8)  # RGBA四个通道合并为三维的numpy数组
    im = Image.fromarray(im)  # numpy数组转PIL图像对象

    if out is None:
        return im
    else:
        im.save(out)  # PIL图像对象保存为文件
        print("生成的图片已保存为%s" % out)


# if __name__ == "__main__":
#     text = r"$\sum_{i=0}^\infty x_i$"
#     latex2img(text, size=48, color=(0.1, 0.8, 0.8), out=r"d:\demo.png")

#     text = r"$\sum_{n=1}^\infty\frac{-e^{i\pi}}{2^n}$"
#     im = latex2img(text, size=48, color=(0.9, 0.1, 0.1))
#     im.show()

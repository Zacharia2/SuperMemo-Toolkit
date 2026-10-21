import logging
from io import BytesIO
from pathlib import Path

import matplotlib

matplotlib.use("Agg")  # 强制使用纯计算后端，不弹窗
if hasattr(matplotlib, "set_loglevel"):
    matplotlib.set_loglevel("warning")
else:  # pragma: no cover - 兼容旧版 matplotlib
    logging.getLogger("matplotlib").setLevel(logging.WARNING)

import matplotlib.font_manager as mfm
from matplotlib import mathtext
from PIL import Image

__all__ = ["latex2img", "latex2img_md"]


def _to_byte(v: float) -> int:
    """把 [0, 1] 的浮点颜色分量转成 [0, 255] 整数，四舍五入并钳位。"""
    return max(0, min(255, round(v * 255)))


def _validate_color(color: tuple[float, float, float]) -> None:
    if not isinstance(color, (tuple, list)) or len(color) != 3:
        raise ValueError("color 必须是长度为 3 的序列，例如 (0.1, 0.1, 0.1)")
    for c in color:
        if not isinstance(c, (int, float)):
            raise TypeError("color 的每个分量必须是数值")
        if not 0.0 <= float(c) <= 1.0:
            raise ValueError("color 的每个分量必须在 [0, 1] 范围内")


def latex2img(
    text: str,
    size: float = 32,
    color: tuple[float, float, float] = (0.1, 0.1, 0.1),
    out: str | Path | None = None,
    **kwds,
) -> Image.Image:
    """LaTeX 数学公式转 PNG 图片（透明背景）。

    Parameters
    ----------
    text : str
        数学表达式，公式必须包含在两个 ``$`` 符号之间，
        例如 ``r"$\\sum_{i=0}^\\infty x_i$"``。
    size : float
        字号（pt），默认 32。
    color : tuple[float, float, float]
        RGB 颜色，每个分量范围 [0, 1]，默认深黑色。
    out : str | Path | None
        输出文件名，仅支持 ``.png`` 后缀。为 None 时只返回 PIL 图像对象。
    **kwds
        其他关键字参数：

        - ``dpi``：输出分辨率，默认 72；
        - ``family``：字体族，默认 None；
        - ``weight``：字重，默认 ``"normal"``。

    Returns
    -------
    PIL.Image.Image
        渲染后的 RGBA 图像。
    """
    if not isinstance(text, str):
        raise TypeError("text 必须是字符串")
    if not text.strip():
        raise ValueError("text 不能为空")
    if "$" not in text:
        raise ValueError("数学公式必须包含在两个 $ 符号之间")

    if not isinstance(size, (int, float)) or isinstance(size, bool) or size <= 0:
        raise ValueError("size 必须是正数")

    _validate_color(color)

    if out is not None:
        out_path = Path(out)
        if out_path.suffix.lower() != ".png":
            raise ValueError("仅支持后缀名为 .png 的文件名")
    else:
        out_path = None

    allowed = {"dpi", "family", "weight"}
    unknown = set(kwds) - allowed
    if unknown:
        raise KeyError("不支持的关键字参数：{}".format(", ".join(sorted(unknown))))

    dpi = kwds.get("dpi", 72)
    if dpi is not None and (
        not isinstance(dpi, (int, float)) or isinstance(dpi, bool) or dpi <= 0
    ):
        raise ValueError("dpi 必须是正数或 None")

    family = kwds.get("family", None)
    weight = kwds.get("weight", "normal")

    prop = mfm.FontProperties(family=family, size=size, weight=weight)

    with BytesIO() as bfo:
        # 显式 format="png"：BytesIO 没有文件名，不传 format 时 savefig 可能无法推断格式
        mathtext.math_to_image(text, bfo, prop=prop, dpi=dpi, format="png")
        bfo.seek(0)
        im = Image.open(bfo)
        im.load()  # 立即读入内存，避免离开 with 后 BytesIO 关闭导致懒加载失败

    # math_to_image 输出的是白底黑字、不透明的 PNG。
    # 正确做法：用灰度反转得到文字的 alpha 蒙版，RGB 统一设为 color。
    im = im.convert("RGBA")
    gray = im.convert("L")
    mask = gray.point(lambda x: 255 - x)  # 背景 255 -> 0，文字 0 -> 255

    r = Image.new("L", im.size, _to_byte(color[0]))
    g = Image.new("L", im.size, _to_byte(color[1]))
    b = Image.new("L", im.size, _to_byte(color[2]))
    im = Image.merge("RGBA", (r, g, b, mask))

    if out_path is None:
        return im

    out_path.parent.mkdir(parents=True, exist_ok=True)
    im.save(out_path, format="PNG")
    print(f"latex2img:: 生成的图片已保存为 {out_path}")
    return im


def latex2img_md(
    text: str,
    size: float = 32,
    color: tuple[float, float, float] = (0.1, 0.1, 0.1),
    out: str | Path | None = None,
    **kwds,
) -> Image.Image:
    """将 Markdown 风格的双 ``$$`` 围栏公式转 PNG 图片。

    相比 ``latex2img``，此方法专门接受被 ``$$...$$`` 包裹的公式，
    内部自动剥离双 ``$`` 并包装为单 ``$`` 后调用 ``latex2img``。

    Parameters
    ----------
    text : str
        数学表达式，必须包含在两个 ``$$`` 符号之间，
        例如 ``r"$$\\sum_{i=0}^\\infty x_i$$"``。
    size, color, out, **kwds
        与 ``latex2img`` 参数完全一致。
    """
    if not isinstance(text, str):
        raise TypeError("text 必须是字符串")

    stripped = text.strip()
    if not (stripped.startswith("$$") and stripped.endswith("$$")):
        raise ValueError("数学公式必须包含在两个 $$ 符号之间")

    inner = stripped[2:-2]
    if not inner.strip():
        raise ValueError("text 不能为空")

    # 委托给基础方法处理
    return latex2img(f"${inner}$", size=size, color=color, out=out, **kwds)


if __name__ == "__main__":
    text = r"$\sum_{i=0}^\infty x_i$"
    latex2img(text, size=48, color=(0.1, 0.8, 0.8), out=r"d:\demo.png")

    text = r"$\sum_{n=1}^\infty\frac{-e^{i\pi}}{2^n}$"
    im = latex2img(text, size=48, color=(0.9, 0.1, 0.1))
    im.show()

    # 新方法测试
    text_md = r"$$\sum_{i=0}^\infty x_i$$"
    latex2img_md(text_md, size=48, color=(0.1, 0.8, 0.8), out=r"d:\demo_md.png")

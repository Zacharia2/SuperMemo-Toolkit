import os
import tempfile

import regex
from bs4 import BeautifulSoup
from PIL import Image


class EpubImageFit:
    # ====== 可调参数 ======
    def __init__(self, page_width=1200, active_kno_path=None):
        self.active_kno_path = active_kno_path
        self.page_width = page_width  # 页宽阈值（px），超过就缩到页宽
        self.inline_height_em = 1.05  # 行内小图高度（em）
        # 各类样式 块级元素限定宽度，行级元素限定高度
        self.style = {
            # 封面：占满屏，居中
            "cover": lambda width_val: (
                f"width:{width_val};height:auto;display:block;margin:0 auto;"
                f"*zoom:1;-ms-interpolation-mode:bicubic;"
            ),
            # 宽图：缩到页宽
            "fit_page": lambda width_val: (
                f"width:{width_val};height:auto;display:block;margin:1em auto;"
                f"*zoom:1;-ms-interpolation-mode:bicubic;"
            ),
            # 行内小图：跟随行高
            "inline": lambda height_em: (
                f"height:{height_em};vertical-align:middle;display:inline-block;"
                f"*display:inline;*zoom:1;-ms-interpolation-mode:bicubic;"
            ),
            # 图注图：块级居中，宽度自适应
            "figure": lambda width_val: (
                f"width:{width_val};height:auto;display:block;margin:1em auto;"
                f"*zoom:1;-ms-interpolation-mode:bicubic;"
            ),
            # 小图 / 长图：保持原尺寸，块级居中
            "small": lambda width_val: (
                f"width:{width_val};height:auto;display:block;margin:1em auto;"
                f"*zoom:1;-ms-interpolation-mode:bicubic;"
            ),
        }

    # ====== 判断辅助函数 ======

    def has_class(self, node, keywords):
        """判断节点或其祖先的 class 是否包含关键词"""
        p = node
        while p:
            cls = p.get("class") if hasattr(p, "get") else None
            if cls:
                joined = " ".join(cls).lower()
                if any(k in joined for k in keywords):
                    return True
            if getattr(p, "name", None) in ("body", "html", None):
                break
            p = p.parent
        return False

    def is_cover(self, img):
        """封面判断：class 含 cover，或父级 a 指向封面"""
        if self.has_class(img, ["cover", "封面"]):
            return True
        p = img.parent
        return bool(
            p and p.name == "a" and "cover" in (p.get("href", "") or "").lower()
        )

    def get_image_size(self, img_src, base_dir):
        """读取图片真实宽高，失败返回 (0, 0)"""
        count = len(regex.compile(r"(?i)\[.*?Storage\]").findall(img_src))
        if count > 0:
            root, _ = base_dir.split("elements")
            if not img_src:
                return 0, 0
            path = os.path.normpath(img_src.split("#")[0].split("?")[0])
            full = regex.sub(
                regex.compile(r"(?i)file:\\\[[A-Za-z]+Storage\]"),
                lambda _: os.path.normpath(os.path.join(root, "elements")) + "\\",
                path,
            )
        else:
            if not img_src:
                return 0, 0
            path = img_src.split("#")[0].split("?")[0]
            full = os.path.join(base_dir, path)
        try:
            with Image.open(full) as im:
                return im.width, im.height
        except Exception:
            return 0, 0

    def has_text_around(self, img):
        """判断图片前后兄弟节点是否有非空文本"""

        def scan(node, direction):
            while node:
                if isinstance(node, str) and node.strip():
                    return True
                if getattr(node, "name", None) == "br":
                    node = (
                        node.previous_sibling
                        if direction == "prev"
                        else node.next_sibling
                    )
                    continue
                if getattr(node, "name", None):
                    return False
                node = (
                    node.previous_sibling if direction == "prev" else node.next_sibling
                )
            return False

        return scan(img.previous_sibling, "prev") or scan(img.next_sibling, "next")

    # ====== 核心分类 ======

    def classify(self, img, base_dir):
        # 1. 封面
        if self.is_cover(img):
            return "cover"

        # 2. 图注图
        if self.has_class(img, ["figure", "fig", "caption"]):
            return "figure"

        # 3. 行内小图：向上找块级祖先，段落有文字，且图片前后有文字
        block = img.find_parent(["p", "li", "td", "div"])
        if block:
            text = block.get_text().strip()
            if text and self.has_text_around(img):
                return "inline"

        # 4. 读尺寸
        w, h = self.get_image_size(img.get("src", ""), base_dir)

        # 5. 宽图：缩到页宽
        if w >= self.page_width:
            return "fit_page"

        # 6. 小图 / 长图：保持原尺寸
        return "small"

    # ====== HTML 处理 ======

    def process_html(self, html, base_dir):
        soup = BeautifulSoup(html, "html.parser")
        stats = {}

        for img in soup.find_all("img"):
            cat = self.classify(img, base_dir)
            w, _ = self.get_image_size(img.get("src", ""), base_dir)

            # 删掉会干扰的旧属性
            for attr in ("width", "height", "align", "border"):
                if img.has_attr(attr):
                    del img[attr]
            if img.has_attr("style"):
                del img["style"]

            if cat == "cover" or cat == "fit_page":
                img["style"] = self.style[cat](str(self.page_width) + "px")
            elif cat == "inline":
                img["style"] = self.style[cat](str(self.inline_height_em) + "em")
            elif cat == "figure":
                figure_width: str = None
                if w > self.page_width:
                    figure_width = str(self.page_width - 200) + "px"
                else:
                    figure_width = "auto"
                img["style"] = self.style[cat](figure_width)
            elif cat == "small":
                small_width: str = None
                if w > self.page_width:
                    small_width = str(self.page_width - 200) + "px"
                else:
                    small_width = "auto"
                img["style"] = self.style[cat](small_width)

            # 加语义化 class，方便日后识别或再加样式
            img["class"] = list(set(img.get("class", []) + [f"smtk-{cat}"]))
            stats[cat] = stats.get(cat, 0) + 1

        # 图注样式
        for cap in soup.find_all("figcaption"):
            cap["style"] = (
                "font-size:0.9em;color:#666;text-align:center;margin-top:0.3em;"
            )

        print("分类统计：", stats)
        if soup.body:
            return "".join(str(x) for x in soup.body.children)
        return str(soup)

    # ====== 原子替换 ======

    def process_file(self, path):
        """读取 → 处理 → 原子替换"""
        base_dir = os.path.dirname(os.path.abspath(path))
        with open(path, "r", encoding="utf-8", errors="ignore") as f:
            html = f.read()

        new_html = self.process_html(html, base_dir)

        # 在同目录下建临时文件，保证和原文件同一文件系统
        dir_name = os.path.dirname(os.path.abspath(path))
        fd, tmp_path = tempfile.mkstemp(
            prefix=".sm_tmp_",
            suffix=".xhtml",
            dir=dir_name,
        )
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as f:
                f.write(new_html)
                f.flush()
                os.fsync(f.fileno())  # 确保落盘
            os.replace(tmp_path, path)  # 原子替换
        except Exception:
            # 出错就清掉临时文件，原文件不动
            if os.path.exists(tmp_path):
                os.remove(tmp_path)
            raise


# ====== 入口 ======

if __name__ == "__main__":
    fit = EpubImageFit()
    fit.process_file(r"d:\supermemo\systems\reading-and-review\elements\14\8\4283.HTM")

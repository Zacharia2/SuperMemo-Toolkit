import hashlib
import os
import tempfile
from pathlib import Path

import regex
from bs4 import BeautifulSoup, Comment, NavigableString

from supermemo_toolkit.latex2img.bridge import Bridge
from supermemo_toolkit.latex2img.formula_to_png import latex2img_md

BLOCK_FORMULA_RE = regex.compile(r"\$\$\$(.+?)\$\$\$", regex.S)
INLINE_FORMULA_RE = regex.compile(r"(?<!\$)\$\$(?!\$)(.+?)(?<!\$)\$\$(?!\$)", regex.S)

PRE_CHECK_RE = regex.compile(
    r"""(?isx)
    <!--.*?-->                                         (*SKIP)(*F)
    | <(?:script|style|textarea|code)\b[^>]*>.*?</(?:script|style|textarea|code)>  (*SKIP)(*F)
    | \$\$\$.+?\$\$\$
    | \$\$(?!\$).+?(?<!\$)\$\$(?!\$)
    | smtk-formula
    """
)

INLINE_EDITOR_JS_VER = "1.2.1"

INLINE_EDITOR_JS = (
    f"// FX_EDITOR_VER: {INLINE_EDITOR_JS_VER}\n"
    + r"""
function fxFindChild(c, cls, tag) {
  if (!c) return null;
  var els = c.getElementsByTagName(tag);
  var re = new RegExp("(^|\\s)" + cls + "(\\s|$)");
  for (var i = 0; i < els.length; i++) {
    if (re.test(els[i].className)) return els[i];
  }
  return null;
}
function fxFindImg(c) { return fxFindChild(c, "smtk-fx-img", "img"); }
function fxGetSource(c) {
  var img = fxFindImg(c);
  return img ? (img.getAttribute("alt") || "") : null;
}
function fxStripDelims(s) {
  s = s.replace(/^\s+|\s+$/g, "");
  if (s.indexOf("$$$") === 0 && s.lastIndexOf("$$$") === s.length - 3)
    return s.substring(3, s.length - 3).replace(/^\s+|\s+$/g, "");
  if (s.indexOf("$$") === 0 && s.lastIndexOf("$$") === s.length - 2)
    return s.substring(2, s.length - 2).replace(/^\s+|\s+$/g, "");
  return s;
}
function fxSetSource(c, text) {
  var img = fxFindImg(c);
  if (!img) { alert("\u627e\u4e0d\u5230\u6e32\u67d3\u56fe\u7247"); return false; }
  img.setAttribute("alt", text);
  if (/(^|\s)smtk-block(\s|$)/.test(c.className)) {
    var src = fxFindChild(c, "smtk-fx-src", "div");
    if (src) {
      while (src.firstChild) src.removeChild(src.firstChild);
      src.appendChild(document.createTextNode(text));
    }
  }
  return true;
}
function fxMarkPending(c) {
  if (fxFindChild(c, "fx-pending", "span")) return;
  var span = document.createElement("span");
  span.className = "fx-pending";
  span.style.color = "#c60";
  span.style.fontWeight = "bold";
  span.appendChild(document.createTextNode(" [\u5f85\u91cd\u65b0\u6e32\u67d3]"));
  c.appendChild(span);
}
function fxCancel(eid) {
  var e = document.getElementById(eid);
  if (e && e.parentNode) e.parentNode.removeChild(e);
  return false;
}
function fxNotifySave(cid) {
  if (typeof SMTK_BRIDGE === "undefined" || !SMTK_BRIDGE) return;
  var img = new Image();
  img.onload = img.onerror = function () {};
  img.src = SMTK_BRIDGE.url + encodeURIComponent(cid) + "&_=" + (+new Date());
}
var FX_EDITOR_STYLE = "position:absolute;top:20px;left:5%;width:90%;z-index:9999;"
  + "border:2px solid #888;padding:10px;background:#fffbe6;text-align:left;";
var FX_BTN_STYLE = "cursor:pointer;border:1px solid #888;padding:2px 12px;"
  + "background:#eee;color:#000;";
function fxEditClick(cid) {
  try {
    var c = document.getElementById(cid);
    if (!c) { alert("\u627e\u4e0d\u5230\u516c\u5f0f\u5bb9\u5668: " + cid); return false; }
    var src = fxGetSource(c);
    if (src == null) { alert("\u627e\u4e0d\u5230\u516c\u5f0f\u6e90\u7801"); return false; }
    var eid = "ed-" + cid;
    fxCancel(eid);
    var q = String.fromCharCode(39);
    var html =
      "<div id=\"" + eid + "\" style=\"" + FX_EDITOR_STYLE + "\">" +
        "<div style=\"text-align:center;font-weight:bold;margin-bottom:6px;\">\u7f16\u8f91\u516c\u5f0f\uff08\u65e0\u9700\u56f4\u680f\uff0c\u7cfb\u7edf\u81ea\u52a8\u8865\u5168\uff09\uff1a</div>" +
        "<textarea id=\"ta-" + cid + "\" rows=\"4\" style=\"width:100%;font-family:monospace;box-sizing:border-box;\"></textarea>" +
        "<div style=\"margin-top:8px;text-align:center;\">" +
          "<span onclick=\"return fxCancel(" + q + eid + q + ")\" style=\"" + FX_BTN_STYLE + "\">\u53d6\u6d88</span> " +
          "<span onclick=\"return fxCommit(" + q + cid + q + ")\" style=\"" + FX_BTN_STYLE + "margin-left:10px;\">\u786e\u5b9a</span>" +
        "</div>" +
      "</div>";
    var temp = document.createElement("div");
    temp.innerHTML = html;
    var editor = temp.getElementsByTagName("div")[0];
    var scrollTop = document.body.scrollTop || document.documentElement.scrollTop;
    editor.style.top = (scrollTop + 20) + "px";
    document.body.appendChild(editor);
    var ta = document.getElementById("ta-" + cid);
    if (ta) {
      ta.value = fxStripDelims(src);
      try { ta.focus(); } catch (e) {}
    }
  } catch (e) {
    alert("JS \u9519\u8bef: " + e.message);
  }
  return false;
}
function fxCommit(cid) {
  var c = document.getElementById(cid);
  var ta = document.getElementById("ta-" + cid);
  if (!c || !ta) { alert("\u7f16\u8f91\u533a\u5df2\u5931\u6548\uff0c\u8bf7\u91cd\u65b0\u70b9\u51fb\u201c\u7f16\u8f91\u201d"); return false; }
  if (ta.value.replace(/^\s+|\s+$/g, "") === "") {
    alert("\u516c\u5f0f\u5185\u5bb9\u4e0d\u80fd\u4e3a\u7a7a\u3002"); return false;
  }
  var innerText = fxStripDelims(ta.value);
  var isBlock = /(^|\s)smtk-block(\s|$)/.test(c.className);
  var text = isBlock ? ("$$$" + innerText + "$$$") : ("$$" + innerText + "$$");
  if (!fxSetSource(c, text)) return false;
  fxMarkPending(c);
  fxNotifySave(cid);
  fxCancel("ed-" + cid);
  return false;
}
"""
)


class FormulaRenderer:
    def __init__(self, elements_dir: str | Path, bridge: Bridge | None = None):
        self.image_dir = Path(elements_dir) / "local_pic"
        self.image_dir.mkdir(parents=True, exist_ok=True)
        self.bridge = bridge
        self.changed = False

    # ── 脚本注入 ────────────────────────────────────────────────
    def _script_payload(self) -> str:
        if self.bridge is None:
            return INLINE_EDITOR_JS
        return (
            f"// SMTK_BRIDGE_PORT: {self.bridge.port}\n"
            f"var SMTK_BRIDGE = {{ port: {self.bridge.port}, "
            f'url: "http://127.0.0.1:{self.bridge.port}/save-formula?cid=" }};\n'
            + INLINE_EDITOR_JS
        )

    def _needs_script_update(self, html: str) -> bool:
        """判断 html 中现存的注入脚本是否需要重写。

        触发条件：
          1. 版本号不符 —— 升级编辑器脚本。
          2. bridge 存在但端口不符 —— 进程重启导致端口变化。
          3. bridge 不存在但残留桥定义 —— 清理旧端口（避免哑火）。
        """
        if f"// FX_EDITOR_VER: {INLINE_EDITOR_JS_VER}" not in html:
            return True
        if self.bridge is not None:
            if f"// SMTK_BRIDGE_PORT: {self.bridge.port}" not in html:
                return True
        else:
            if "// SMTK_BRIDGE_PORT:" in html:
                return True
        return False

    # ── 图片渲染 ────────────────────────────────────────────────
    def _hash_text(self, text: str) -> str:
        return hashlib.sha256(text.encode("utf-8")).hexdigest()[:8]

    def _render_img(self, text: str) -> str:
        h = self._hash_text(text)
        img_path = self.image_dir / f"formula_{h}.png"

        if not img_path.exists():
            try:
                latex2img_md(
                    text=regex.sub(r"\${2,}", "$$", text),
                    out=img_path,
                    size=32,
                    color=(0.1, 0.1, 0.1),
                )
            except Exception as e:
                # 渲染失败打印日志，不阻断整张卡片的处理
                print(f"[渲染失败] 公式: {text}\n错误信息: {e}")
                return ""  # 返回空 src，交由外层处理

        return f"file:///[PrimaryStorage]local_pic/formula_{h}.png"

    def _build_fx_tag(self, soup, src: str, is_block: bool):
        self.changed = True
        h = self._hash_text(src)
        img_src = self._render_img(src)

        # 如果渲染失败，返回原始源码文本，不回退为图片
        if not img_src:
            return NavigableString(src)

        fx = soup.new_tag("div" if is_block else "span")
        fx["class"] = ["smtk-formula", "smtk-block" if is_block else "smtk-inline"]
        fx["id"] = f"fx-{h}"
        if is_block:
            fx["style"] = "text-align: center; margin: 1.5em 0;"

        img = soup.new_tag(
            "img",
            attrs={
                "class": "smtk-fx-img",
                "src": img_src,
                "alt": src,
                "style": "max-width: 100%; display: block; margin: 0 auto;"
                if is_block
                else "max-height: 1.5em; vertical-align: middle;",
            },
        )

        link = soup.new_tag(
            "a",
            attrs={
                "href": "#",
                "onclick": f"return fxEditClick('fx-{h}');",
                "style": "font-size: 12px; color: #999999; text-decoration: none; cursor: pointer;"
                if is_block
                else "text-decoration: none; cursor: pointer;",
            },
        )
        link.string = "编辑公式" if is_block else "✎"

        if is_block:
            src_span = soup.new_tag(
                "div",
                attrs={
                    "class": "smtk-fx-src",
                    "style": "display: block; font-size: 11px; color: #cccccc; margin-top: 6px;",
                },
            )
            src_span.string = src
            btn_div = soup.new_tag("div", attrs={"style": "margin-top: 4px;"})
            btn_div.append(link)
            fx.extend([img, src_span, btn_div])
        else:
            fx.extend([img, NavigableString(" "), link])

        return fx

    def _replace_plain_formulas(self, soup, text_node, pattern, is_block):
        if (
            text_node.parent.name in ("script", "style", "textarea", "code")
            or isinstance(text_node, Comment)
            or text_node.find_parent(class_="smtk-formula")
        ):
            return

        parts = pattern.split(str(text_node))
        new_nodes = [
            NavigableString(part)
            if i % 2 == 0
            else self._build_fx_tag(
                soup,
                f"{'$$$' if is_block else '$$'}{part}{'$$$' if is_block else '$$'}",
                is_block,
            )
            for i, part in enumerate(parts)
            if part
        ]
        text_node.replace_with(*new_nodes)  # 极致优雅：一步替换整段节点

    # ── 主流程 ──────────────────────────────────────────────────
    def process_html(self, html: str) -> str:
        self.changed = False
        if not PRE_CHECK_RE.search(html):
            return html

        needs_script_update = self._needs_script_update(html)
        soup = BeautifulSoup(html, "html.parser")

        if needs_script_update:
            for script in soup.find_all("script"):
                if script.string and "fxEditClick" in script.string:
                    script.decompose()
                    self.changed = True

        # 1. 重构已存在但过期的公式节点
        for fx in soup.find_all(class_="smtk-formula"):
            img = fx.find("img", class_="smtk-fx-img")
            if not img or not img.get("alt"):
                continue

            h = self._hash_text(img["alt"])
            a_tag = fx.find("a")

            # 严格断言：只要 pending、哈希不符、或者 <a> 标签被篡改，立刻触发重建
            need_rebuild = (
                fx.find(class_="fx-pending") is not None
                or fx.get("id") != f"fx-{h}"
                or a_tag is None
                or a_tag.get("href") != "#"
                or a_tag.get("onclick") != f"return fxEditClick('fx-{h}');"
            )

            if need_rebuild:
                is_block = "smtk-block" in fx.get("class", [])
                fx.replace_with(self._build_fx_tag(soup, img["alt"], is_block))

        # 2. 扫描并替换裸文本中的公式
        for text_node in soup.find_all(string=BLOCK_FORMULA_RE):
            self._replace_plain_formulas(
                soup, text_node, BLOCK_FORMULA_RE, is_block=True
            )

        for text_node in soup.find_all(string=INLINE_FORMULA_RE):
            self._replace_plain_formulas(
                soup, text_node, INLINE_FORMULA_RE, is_block=False
            )

        # 3. 注入脚本
        if soup.find(class_="smtk-formula") and needs_script_update:
            script = soup.new_tag("script", attrs={"type": "text/javascript"})
            script.string = self._script_payload()
            (soup.body or soup).append(script)
            self.changed = True

        if not self.changed:
            return html

        return "".join(str(x) for x in soup.body.children) if soup.body else str(soup)

    def process_file(self, path: str | Path, new_html: str | None = None) -> bool:
        path = Path(path)
        if new_html is None:
            with open(path, "r", encoding="utf-8", errors="ignore") as f:
                new_html = self.process_html(f.read())
            if not self.changed:
                return False

        fd, tmp_path = tempfile.mkstemp(
            prefix=".sm_tmp_", suffix=".htm", dir=path.parent
        )
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as f:
                f.write(new_html)
                f.flush()
                os.fsync(f.fileno())
            os.replace(tmp_path, path)
            return True
        except BaseException:
            if os.path.exists(tmp_path):
                try:
                    os.remove(tmp_path)
                except OSError:
                    pass
            raise

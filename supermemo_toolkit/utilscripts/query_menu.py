# -*- coding: utf-8 -*-
"""
菜单项信息查看器 — 叶子菜单版（信息栏支持换行）

表格列：菜单位置 / 类型 / 可执行 ID / 状态
    · 叶子       → 能执行，显示真实 ID
    · 子菜单 ▸   → 展开项，本身无命令 ID，显示 —
    · 分隔符     → 横线，显示 —

交互：
    双击叶子行  → 复制菜单 ID（该行闪绿）
    滚轮        → 滚动长菜单
    F5          → 清除冻结的快照

依赖：pip install pywin32
"""

import ctypes
import ctypes.wintypes
import tkinter as tk
from tkinter import ttk

import win32gui

# ---------- 高分屏适配 ----------
try:
    ctypes.windll.shcore.SetProcessDpiAwareness(1)
except Exception:
    try:
        ctypes.windll.user32.SetProcessDPIAware()
    except Exception:
        pass


# ============================================================
# 常量
# ============================================================
WM_GETMENU = 0x01E1

MFS_CHECKED = 0x0008
MFS_DEFAULT = 0x1000
MFS_DISABLED = 0x0002
MFS_GRAYED = 0x0001
MFS_HILITE = 0x0080

MIIM_STATE = 0x0001
MIIM_ID = 0x0002
MIIM_SUBMENU = 0x0004
MIIM_FTYPE = 0x0100

MFT_SEPARATOR = 0x0800

POPUP_CLASS = "#32768"

INVALID_IDS = (-1, 0, 0xFFFFFFFF)


class MENUITEMINFO(ctypes.Structure):
    _fields_ = [
        ("cbSize", ctypes.c_uint),
        ("fMask", ctypes.c_uint),
        ("fType", ctypes.c_uint),
        ("fState", ctypes.c_uint),
        ("wID", ctypes.c_uint),
        ("hSubMenu", ctypes.c_void_p),
        ("hbmpChecked", ctypes.c_void_p),
        ("hbmpUnchecked", ctypes.c_void_p),
        ("dwItemData", ctypes.c_void_p),
        ("dwTypeData", ctypes.c_void_p),
        ("cch", ctypes.c_uint),
        ("hbmpItem", ctypes.c_void_p),
    ]


# ============================================================
# Windows API 封装
# ============================================================
def _get_menu_handle(hwnd):
    return win32gui.SendMessage(hwnd, WM_GETMENU)


def _is_popup(hwnd):
    try:
        return win32gui.GetClassName(hwnd) == POPUP_CLASS
    except Exception:
        return False


def _get_mii(hwnd, position, mask):
    if not _is_popup(hwnd):
        return None
    hmenu = _get_menu_handle(hwnd)
    if not hmenu:
        return None
    mii = MENUITEMINFO()
    mii.cbSize = ctypes.sizeof(MENUITEMINFO)
    mii.fMask = mask
    ok = ctypes.windll.user32.GetMenuItemInfoW(hmenu, position, True, ctypes.byref(mii))
    return mii if ok else None


def get_menu_item_info(hwnd, position):
    mii = _get_mii(hwnd, position, MIIM_FTYPE | MIIM_SUBMENU | MIIM_ID | MIIM_STATE)
    if not mii:
        return {"ftype": 0, "has_submenu": False, "wid": 0xFFFFFFFF, "state": -1}
    return {
        "ftype": mii.fType,
        "has_submenu": bool(mii.hSubMenu),
        "wid": mii.wID,
        "state": mii.fState,
    }


def classify_item(info):
    if info["ftype"] & MFT_SEPARATOR:
        return "separator", "分隔符"
    if info["has_submenu"]:
        return "submenu", "子菜单 ▸"
    return "leaf", "叶子"


def describe_state(state):
    if state < 0:
        return "未知"
    parts = []
    parts.append("禁用" if (state & (MFS_GRAYED | MFS_DISABLED)) else "启用")
    if state & MFS_CHECKED:
        parts.append("已勾选")
    if state & MFS_DEFAULT:
        parts.append("默认")
    if state & MFS_HILITE:
        parts.append("★ 高亮")
    return "  ·  ".join(parts)


# ============================================================
# GUI
# ============================================================
class MenuInspectorApp:
    def __init__(self, root):
        self.root = root
        self.root.title("菜单项 ID 查看器")
        self.root.geometry("600x820")
        self.root.minsize(500, 720)
        self.root.configure(bg="#1e222b")

        self.refresh_ms = 250
        self._after_id = None
        self._last_sig = None
        self._has_data = False
        self._flash_jobs = {}

        self._build_ui()
        self._schedule()

    # ---------- UI ----------
    def _build_ui(self):
        # ===== 顶部信息栏（高度自适应，支持换行）=====
        header = tk.Frame(self.root, bg="#252a36")
        header.pack(fill=tk.X, side=tk.TOP)

        self.info_var = tk.StringVar(value="等待检测…把鼠标移到弹出菜单上")
        self.info_label = tk.Label(
            header,
            textvariable=self.info_var,
            bg="#252a36",
            fg="#7dd3fc",
            font=("Microsoft YaHei UI", 11, "bold"),
            anchor="w",
            justify="left",
            padx=16,
            pady=8,
        )
        self.info_label.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)

        topmost_box = tk.Frame(header, bg="#252a36")
        topmost_box.pack(side=tk.RIGHT, padx=(0, 12), anchor="n")
        self.topmost_var = tk.BooleanVar(value=True)
        tk.Checkbutton(
            topmost_box,
            text="置顶",
            variable=self.topmost_var,
            command=self._toggle_topmost,
            bg="#252a36",
            fg="#9ca3af",
            selectcolor="#252a36",
            activebackground="#252a36",
            activeforeground="#e5e7eb",
            font=("Microsoft YaHei UI", 9),
            borderwidth=0,
        ).pack(pady=8)

        def _on_header_configure(event):
            wrap = max(event.width - 160, 240)
            self.info_label.config(wraplength=wrap)

        header.bind("<Configure>", _on_header_configure)

        # ===== 表格 =====
        body = tk.Frame(self.root, bg="#1e222b")
        body.pack(fill=tk.BOTH, expand=True, padx=10, pady=(0, 8))

        style = ttk.Style()
        try:
            style.theme_use("clam")
        except Exception:
            pass
        style.configure(
            "Menu.Treeview",
            background="#ffffff",
            fieldbackground="#ffffff",
            foreground="#1f2937",
            font=("Microsoft YaHei UI", 10),
            rowheight=32,
            borderwidth=0,
        )
        style.configure(
            "Menu.Treeview.Heading",
            background="#e5e7eb",
            foreground="#374151",
            font=("Microsoft YaHei UI", 10, "bold"),
            relief="flat",
            padding=6,
        )
        style.map(
            "Menu.Treeview",
            background=[("selected", "#3b82f6")],
            foreground=[("selected", "#ffffff")],
        )

        columns = ("pos", "kind", "mid", "state")
        self.tree = ttk.Treeview(
            body,
            columns=columns,
            show="headings",
            style="Menu.Treeview",
            selectmode="browse",
        )
        self.tree.heading("pos", text="菜单位置")
        self.tree.heading("kind", text="类型")
        self.tree.heading("mid", text="可执行 ID")
        self.tree.heading("state", text="状态")

        self.tree.column("pos", width=90, minwidth=70, anchor="center", stretch=False)
        self.tree.column("kind", width=100, minwidth=80, anchor="center", stretch=False)
        self.tree.column("mid", width=120, minwidth=90, anchor="center", stretch=False)
        self.tree.column("state", width=100, minwidth=70, anchor="w")

        self.tree.tag_configure("odd", background="#f8fafc")
        self.tree.tag_configure("even", background="#ffffff")
        self.tree.tag_configure("hilite", background="#fff3b0", foreground="#7c2d12")
        self.tree.tag_configure("flash", background="#86efac", foreground="#064e3b")
        self.tree.tag_configure("submenu", background="#e0e7ff", foreground="#1e3a8a")
        self.tree.tag_configure("sep", background="#e5e7eb", foreground="#9ca3af")

        vsb = ttk.Scrollbar(body, orient="vertical", command=self.tree.yview)
        self.tree.configure(yscrollcommand=vsb.set)
        self.tree.pack(side=tk.LEFT, fill=tk.BOTH, expand=True)
        vsb.pack(side=tk.RIGHT, fill=tk.Y)

        # ===== 底部提示 =====
        tip = tk.Label(
            self.root,
            text='只有"叶子"能执行    ·    双击叶子行 → 复制 ID    ·    F5 清除快照',
            bg="#1e222b",
            fg="#6b7280",
            font=("Microsoft YaHei UI", 9),
            anchor="w",
            padx=12,
        )
        tip.pack(fill=tk.X, side=tk.BOTTOM, pady=(0, 6))

        # ===== 事件 =====
        self.tree.bind("<Double-1>", self._on_double_click)
        self.root.bind("<F5>", self._on_clear)

        self.root.attributes("-topmost", True)

    # ---------- 刷新 ----------
    def _schedule(self):
        self._after_id = self.root.after(self.refresh_ms, self._tick)

    def _tick(self):
        try:
            self._update()
        except Exception as exc:
            self.info_var.set(f"⚠ 检测出错：{exc}")
        self._schedule()

    def _update(self):
        pt = ctypes.wintypes.POINT()
        ctypes.windll.user32.GetCursorPos(ctypes.byref(pt))
        hwnd = ctypes.windll.user32.WindowFromPoint(pt)

        cls = ""
        if hwnd:
            try:
                cls = win32gui.GetClassName(hwnd)
            except Exception:
                cls = ""

        if cls != POPUP_CLASS:
            if self._has_data:
                self.info_var.set(
                    "❄ 已冻结 · 菜单已关闭，内容保留着（双击叶子复制ID，F5 清除）"
                )
                self.info_label.config(fg="#fbbf24")
            else:
                self.info_var.set(
                    f"等待检测…把鼠标移到弹出菜单上（当前窗口类名：{cls or '未知'}）"
                )
                self.info_label.config(fg="#7dd3fc")
            return

        hmenu = _get_menu_handle(hwnd)
        count = ctypes.windll.user32.GetMenuItemCount(hmenu) if hmenu else 0

        rows = []
        for i in range(max(count, 0)):
            info = get_menu_item_info(hwnd, i)
            kind_code, kind_disp = classify_item(info)
            rows.append(
                {
                    "pos": i + 1,
                    "kind_code": kind_code,
                    "kind_disp": kind_disp,
                    "mid": info["wid"],
                    "state": info["state"],
                }
            )

        leaf_count = sum(
            1 for r in rows if r["kind_code"] == "leaf" and r["mid"] not in INVALID_IDS
        )

        self.info_var.set(
            f"弹出菜单 · 窗口 0x{hwnd:08X} · 菜单 0x{(hmenu or 0):08X}"
            f" · 共 {len(rows)} 项，其中可执行 {leaf_count} 项"
        )
        self.info_label.config(fg="#7dd3fc")
        self._render(hwnd, rows)
        self._has_data = True

    def _render(self, hwnd, rows):
        sig = (
            hwnd,
            tuple((r["pos"], r["kind_code"], r["mid"], r["state"]) for r in rows),
        )
        if sig == self._last_sig:
            return
        self._last_sig = sig

        for jid in self._flash_jobs.values():
            try:
                self.root.after_cancel(jid)
            except Exception:
                pass
        self._flash_jobs.clear()

        prev_mid = None
        sel = self.tree.selection()
        if sel:
            prev_mid = self.tree.item(sel[0], "values")[2]

        self.tree.delete(*self.tree.get_children())

        for r in rows:
            kind = r["kind_code"]
            mid = r["mid"]

            if kind == "leaf" and mid not in INVALID_IDS:
                mid_disp = str(mid)
            else:
                mid_disp = "—"

            tags = ["odd" if r["pos"] % 2 else "even"]
            if kind == "submenu":
                tags.append("submenu")
            elif kind == "separator":
                tags.append("sep")
            if r["state"] >= 0 and (r["state"] & MFS_HILITE):
                tags.append("hilite")

            item = self.tree.insert(
                "",
                "end",
                values=(
                    r["pos"],
                    r["kind_disp"],
                    mid_disp,
                    describe_state(r["state"]),
                ),
                tags=tuple(tags),
            )
            if prev_mid is not None and mid_disp == str(prev_mid):
                self.tree.selection_set(item)

    # ---------- 交互 ----------
    def _on_double_click(self, event):
        row = self.tree.identify_row(event.y)
        if not row:
            return
        vals = self.tree.item(row, "values")
        kind = vals[1]
        mid = vals[2]

        if kind == "分隔符":
            self.info_var.set("分隔符没有菜单 ID")
            self.info_label.config(fg="#f87171")
            return
        if kind == "子菜单 ▸":
            self.info_var.set("子菜单本身没有命令 ID（ID 在它的子项里）")
            self.info_label.config(fg="#f87171")
            return
        if mid == "—":
            self.info_var.set("这一项没有可读取的菜单 ID")
            self.info_label.config(fg="#f87171")
            return

        self.root.clipboard_clear()
        self.root.clipboard_append(str(mid))
        self.tree.selection_set(row)
        self._flash(row)
        self.info_var.set(f"✔ 已复制菜单 ID：{mid}")
        self.info_label.config(fg="#34d399")

    def _flash(self, row):
        if not self.tree.exists(row):
            return
        try:
            orig = self.tree.item(row, "tags")
        except Exception:
            orig = ()

        self.tree.item(row, tags=("flash",))

        def restore():
            if self.tree.exists(row):
                try:
                    self.tree.item(row, tags=orig)
                except Exception:
                    pass
            self._flash_jobs.pop(row, None)

        self._flash_jobs[row] = self.root.after(280, restore)

    def _on_clear(self, _event=None):
        for jid in self._flash_jobs.values():
            try:
                self.root.after_cancel(jid)
            except Exception:
                pass
        self._flash_jobs.clear()

        self._has_data = False
        self._last_sig = None
        self.tree.delete(*self.tree.get_children())
        self.info_var.set("已清除，等待检测…")
        self.info_label.config(fg="#7dd3fc")

    def _toggle_topmost(self):
        self.root.attributes("-topmost", self.topmost_var.get())


# ============================================================
# 入口
# ============================================================
def main():
    root = tk.Tk()
    MenuInspectorApp(root)
    root.mainloop()


if __name__ == "__main__":
    main()

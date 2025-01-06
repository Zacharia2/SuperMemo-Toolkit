import os
import sys
import tkinter as tk
from tkinter import filedialog

sys.path.insert(0, os.path.normpath(sys.path[0] + "/../../"))
from supermemo_toolkit.utilscripts import config
from supermemo_toolkit.pathpix import im_sort_out as pathpix

"""
author: st
date: 2024-01-08
modify: 明玥
date: 2024-01-09
"""

config_dir = config.get_config_dir()
conf_path = os.path.join(config_dir, "conf.json")


def save_path_to_file(path, file_name):
    """将路径保存到文件"""
    with open(file_name, "w") as file:
        file.write(path)


def load_path_from_file(file_name):
    """从文件加载路径"""
    try:
        with open(file_name, "r") as file:
            return file.read().strip()
    except FileNotFoundError:
        return ""


def choose_file(entry):
    """选择文件并更新编辑框及保存路径"""
    file_path = filedialog.askopenfilename()
    if file_path:
        entry.delete(0, tk.END)
        entry.insert(0, file_path)


def choose_directory(entry):
    """选择目录并更新编辑框及保存路径"""
    path = filedialog.askdirectory()
    if path:
        entry.delete(0, tk.END)
        entry.insert(0, path)


def refresh_list():
    # 获取第一个编辑框的目录路径
    directory_path = entry1.get()

    # 调用get_collections_primaryStorage方法，获取集合数据
    collections = config.get_collections_primaryStorage(directory_path)

    # 检查集合是否为空
    if not collections:
        tk.messagebox.showerror("错误", "未找到任何集合")

    # 清空列表框中的现有项
    listbox.delete(0, tk.END)

    # 将集合名称插入到列表框中
    for collection_name in collections:
        listbox.insert(tk.END, collection_name)


def start_repair():
    # 禁用按钮
    start_repair_button.config(state="disabled")

    # 检查是否有选中的数据项
    selected_items = listbox.curselection()
    if not selected_items:
        tk.messagebox.showerror("错误", "请选择要修复的集合")
        # 启用按钮
        start_repair_button.config(state="normal")
        return

    # 获取第一个编辑框的目录路径
    sm_location = entry1.get()

    # 获取选中的集合名称
    selected_collection = listbox.get(selected_items[0])

    # 使用集合名称调用config.get_collection_primaryStorage方法，获取集合路径
    collection_path = config.get_collection_primaryStorage(
        sm_location, selected_collection
    )

    # 检查是否成功获取了集合路径
    if not collection_path:
        tk.messagebox.showerror("错误", "无法获取选中集合的路径")
        # 启用按钮
        start_repair_button.config(state="normal")
        return

    # 调用pathpix.start()开始修复
    pathpix.start(collection_path)
    tk.messagebox.showinfo("信息", "修复已完成")

    # 启用按钮
    start_repair_button.config(state="normal")


def individual_repair():
    """单个修复"""
    # 获取第二个编辑框的文件路径
    fullpath = entry2.get()

    # 检查文件路径是否有效
    if not fullpath:
        tk.messagebox.showerror("错误", "请输入有效的文件路径")
        return

    # 检查文件后缀是否为 .htm
    if not fullpath.lower().endswith(".htm"):
        tk.messagebox.showerror("错误", "文件后缀必须为 .htm")
        return

    # 调用 pathpix.single(fullpath) 开始单个修复
    pathpix.single_file(fullpath)
    tk.messagebox.showinfo("信息", "单个修复已完成")


def clear_redundancy():
    """清除冗余"""
    # 禁用清除冗余按钮
    clear_redundancy_button.config(state="disabled")

    # 获取第一个编辑框的目录路径
    sm_location = entry1.get()

    # 获取选中的集合名称
    selected_items = listbox.curselection()
    if not selected_items:
        tk.messagebox.showerror("错误", "请选择要清除冗余的集合")
        clear_redundancy_button.config(state="normal")  # 恢复按钮状态
        return
    selected_collection = listbox.get(selected_items[0])

    # 使用集合名称调用config.get_collection_primaryStorage方法，获取集合路径
    elements_path = config.get_collection_primaryStorage(
        sm_location, selected_collection
    )

    # 检查是否成功获取了集合路径
    if not elements_path:
        tk.messagebox.showerror("错误", "无法获取选中集合的路径")
        clear_redundancy_button.config(state="normal")  # 恢复按钮状态
        return

    # 调用pathpix.organize_unused_im(elements_path)开始清除冗余
    pathpix.organize_unused_im(elements_path)
    tk.messagebox.showinfo("信息", "清除冗余已完成")

    # 恢复按钮状态为NORMAL，使其再次可用
    clear_redundancy_button.config(state="normal")


# 保存两个编辑框内容到文件的函数
def save_entries_on_exit():
    try:
        conf_json = {"program": entry1.get(), "entry2": entry2.get()}
        config.update_config(conf_path, conf_json)
    except Exception as e:
        print("保存时出现错误:", str(e))
        # 在这里加入一行代码，手动关闭主窗口
    root.destroy()


# 创建主窗口
root = tk.Tk()
root.title("UI Layout")
root.geometry("400x300")
font_style = ("Arial", 10)

# 第一个编辑框和按钮
frame1 = tk.Frame(root)
frame1.pack(fill="x", padx=10, pady=5)
button1 = tk.Button(
    frame1,
    text="所有路径",
    font=font_style,
    command=lambda: choose_directory(entry1),
)
button1.pack(side="left", padx=5)
entry1 = tk.Entry(frame1, font=font_style)
entry1.pack(fill="x", expand=True, side="left", padx=5)

# 第二个编辑框和按钮
frame2 = tk.Frame(root)
frame2.pack(fill="x", padx=10, pady=5)
button2 = tk.Button(
    frame2,
    text="单个路径",
    font=font_style,
    command=lambda: choose_file(entry2),
)
button2.pack(side="left", padx=5)
entry2 = tk.Entry(frame2, font=font_style)
entry2.pack(fill="x", expand=True, side="left", padx=5)

# 列表
listbox = tk.Listbox(root, font=font_style)
listbox.pack(padx=10, pady=5, fill="x")


# 底部的按钮
frame3 = tk.Frame(root)
frame3.pack(fill="x", padx=10, pady=5)

# 开始修复按钮
start_repair_button = tk.Button(
    frame3, text="开始修复", font=font_style, command=start_repair
)
start_repair_button.pack(side="left", padx=5)

# 单个修复按钮
individual_repair_button = tk.Button(
    frame3, text="单个修复", font=font_style, command=individual_repair
)
individual_repair_button.pack(side="left", padx=5)

# 刷新列表按钮
refresh_button = tk.Button(
    frame3, text="刷新列表", font=font_style, command=refresh_list
)
refresh_button.pack(side="left", padx=5)

# 清除冗余按钮
clear_redundancy_button = tk.Button(
    frame3, text="清除冗余", font=font_style, command=clear_redundancy
)
clear_redundancy_button.pack(side="left", padx=5)


def run():
    # 读取配置文件
    m_conf = config.read_config(conf_path)
    # 加载保存的路径到编辑框
    if "program" in m_conf:
        entry1.insert(0, m_conf["program"])
    if "entry2" in m_conf:
        entry2.insert(0, m_conf["entry2"])

    # 将 save_entries_on_exit 函数绑定到窗口的关闭事件
    root.protocol("WM_DELETE_WINDOW", save_entries_on_exit)
    # 运行主循环
    root.mainloop()

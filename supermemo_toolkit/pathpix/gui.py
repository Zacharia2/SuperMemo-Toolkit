import os
from tkinter import END, Listbox, Tk, filedialog, messagebox
from tkinter.ttk import Button, Entry, Frame
from supermemo_toolkit.utilscripts import config
from supermemo_toolkit.pathpix import im_sort_out as pathpix

"""
author: st
date: 2024-01-08
modify: 霆枢
mdate: 2025-12-03
"""


class PathPixUI(Tk):
    def __init__(self):
        super().__init__()
        self.__win()
        self.__creat_component()
        self.conf_path = os.path.join(config.get_config_dir(), "conf.json")

    def __win(self):
        # 设置窗口大小、居中
        self.title("PathPixUI")
        width = 500
        height = 350
        screenwidth = self.winfo_screenwidth()
        screenheight = self.winfo_screenheight()
        geometry = "%dx%d+%d+%d" % (
            width,
            height,
            (screenwidth - width) / 2,
            (screenheight - height) / 2,
        )
        self.geometry(geometry)
        self.minsize(width=width, height=height)
        self.resizable(False, False)

    def __creat_component(self):
        # 第一个编辑框和按钮
        self.frame1 = Frame(self)
        self.frame1.pack(fill="x", padx=10, pady=5)
        self.button1 = Button(
            self.frame1,
            text="软件的根目录",
            command=lambda: self.choose_directory(self.entry1),
        )
        self.button1.pack(side="left", padx=5)
        self.entry1 = Entry(self.frame1)
        self.entry1.pack(fill="x", expand=True, side="left", padx=5)

        # 第二个编辑框和按钮
        self.frame2 = Frame(self)
        self.frame2.pack(fill="x", padx=10, pady=5)
        self.button2 = Button(
            self.frame2,
            text="单个集合路径",
            command=lambda: self.choose_file(self.single),
        )
        self.button2.pack(side="left", padx=5)
        self.single = Entry(self.frame2)
        self.single.pack(fill="x", expand=True, side="left", padx=5)

        # 列表
        self.listbox = Listbox(self)
        self.listbox.pack(padx=10, pady=5, fill="x")

        # 底部的按钮
        self.frame3 = Frame(self)
        self.frame3.pack(fill="x", padx=10, pady=5)

        # 刷新列表按钮
        self.refresh_button = Button(
            self.frame3,
            text="刷新列表",
            command=self.refresh_list,
        )
        self.refresh_button.pack(side="left", padx=5)

        # 开始修复按钮
        self.start_repair_button = Button(
            self.frame3,
            text="开始修复",
            command=self.start_repair,
        )
        self.start_repair_button.pack(side="left", padx=5)

        # 清除冗余按钮
        self.clear_redundancy_button = Button(
            self.frame3,
            text="清除冗余",
            command=self.clear_redundancy,
        )
        self.clear_redundancy_button.pack(side="left", padx=5)

        # 单个修复按钮
        self.individual_repair_button = Button(
            self.frame3,
            text="单个修复",
            command=self.individual_repair,
        )
        self.individual_repair_button.pack(side="left", padx=5)

    def save_path_to_file(self, path, file_name):
        """将路径保存到文件"""
        with open(file_name, "w") as file:
            file.write(path)

    def load_path_from_file(self, file_name):
        """从文件加载路径"""
        try:
            with open(file_name, "r") as file:
                return file.read().strip()
        except FileNotFoundError:
            return ""

    def choose_file(self, entry):
        """选择文件并更新编辑框及保存路径"""
        file_path = filedialog.askopenfilename()
        if file_path:
            entry.delete(0, END)
            entry.insert(0, file_path)

    def choose_directory(self, entry):
        """选择目录并更新编辑框及保存路径"""
        path = filedialog.askdirectory()
        if path:
            entry.delete(0, END)
            entry.insert(0, path)

    def refresh_list(self):
        # 获取第一个编辑框的目录路径
        directory_path = self.entry1.get()

        # 调用get_collections_primaryStorage方法，获取集合数据
        collections = config.get_collections_primaryStorage(directory_path)

        # 检查集合是否为空
        if not collections:
            messagebox.showerror("错误", "未找到任何集合")

        # 清空列表框中的现有项
        self.listbox.delete(0, END)

        # 将集合名称插入到列表框中
        for collection_name in collections:
            self.listbox.insert(END, collection_name)

    def start_repair(self):
        # 禁用按钮
        self.start_repair_button.config(state="disabled")

        # 检查是否有选中的数据项
        selected_items = self.listbox.curselection()
        if not selected_items:
            messagebox.showerror("错误", "请选择要修复的集合")
            # 启用按钮
            self.start_repair_button.config(state="normal")
            return

        # 获取第一个编辑框的目录路径
        sm_location = self.entry1.get()

        # 获取选中的集合名称
        selected_collection = self.listbox.get(selected_items[0])

        # 使用集合名称调用config.get_collection_primaryStorage方法，获取集合路径
        collection_path = config.get_collection_primaryStorage(
            sm_location, selected_collection
        )

        # 检查是否成功获取了集合路径
        if not collection_path:
            messagebox.showerror("错误", "无法获取选中集合的路径")
            # 启用按钮
            self.start_repair_button.config(state="normal")
            return

        # 调用pathpix.start()开始修复
        pathpix.start(collection_path)
        messagebox.showinfo("信息", "修复已完成")

        # 启用按钮
        self.start_repair_button.config(state="normal")

    def individual_repair(self):
        """单个修复"""
        # 获取第二个编辑框的文件路径
        fullpath = self.single.get()

        # 检查文件路径是否有效
        if not fullpath:
            messagebox.showerror("错误", "请输入有效的文件路径")
            return

        # 检查文件后缀是否为 .htm
        if not fullpath.lower().endswith(".htm"):
            messagebox.showerror("错误", "文件后缀必须为 .htm")
            return

        # 调用 pathpix.single(fullpath) 开始单个修复
        pathpix.single_file(fullpath)
        messagebox.showinfo("信息", "单个修复已完成")

    def clear_redundancy(self):
        """清除冗余"""
        # 禁用清除冗余按钮
        self.clear_redundancy_button.config(state="disabled")

        # 获取第一个编辑框的目录路径
        sm_location = self.entry1.get()

        # 获取选中的集合名称
        selected_items = self.listbox.curselection()
        if not selected_items:
            messagebox.showerror("错误", "请选择要清除冗余的集合")
            self.clear_redundancy_button.config(state="normal")  # 恢复按钮状态
            return
        selected_collection = self.listbox.get(selected_items[0])

        # 使用集合名称调用config.get_collection_primaryStorage方法，获取集合路径
        elements_path = config.get_collection_primaryStorage(
            sm_location, selected_collection
        )

        # 检查是否成功获取了集合路径
        if not elements_path:
            messagebox.showerror("错误", "无法获取选中集合的路径")
            self.clear_redundancy_button.config(state="normal")  # 恢复按钮状态
            return

        # 调用pathpix.organize_unused_im(elements_path)开始清除冗余
        pathpix.organize_unused_im(elements_path)
        messagebox.showinfo("信息", "清除冗余已完成")

        # 恢复按钮状态为NORMAL，使其再次可用
        self.clear_redundancy_button.config(state="normal")

    # 保存两个编辑框内容到文件的函数
    def save_entries_on_exit(self):
        try:
            conf_json = {"program": self.entry1.get(), "single": self.single.get()}
            config.dump_config(self.conf_path, conf_json)
        except Exception as e:
            print("保存时出现错误:", str(e))
            # 在这里加入一行代码，手动关闭主窗口
        self.destroy()

    def run(self):
        # 读取配置文件
        m_conf = config.read_config(self.conf_path)
        # 加载保存的路径到编辑框
        if "program" in m_conf:
            self.entry1.insert(0, m_conf["program"])
        if "single" in m_conf:
            self.single.insert(0, m_conf["single"])

        # 将 save_entries_on_exit 函数绑定到窗口的关闭事件
        self.protocol("WM_DELETE_WINDOW", self.save_entries_on_exit)
        # 运行主循环
        self.mainloop()


def run_pathpix_ui():
    pathpixui = PathPixUI()
    pathpixui.run()


if __name__ == "__main__":
    run_pathpix_ui()

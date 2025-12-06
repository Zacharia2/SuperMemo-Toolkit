from tkinter import Menu, Tk
from tkinter.ttk import Button, Label, Scrollbar


class WinGUI(Tk):
    def __init__(self):
        super().__init__()
        self.__win()
        self.tk_label_miik3tat = self.__tk_label_miik3tat(self)
        self.tk_button_miik3xn9 = self.__tk_button_miik3xn9(self)
        self.tk_button_miileno7 = self.__tk_button_miileno7(self)
        self.tk_button_mipjikfh = self.__tk_button_mipjikfh(self)

    def __win(self):
        self.title("AutoTTS")
        # 设置窗口大小、居中
        width = 450
        height = 35
        screenwidth = self.winfo_screenwidth()
        # screenheight = self.winfo_screenheight()
        self.geometry_size = "%dx%d+%d+%d" % (
            width,
            height,
            (screenwidth - width) / 2,
            8,
        )

        self.geometry(self.geometry_size)

        self.minsize(width=width, height=height)
        self.overrideredirect(True)
        # self.attributes("-toolwindow", True)
        self.attributes("-topmost", True)
        self.attributes("-alpha", 0.6)
        self.resizable(False, False)

        def on_drag_start(event):
            self.x_start = event.x_root
            self.y_start = event.y_root

        def on_drag_motion(event):
            delta_x = event.x_root - self.x_start
            delta_y = event.y_root - self.y_start
            x_new = self.winfo_x() + delta_x
            y_new = self.winfo_y() + delta_y
            self.geometry(f"+{x_new}+{y_new}")

            self.x_start = event.x_root
            self.y_start = event.y_root

        self.bind("<Button-1>", on_drag_start)
        self.bind("<B1-Motion>", on_drag_motion)
        # 右键菜单
        self.menu = Menu(self, tearoff=0, bg="white", fg="black")
        self.bind("<Button-3>", self.show_menu)

    def show_menu(self, event):
        """显示右键菜单"""
        if event.widget is not self.tk_button_miik3xn9:
            self.menu.post(event.x_root, event.y_root)

    def scrollbar_autohide(self, vbar, hbar, widget):
        """自动隐藏滚动条"""

        def show():
            if vbar:
                vbar.lift(widget)
            if hbar:
                hbar.lift(widget)

        def hide():
            if vbar:
                vbar.lower(widget)
            if hbar:
                hbar.lower(widget)

        hide()
        widget.bind("<Enter>", lambda e: show())
        if vbar:
            vbar.bind("<Enter>", lambda e: show())
        if vbar:
            vbar.bind("<Leave>", lambda e: hide())
        if hbar:
            hbar.bind("<Enter>", lambda e: show())
        if hbar:
            hbar.bind("<Leave>", lambda e: hide())
        widget.bind("<Leave>", lambda e: hide())

    def v_scrollbar(self, vbar, widget, x, y, w, h, pw, ph):
        widget.configure(yscrollcommand=vbar.set)
        vbar.config(command=widget.yview)
        vbar.place(relx=(w + x) / pw, rely=y / ph, relheight=h / ph, anchor="ne")

    def h_scrollbar(self, hbar, widget, x, y, w, h, pw, ph):
        widget.configure(xscrollcommand=hbar.set)
        hbar.config(command=widget.xview)
        hbar.place(relx=x / pw, rely=(y + h) / ph, relwidth=w / pw, anchor="sw")

    def create_bar(self, master, widget, is_vbar, is_hbar, x, y, w, h, pw, ph):
        vbar, hbar = None, None
        if is_vbar:
            vbar = Scrollbar(master)
            self.v_scrollbar(vbar, widget, x, y, w, h, pw, ph)
        if is_hbar:
            hbar = Scrollbar(master, orient="horizontal")
            self.h_scrollbar(hbar, widget, x, y, w, h, pw, ph)
        self.scrollbar_autohide(vbar, hbar, widget)

    def __tk_label_miik3tat(self, parent):
        label = Label(
            parent,
            text="状态",
            anchor="center",
        )
        label.place(relx=0.2000, rely=0.0000, relwidth=0.7956, relheight=1.0000)
        return label

    def __tk_button_miik3xn9(self, parent):
        btn = Button(
            parent,
            text="E",
            takefocus=False,
        )
        btn.place(relx=0.0000, rely=0.0000, relwidth=0.0667, relheight=1.0345)
        return btn

    def __tk_button_miileno7(self, parent):
        btn = Button(
            parent,
            text="A",
            takefocus=False,
        )
        btn.place(relx=0.0667, rely=0.0000, relwidth=0.0667, relheight=1.0345)
        return btn

    def __tk_button_mipjikfh(self, parent):
        btn = Button(
            parent,
            text="T",
            takefocus=False,
        )
        btn.place(relx=0.1333, rely=0.0000, relwidth=0.0667, relheight=1.0345)
        return btn

    def update_lable_text(self, mtext):
        self.tk_label_miik3tat.config(text=mtext)

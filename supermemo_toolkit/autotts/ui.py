from tkinter import Tk
from tkinter.ttk import Button, Label, Scrollbar


class WinGUI(Tk):
    def __init__(self):
        super().__init__()
        self.__win()
        self.tk_label_miik3tat = self.__tk_label_miik3tat(self)
        self.tk_button_miik3xn9 = self.__tk_button_miik3xn9(self)
        self.tk_button_miileno7 = self.__tk_button_miileno7(self)

    def __win(self):
        self.title("AutoTTS")
        # 设置窗口大小、居中
        width = 100
        height = 95
        # screenwidth = self.winfo_screenwidth()
        screenheight = self.winfo_screenheight()
        geometry = "%dx%d+%d+%d" % (width, height, 0, (screenheight - (height + 100)))

        self.geometry(geometry)

        self.minsize(width=width, height=height)
        self.attributes("-toolwindow", True)
        self.attributes("-topmost", True)
        self.resizable(False, False)

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
            text="标签",
            anchor="center",
        )
        label.place(relx=0.0000, rely=0.0000, relwidth=1.0000, relheight=0.3158)
        return label

    def __tk_button_miik3xn9(self, parent):
        btn = Button(
            parent,
            text="启动/暂停",
            takefocus=False,
        )
        btn.place(relx=0.0000, rely=0.3684, relwidth=1.0000, relheight=0.2632)
        return btn

    def __tk_button_miileno7(self, parent):
        btn = Button(
            parent,
            text="再来一遍",
            takefocus=False,
        )
        btn.place(relx=0.0000, rely=0.6842, relwidth=1.0000, relheight=0.2632)
        return btn


class Win(WinGUI):
    def __init__(self, controller):
        self.ctl = controller
        super().__init__()
        self.__event_bind()
        self.__style_config()
        self.ctl.init(self)

    def __event_bind(self):
        # TODO))
        # self.tk_button_miik3xn9.bind("<Button-1>", self.ctl.onButtonClick)
        pass

    def __style_config(self):
        pass


if __name__ == "__main__":
    win = WinGUI()
    win.mainloop()

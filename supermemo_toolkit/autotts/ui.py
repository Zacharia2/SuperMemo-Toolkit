from tkinter import Tk
from tkinter.ttk import Button, Label, Scrollbar


class WinGUI(Tk):
    def __init__(self):
        super().__init__()
        self.__win()
        self.tk_label_miik3tat = self.__tk_label_miik3tat(self)
        self.tk_button_miik3xn9 = self.__tk_button_miik3xn9(self)
        self.tk_button_miileno7 = self.__tk_button_miileno7(self)
        self.tk_button_mipjikfh = self.__tk_button_mipjikfh(self)
        self.tk_button_mipjkbla = self.__tk_button_mipjkbla(self)

    def __win(self):
        self.title("AutoTTS")
        # 设置窗口大小、居中
        width = 450
        height = 30
        screenwidth = self.winfo_screenwidth()
        # screenheight = self.winfo_screenheight()
        geometry = "%dx%d+%d+%d" % (width, height, (screenwidth - width) / 2, 5)

        self.geometry(geometry)

        self.minsize(width=width, height=height)
        self.overrideredirect(True)
        # self.attributes("-toolwindow", True)
        self.attributes("-topmost", True)
        self.attributes("-alpha", 0.6)
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
            text="状态",
            anchor="center",
        )
        label.place(relx=0.2667, rely=0.0000, relwidth=0.7333, relheight=1.0345)
        return label

    def __tk_button_miik3xn9(self, parent):
        btn = Button(
            parent,
            text="S/E",
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

    def __tk_button_mipjkbla(self, parent):
        btn = Button(
            parent,
            text="X",
            takefocus=False,
        )
        btn.place(relx=0.2000, rely=0.0000, relwidth=0.0667, relheight=1.0345)
        return btn


class Win(WinGUI):
    def __init__(self, controller):
        self.ctl = controller
        super().__init__()
        self.__event_bind()
        self.__style_config()
        self.ctl.init(self)

    def __event_bind(self):
        self.tk_button_miik3xn9.bind("<Button-1>", self.ctl.onSEClick)
        self.tk_button_miileno7.bind("<Button-1>", self.ctl.onAClick)
        self.tk_button_mipjikfh.bind("<Button-1>", self.ctl.onTClick)
        self.tk_button_mipjkbla.bind("<Button-1>", self.ctl.onXClick)
        pass

    def __style_config(self):
        pass


class Controller:
    # 导入UI类后，替换以下的 object 类型，将获得 IDE 属性提示功能
    ui: WinGUI

    def __init__(self):
        pass

    def init(self, ui):
        """
        得到UI实例，对组件进行初始化配置
        """
        self.ui = ui
        # TODO 组件初始化 赋值操作

    def onSEClick(self, evt):
        print("<Button-1>事件未处理:", evt)

    def onAClick(self, evt):
        print("<Button-1>事件未处理:", evt)

    def onTClick(self, evt):
        print("<Button-1>事件未处理:", evt)

    def onXClick(self, evt):
        print("<Button-1>事件未处理:", evt)


if __name__ == "__main__":
    app = Win(Controller())
    app.mainloop()

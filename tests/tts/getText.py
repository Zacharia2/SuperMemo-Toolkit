from pywinauto.application import Application

app = Application(backend="win32").connect(class_name="TElWind")
app.top_window().set_focus()
# 模拟 Ctrl+C 复制内容，内容为Source code。
app.top_window().type_keys("^c")
# 然后监听剪贴板，把需要的内容查找出来，然后读取后，在调用tts就可以阅读了。
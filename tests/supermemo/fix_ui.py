import os
import subprocess
import psutil
from tests.supermemo.dfm_parser import (
    DelphiField,
    getIndentation,
    parseObject,
    LineReader,
)


def kill_process_by_path(process_path):
    """
    根据进程的可执行文件路径终止所有匹配的进程。

    :param process_path: 进程的可执行文件路径（支持绝对路径或相对路径）
    """
    # 将路径转换为小写并标准化，以进行不区分大小写的比较（Windows 适用）
    target_path = os.path.normcase(os.path.abspath(process_path))
    killed = False

    for proc in psutil.process_iter(["pid", "name", "exe"]):
        try:
            # 获取进程的可执行文件路径
            exe_path = proc.info["exe"]
            if exe_path is None:
                continue
            # 标准化并与目标路径比较
            if os.path.normcase(os.path.abspath(exe_path)) == target_path:
                print(
                    f"终止进程 PID: {proc.info['pid']}, 名称: {proc.info['name']}, 路径: {exe_path}"
                )
                proc.terminate()  # 请求终止
                # 可选：等待进程结束
                proc.wait(timeout=3)
                killed = True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess) as e:
            print(f"无法访问进程 {proc.info['pid']}: {e}")
        except Exception as e:
            print(f"处理进程时出错: {e}")

    if not killed:
        print(f"未找到路径为 '{process_path}' 的进程。")


def extract_resources(exe_path, output_dir, rh_path="ResourceHacker.exe"):
    """
    使用 Resource Hacker 解压 EXE 中的所有资源到指定文件夹。

    :param exe_path:     目标 EXE 文件的路径
    :param output_dir:   解压输出文件夹路径（将自动创建）
    :param rh_path:      ResourceHacker.exe 的路径（若已加入 PATH 则只写文件名）
    :return:             成功返回 True，失败返回 False
    """
    # 检查 EXE 是否存在
    if not os.path.isfile(exe_path):
        print(f"错误：EXE 文件不存在 -> {exe_path}")
        return False

    # 创建输出文件夹
    os.makedirs(output_dir, exist_ok=True)

    # 构建命令
    # 注意：-action extract 不加 -mask 表示提取所有资源
    # ResourceHacker.exe -open sm20.exe -save 'extracted' -action extract
    cmd = [rh_path, "-open", exe_path, "-save", output_dir, "-action", "extract"]

    print(f"正在解压资源：{exe_path} -> {output_dir}")
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=False)
        if result.returncode != 0:
            print(f"解压失败，返回码：{result.returncode}")
            print("错误输出：", result.stderr)
            return False
        not_dfm_files = [
            f
            for f in os.listdir(output_dir)
            if not f.lower().endswith(".dfm")
            and os.path.isfile(os.path.join(output_dir, f))
        ]
        [os.remove(os.path.join(output_dir, x)) for x in not_dfm_files]
        print("解压成功")
        return True
    except FileNotFoundError:
        print(f"错误：找不到 ResourceHacker.exe，请检查路径 -> {rh_path}")
        return False
    except Exception as e:
        print(f"发生异常：{e}")
        return False


def replace_dfm(resources_dir):
    # 1. 替换AboutBox.VirtualImageList64为32。
    # 2. 字体替换
    #     宋体（SimSun）-> 'Times New Roman'
    #     Microsoft YaHei -> ['Tahoma', 'Arial', 'Segoe UI', 'Rubik', 'MS Sans Serif', 'System', 'Arial Narrow']
    # 3. Font.Charset = ANSI_CHARSET替换为Font.Charset = DEFAULT_CHARSET
    dfm_files = [
        f
        for f in os.listdir(resources_dir)
        if f.lower().endswith(".dfm") and os.path.isfile(os.path.join(resources_dir, f))
    ]
    for filename in dfm_files:
        file_path = os.path.join(resources_dir, filename)
        with open(file_path, "r", encoding="utf-8") as f:
            raw = f.read()
        # raw = raw.replace("AboutBox.VirtualImageList64", "AboutBox.VirtualImageList32")
        raw = raw.replace("Times New Roman", "SimSun")
        raw = raw.replace(
            "Font.Charset = ANSI_CHARSET", "Font.Charset = DEFAULT_CHARSET"
        )
        for x in [
            "Tahoma",
            "Arial",
            "Segoe UI",
            "Rubik",
            "MS Sans Serif",
            "System",
            "Arial Narrow",
        ]:
            raw = raw.replace(f"Font.Name = '{x}'", "Font.Name = 'Microsoft YaHei'")

        with open(file_path, "w", encoding="utf-8") as f:
            f.write(raw)


def gen_script(
    original_exe,
    output_exe,
    resources_dir,
    script_path,
    resource_type="RCData",
    lang_id=1033,
):
    # 检查输入
    if not os.path.isfile(original_exe):
        print(f"错误：原始 EXE 不存在 -> {original_exe}")
        return None
    if not os.path.isdir(resources_dir):
        print(f"错误：资源文件夹不存在 -> {resources_dir}")
        return None
    if original_exe == output_exe:
        print("错误：输出 EXE 不能与原始 EXE 相同")
        return None

    # 收集所有 .dfm 文件
    dfm_files = [
        f
        for f in os.listdir(resources_dir)
        if f.lower().endswith(".dfm") and os.path.isfile(os.path.join(resources_dir, f))
    ]
    if not dfm_files:
        print(f"警告：资源文件夹中没有 .dfm 文件 -> {resources_dir}")
        return None

    # 生成脚本内容
    lines = []
    lines.append("[FILENAMES]")
    lines.append(f"Open={original_exe}")
    lines.append(f"Save={output_exe}")
    lines.append("Log=CONSOLE")  # 留空表示不生成日志文件
    lines.append("")
    lines.append("[COMMANDS]")

    for filename in dfm_files:
        file_path = os.path.join(resources_dir, filename)
        resource_name = os.path.splitext(filename)[0]  # 不含 .dfm
        # ResourceHacker 的掩码格式：资源类型, 资源名称, 语言ID
        mask = f"{resource_type}, T{resource_name}, "
        # 注意：路径中如果有空格，用双引号包裹
        lines.append(f'-addoverwrite "{file_path}", {mask}')

    # 写入脚本文件
    try:
        with open(script_path, "w", encoding="utf-8") as f:
            f.write("\n".join(lines))
        print(f"脚本已生成：{script_path}")
    except Exception as e:
        print(f"写入脚本失败：{e}")


def run_script(rhexe_path, script_path):
    cmd = [rhexe_path, "-script", script_path]
    try:
        result = subprocess.run(cmd, capture_output=True, text=True, check=False)
        if result.returncode != 0:
            print("错误输出：", result.stdout if len(result.stdout) == 0 else "无")
            return
        print("脚本执行成功")
    except Exception as e:
        print(f"发生异常：{e}")


# 丢弃修改
# 6. 元素菜单和组件菜单，右单击的字体也太大
#             ParentFont 一般是false 、AutoSize是true、WordWrap是true、Scaled没有、TextHeight有、PixelsPerInch 有、Font.Size没有、Font.Height有。TextHeight有。
#             TPopupMenu 和 TMenuItem
#             即使把TextHeight 、Font.Height全部改为一致，也没有用。

"""
4. 微调高度：按钮栏高度太高：队列的、contents的、注册表的；Learn Add new的按钮太大了
"""


def fix_ui(directory):
    filenames = [
        os.path.join(directory, aFile)
        for aFile in [
            "ANALYSISDLG.dfm",  # AboutBox.VirtualImageList32改成16
            "BRIMP.dfm",
            # BrImp: TBrImp>>ToolBar: TToolBar>>ButtonHeight=45，Images = AboutBox.VirtualImageList32
            # BrImp: TBrImp>>ToolBar: TToolBar>>SourcesPanel: TPanel>>增加DoubleBuffered = True
            # BrImp: TBrImp>>HeaderPanel: TPanel>>TitleEdit: TEdit>>Width = 1900
            # BrImp: TBrImp>>PopUpMenu: TPopupMenu>>Images=16
            "BROWSER.dfm",
            # Browser: TBrowser>>Speedbar: TToolBar>>ButtonHeight = 45,Images = AboutBox.VirtualImageList32
            # Browser: TBrowser>>PopupMenu1: TPopupMenu>>Images = AboutBox.VirtualImageList16
            "CONTENTS.dfm",
            # Contents: TContents>>BottomBar: TToolBar>>AlignWithMargins = True 改为 AllowTextButtons = True, Images = AboutBox.VirtualImageList16
            # Contents: TContents>>ToolBar: TToolBar>>ButtonHeight = 32,Images = AboutBox.VirtualImageList16
            # Contents: TContents>>PopupMenu1: TPopupMenu>>Images = AboutBox.VirtualImageList16
            # Contents: TContents>>ProcessMenu: TPopupMen>>Images = AboutBox.VirtualImageList16
            "ELWIND.dfm",
            # ElWind: TElWind>>LearnPanel: TPanel>>LearnBar: TToolBar>>ButtonHeight = 38
            # ElWind: TElWind>>Learn: TBitBtn>>Width = 320
            # ElWind: TElWind>>AddNew: TBitBtn>>Width = 222
            # ElWind: TElWind>>CancelShowAnswer: TBitBtn>>Width = 164
            # ElWind: TElWind>>NavPanel: TPanel>>ConceptEdit: TEdit>>增加Font.Height = -14
            # ElWind: TElWind>>NavPanel: TPanel>>NavBar: TToolBar>>Images = AboutBox.VirtualImageList32
            # ElWind: TElWind>>ElementMenu: TPopupMenu>>Images = AboutBox.VirtualImageList16
            # ElWind: TElWind>>ComponentMenu: TPopupMenu>>Images = AboutBox.VirtualImageList16
            "INPUTDLG.dfm",
            # AboutBox.VirtualImageList64改成32
            "PLANDLG.dfm",
            # PlanDlg: TPlanDlg>>ToolBar1: TToolBar>>Images = AboutBox.VirtualImageList32
            # PlanDlg: TPlanDlg>>PopupMenu1: TPopupMenu>>Images = AboutBox.VirtualImageList16
            "REGISTRYFORM.dfm",
            # RegistryForm: TRegistryForm>>ToolBar: TToolBar>>BorderWidth = 0, ButtonHeight = 38,Images = AboutBox.VirtualImageList32
            "SMMAIN.dfm",
            # SMMain: TSMMain>>TheMainMenu: TMainMenu>>Images = AboutBox.VirtualImageList16
            "TASKMANAGER.dfm",
            # AboutBox.VirtualImageList64改成32
            # "MSGDIALOG.dfm",不需要修改保持图标不变
        ]
    ]

    # ---------- 辅助函数：在对象树中查找符合条件的对象 ----------
    def find_object(root, name, obj_type=None):
        """在 root 及其子孙中查找名称匹配（且类型可选匹配）的第一个对象"""
        if root.name == name and (obj_type is None or root.objectType == obj_type):
            return root
        for child in root.children:
            found = find_object(child, name, obj_type)
            if found:
                return found
        return None

    def find_all_objects(root, name=None, obj_type=None):
        """返回所有符合条件的对象列表"""
        result = []
        if (name is None or root.name == name) and (
            obj_type is None or root.objectType == obj_type
        ):
            result.append(root)
        for child in root.children:
            result.extend(find_all_objects(child, name, obj_type))
        return result

    def set_field(obj, field_name, new_value, field_type=""):
        """设置对象的字段值，如果字段不存在则创建"""
        for field in obj.fields:
            if field.name == field_name:
                field.value = new_value
                field.fieldType = field_type
                return
        # 字段不存在，新增
        new_field = DelphiField(field_name)
        new_field.value = new_value
        new_field.fieldType = field_type
        obj.fields.append(new_field)

    def get_field(obj, field_name):
        """获取对象的字段值，不存在返回 None"""
        for field in obj.fields:
            if field.name == field_name:
                return field.value
        return None

    # ---------- 针对每个文件的修改逻辑 ----------
    def modify_analysisdlg(obj_tree):
        for obj in find_all_objects(obj_tree):
            for field in obj.fields:
                if field.name == "Images" and isinstance(field.value, str):
                    if "VirtualImageList32" in field.value:
                        field.value = field.value.replace(
                            "VirtualImageList32", "VirtualImageList16"
                        )

    def modify_brimp(obj_tree):
        toolbar = find_object(obj_tree, "ToolBar", "TToolBar")
        if toolbar:
            set_field(toolbar, "ButtonHeight", "45")
            set_field(toolbar, "Images", "AboutBox.VirtualImageList32")
            sources_panel = find_object(toolbar, "SourcesPanel", "TPanel")
            if sources_panel:
                set_field(sources_panel, "DoubleBuffered", "True")
        header_panel = find_object(obj_tree, "HeaderPanel", "TPanel")
        if header_panel:
            title_edit = find_object(header_panel, "TitleEdit", "TEdit")
            if title_edit:
                set_field(title_edit, "Width", "1900")
        popup_menu = find_object(obj_tree, "PopUpMenu", "TPopupMenu")
        if popup_menu:
            set_field(popup_menu, "Images", "AboutBox.VirtualImageList16")

    def modify_browser(obj_tree):
        speedbar = find_object(obj_tree, "Speedbar", "TToolBar")
        if speedbar:
            set_field(speedbar, "ButtonHeight", "45")
            set_field(speedbar, "Images", "AboutBox.VirtualImageList32")
        popup_menu = find_object(obj_tree, "PopupMenu1", "TPopupMenu")
        if popup_menu:
            set_field(popup_menu, "Images", "AboutBox.VirtualImageList16")

    def modify_contents(obj_tree):
        bottom_bar = find_object(obj_tree, "BottomBar", "TToolBar")
        if bottom_bar:
            bottom_bar.fields = [
                f for f in bottom_bar.fields if f.name != "AlignWithMargins"
            ]
            set_field(bottom_bar, "AllowTextButtons", "True")
            set_field(bottom_bar, "Images", "AboutBox.VirtualImageList16")
        tool_bar = find_object(obj_tree, "ToolBar", "TToolBar")
        if tool_bar:
            set_field(tool_bar, "ButtonHeight", "32")
            set_field(tool_bar, "Images", "AboutBox.VirtualImageList16")
        for menu_name in ["PopupMenu1", "ProcessMenu"]:
            menu = find_object(obj_tree, menu_name, "TPopupMenu")
            if menu:
                set_field(menu, "Images", "AboutBox.VirtualImageList16")

    def modify_elwind(obj_tree):
        learn_panel = find_object(obj_tree, "LearnPanel", "TPanel")
        if learn_panel:
            learn_bar = find_object(learn_panel, "LearnBar", "TToolBar")
            if learn_bar:
                set_field(learn_bar, "ButtonHeight", "38")
        for btn_name, width in [
            ("Learn", "320"),
            ("AddNew", "222"),
            ("CancelShowAnswer", "164"),
        ]:
            btn = find_object(obj_tree, btn_name, "TBitBtn")
            if btn:
                set_field(btn, "Width", width)
        nav_panel = find_object(obj_tree, "NavPanel", "TPanel")
        if nav_panel:
            concept_edit = find_object(nav_panel, "ConceptEdit", "TEdit")
            if concept_edit:
                set_field(concept_edit, "Font.Height", "-14")
            nav_bar = find_object(nav_panel, "NavBar", "TToolBar")
            if nav_bar:
                set_field(nav_bar, "Images", "AboutBox.VirtualImageList32")  # 保持32
        for menu_name in ["ElementMenu", "ComponentMenu"]:
            menu = find_object(obj_tree, menu_name, "TPopupMenu")
            if menu:
                set_field(menu, "Images", "AboutBox.VirtualImageList16")

    def modify_inputdlg(obj_tree):
        for obj in find_all_objects(obj_tree):
            for field in obj.fields:
                if field.name == "Images" and isinstance(field.value, str):
                    if "VirtualImageList64" in field.value:
                        field.value = field.value.replace(
                            "VirtualImageList64", "VirtualImageList32"
                        )

    def modify_plandlg(obj_tree):
        toolbar = find_object(obj_tree, "ToolBar1", "TToolBar")
        if toolbar:
            set_field(toolbar, "Images", "AboutBox.VirtualImageList32")  # 保持
        popup = find_object(obj_tree, "PopupMenu1", "TPopupMenu")
        if popup:
            set_field(popup, "Images", "AboutBox.VirtualImageList16")

    def modify_registryform(obj_tree):
        toolbar = find_object(obj_tree, "ToolBar", "TToolBar")
        if toolbar:
            set_field(toolbar, "BorderWidth", "0")
            set_field(toolbar, "ButtonHeight", "38")
            set_field(toolbar, "Images", "AboutBox.VirtualImageList32")

    def modify_smmain(obj_tree):
        main_menu = find_object(obj_tree, "TheMainMenu", "TMainMenu")
        if main_menu:
            set_field(main_menu, "Images", "AboutBox.VirtualImageList16")

    def modify_taskmanager(obj_tree):
        for obj in find_all_objects(obj_tree):
            for field in obj.fields:
                if field.name == "Images" and isinstance(field.value, str):
                    if "VirtualImageList64" in field.value:
                        field.value = field.value.replace(
                            "VirtualImageList64", "VirtualImageList32"
                        )

    # ---------- 主处理循环 ----------
    for aFilename in filenames:
        print(f"Processing: {aFilename}")
        with open(aFilename, "r", encoding="utf-8") as inputFile:
            input_str = inputFile.read()
        lines = input_str.splitlines(True)
        reader = LineReader(lines)
        objects = []

        def add_children_to_list(obj):
            for child in obj.children:
                objects.append(child)
                add_children_to_list(child)

        while True:
            line = reader.readline()
            if not line:
                break
            tokens = line.lstrip().split()
            indentationLevel = getIndentation(line)
            if tokens and (tokens[0] == "object" or tokens[0] == "inherited"):
                aObject = parseObject(reader, line, indentationLevel)
                objects.append(aObject)
                add_children_to_list(aObject)

        if not objects:
            continue

        # 获取顶层对象（通常只有一个）
        root_obj = objects[0]

        # 根据文件名调用对应的修改函数
        base_name = os.path.basename(aFilename).upper()
        if base_name == "ANALYSISDLG.DFM":
            modify_analysisdlg(root_obj)
        elif base_name == "BRIMP.DFM":
            modify_brimp(root_obj)
        elif base_name == "BROWSER.DFM":
            modify_browser(root_obj)
        elif base_name == "CONTENTS.DFM":
            modify_contents(root_obj)
        elif base_name == "ELWIND.DFM":
            modify_elwind(root_obj)
        elif base_name == "INPUTDLG.DFM":
            modify_inputdlg(root_obj)
        elif base_name == "PLANDLG.DFM":
            modify_plandlg(root_obj)
        elif base_name == "REGISTRYFORM.DFM":
            modify_registryform(root_obj)
        elif base_name == "SMMAIN.DFM":
            modify_smmain(root_obj)
        elif base_name == "TASKMANAGER.DFM":
            modify_taskmanager(root_obj)

        # 写回文件
        with open(aFilename, "w", encoding="utf-8") as outputFile:
            outputFile.write(root_obj.toString())


# ----------------- 使用示例 -----------------
if __name__ == "__main__":
    root = r"D:\Dropbox\10-TODO\Develop\repo\SuperMemo-Toolkit"
    rhexe_path = rf"{root}\tests\supermemo\ResourceHacker\ResourceHacker.exe"

    ori_exe = r"C:\Users\Snowy\Downloads\SuperMemo\sm20.exe"
    mod_exe = r"C:\Users\Snowy\Downloads\SuperMemo\sm20p_mod.exe"

    extract_folder = rf"{root}\tests\supermemo\extracted"
    script_path = rf"{root}\tests\supermemo\ResourceHacker\update_resources.rh"
    #  & C:\Users\Snowy\Desktop\ResourceHacker5.2.8.448V5\ResourceHacker.exe -script D:\Dropbox\10-TODO\Develop\repo\SuperMemo-Toolkit\update_resources.rh

    extract_resources(ori_exe, extract_folder, rhexe_path)
    replace_dfm(extract_folder)
    fix_ui(extract_folder)
    # gen_script(ori_exe, mod_exe, extract_folder, script_path)
    # kill_process_by_path(mod_exe)
    # run_script(rhexe_path, script_path)
    # subprocess.run([mod_exe])

import os
import subprocess


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
        raw = raw.replace("AboutBox.VirtualImageList64", "AboutBox.VirtualImageList32")
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
            print("错误输出：", result.stderr)
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

# ----------------- 使用示例 -----------------
if __name__ == "__main__":
    root = r"D:\Dropbox\10-TODO\Develop\repo\SuperMemo-Toolkit"
    rhexe_path = rf"{root}\tests\supermemo\ResourceHacker\ResourceHacker.exe"

    ori_exe = r"C:\Users\Snowy\Downloads\SuperMemo\sm20.exe"
    mod_exe = r"C:\Users\Snowy\Downloads\SuperMemo\sm20_mod.exe"

    extract_folder = rf"{root}\tests\supermemo\extracted"
    script_path = rf"{root}\tests\supermemo\ResourceHacker\update_resources.rh"
    #  & C:\Users\Snowy\Desktop\ResourceHacker5.2.8.448V5\ResourceHacker.exe -script D:\Dropbox\10-TODO\Develop\repo\SuperMemo-Toolkit\update_resources.rh

    # extract_resources(ori_exe, extract_folder, rhexe_path)
    # gen_script(rhexe_path, ori_exe, mod_exe, extract_folder, script_path)
    run_script(rhexe_path, script_path)
    # replace_dfm(extract_folder)

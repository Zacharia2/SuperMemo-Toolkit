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


def repack_resources(
    original_exe,
    output_exe,
    resources_dir,
    resource_type="RCData",
    lang_id=1033,
    rh_path="ResourceHacker.exe",
):
    """
    将 resources_dir 目录下的所有文件，以文件名作为资源名称，覆写回 EXE。

    :param original_exe:  原始 EXE 文件路径（源文件）
    :param output_exe:    输出 EXE 文件路径（新文件，不应与原始文件相同）
    :param resources_dir: 包含修改后资源的文件夹
    :param resource_type: 资源类型（如 RCData、BITMAP 等），默认为 RCData
    :param lang_id:       语言 ID，通常英语为 1033
    :param rh_path:       ResourceHacker.exe 的路径
    :return:              成功返回 True，失败返回 False
    """
    # 检查输入文件及文件夹
    if not os.path.isfile(original_exe):
        print(f"错误：原始 EXE 不存在 -> {original_exe}")
        return False
    if not os.path.isdir(resources_dir):
        print(f"错误：资源文件夹不存在 -> {resources_dir}")
        return False
    if original_exe == output_exe:
        print("错误：输出 EXE 不能与原始 EXE 相同，请指定不同的输出路径")
        return False

    # 获取资源文件夹中的所有文件（不递归子目录）
    files = [
        f
        for f in os.listdir(resources_dir)
        if os.path.isfile(os.path.join(resources_dir, f))
    ]
    if not files:
        print(f"警告：资源文件夹中没有文件 -> {resources_dir}")
        return False

    # 当前工作 EXE 从原始文件开始，依次覆写
    current_exe = original_exe
    for filename in files:
        file_path = os.path.join(resources_dir, filename)
        resource_name, resource_ext = os.path.splitext(filename)
        if resource_ext != ".dfm":
            continue

        # -res "修改好的.dfm" -mask RCData, <资源名称 在程序里的确切名称（例如 TMainForm）>, <语言ID 英语通常是 1033>
        # 构建 addoverwrite 命令
        cmd = [
            rh_path,
            "-open",
            current_exe,
            "-save",
            output_exe,
            "-action",
            "addoverwrite",
            "-res",
            file_path,
            "-mask",
            f"{resource_type}, T{resource_name}, {lang_id}",
        ]

        print(f"正在覆写资源：{resource_name} <- {filename}")
        print(f"命令：{' '.join(cmd)}")
        try:
            result = subprocess.run(cmd, capture_output=True, text=True, check=False)
            if result.returncode != 0:
                print(f"覆写失败，资源：{resource_name}，返回码：{result.returncode}")
                print("错误输出：", result.stderr)
                return False
        except FileNotFoundError:
            print(f"错误：找不到 ResourceHacker.exe -> {rh_path}")
            return False
        except Exception as e:
            print(f"发生异常：{e}")
            return False

    print(f"所有资源覆写完成，最终 EXE：{output_exe}")
    return True


import os


def generate_rh_script(
    original_exe,
    output_exe,
    resources_dir,
    script_path="update_resources.rh",
    resource_type="RCData",
    lang_id=1033,
):
    """
    生成 ResourceHacker 脚本文件，用于批量覆写 EXE 中的 DFM 资源。

    :param original_exe:  原始 EXE 文件路径
    :param output_exe:    输出 EXE 文件路径
    :param resources_dir: 包含 .dfm 文件的文件夹
    :param script_path:   生成的脚本文件路径（建议 .rh 或 .txt）
    :param resource_type: 资源类型，默认为 RCData
    :param lang_id:       语言 ID，英语通常为 1033
    :return:              成功返回脚本文件路径，失败返回 None
    """
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
    lines.append("Log=")  # 留空表示不生成日志文件
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
        return script_path
    except Exception as e:
        print(f"写入脚本失败：{e}")
        return None


# 为dfm存历史记录。
"""
字符串替换类
    1. 直接用EmEditor查找替换AboutBox.VirtualImageList64为32即可。
    3. 字体太大了
        7. 特殊字体替换为普通字体、Tahoma、Times New Roman、MS Sans Serif、Arial、System、Rubik、Arial Narrow、Segoe UI
            1. 宋体（SimSun）-> 'Times New Roman'
            2. Microsoft YaHei -> ['Tahoma', 'Arial', 'Segoe UI', 'Rubik', 'MS Sans Serif', 'System', 'Arial Narrow']
        6. 元素菜单和组件菜单，右单击的字体也太大
            ParentFont 一般是false 、AutoSize是true、WordWrap是true、Scaled没有、TextHeight有、PixelsPerInch 有、Font.Size没有、Font.Height有。TextHeight有。
            TPopupMenu 和 TMenuItem
            即使把TextHeight 、Font.Height全部改为一致，也没有用。
分析类
    2. contents的图标栏太高了
    4. Learn Add new的按钮太大了，Lean的图标太大
    5. 队列的按钮栏高度太高
"""
# BRIMP.dfm
# BROWSER.dfm
# CONTENTS.dfm
# ELWIND.dfm
# INPUTDLG.dfm
# MSGDIALOG.dfm
# PLANDLG.dfm
# REGISTRYFORM.dfm
# TASKMANAGER.dfm

# ----------------- 使用示例 -----------------
if __name__ == "__main__":
    # 示例参数
    exe_file = r"C:\Users\Snowy\Downloads\SuperMemo\sm20.exe"
    extract_folder = (
        r"D:\Dropbox\10-TODO\Develop\repo\SuperMemo-Toolkit\tests\supermemo\extracted"
    )
    modified_folder = r"D:\Dropbox\10-TODO\Develop\repo\SuperMemo-Toolkit\tests\supermemo\extracted"  # 假设修改后的资源仍在同一文件夹
    output_exe_file = r"C:\Users\Snowy\Downloads\SuperMemo\sm20_modified.exe"

    # extract_resources(
    #     exe_file,
    #     extract_folder,
    #     rh_path=r"C:\Users\Snowy\Desktop\ResourceHacker5.2.8.448V5\ResourceHacker.exe",
    # )
    # repack_resources(
    #     exe_file,
    #     output_exe_file,
    #     modified_folder,
    #     resource_type="RCData",
    #     lang_id=1033,
    #     rh_path=r"C:\Users\Snowy\Desktop\ResourceHacker5.2.8.448V5\ResourceHacker.exe",
    # )
    #  & C:\Users\Snowy\Desktop\ResourceHacker5.2.8.448V5\ResourceHacker.exe -script D:\Dropbox\10-TODO\Develop\repo\SuperMemo-Toolkit\update_resources.rh
    generate_rh_script(exe_file, output_exe_file, modified_folder)

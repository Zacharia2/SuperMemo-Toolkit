import os
import subprocess
import sys


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
    temp_exe = None

    for idx, filename in enumerate(files):
        file_path = os.path.join(resources_dir, filename)
        # 资源名称 = 文件名不含扩展名
        resource_name, resource_ext = os.path.splitext(filename)
        if resource_ext != "dfm":
            continue

        # 如果不是最后一个文件，使用临时文件作为中间输出，避免反复读取原文件
        if idx == len(files) - 1:
            # 最后一次覆写，直接输出到最终 output_exe
            out_exe = output_exe
        else:
            # 生成临时文件
            temp_exe = os.path.join(
                os.path.dirname(output_exe),
                f"_temp_{idx}_{os.path.basename(original_exe)}",
            )
            out_exe = temp_exe
        # -res "修改好的.dfm" -mask RCData, <资源名称 在程序里的确切名称（例如 TMainForm）>, <语言ID 英语通常是 1033>
        # 构建 addoverwrite 命令
        cmd = [
            rh_path,
            "-open",
            current_exe,
            "-save",
            out_exe,
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

        # 准备下一次循环：将当前输出作为下一次的输入
        if idx != len(files) - 1:
            # 删除上一次的临时文件（如果存在且不是当前输入）
            if current_exe != original_exe and os.path.exists(current_exe):
                os.remove(current_exe)
            current_exe = out_exe

    # 清理残留的临时文件
    if temp_exe and os.path.exists(temp_exe) and temp_exe != output_exe:
        os.remove(temp_exe)

    print(f"所有资源覆写完成，最终 EXE：{output_exe}")
    return True


# 为dfm存历史记录。
"""
字符串替换类
    1. 直接用EmEditor查找替换AboutBox.VirtualImageList64为32即可。
    3. 字体太大了
        7. 特殊字体替换为普通字体、Tahoma、Times New Roman、MS Sans Serif、Arial、System、Rubik、Arial Narrow、Segoe UI
            1. 宋体（SimSun）-> 'Times New Roman'
            2. Microsoft YaHei -> ['Tahoma', 'Arial', 'Segoe UI', 'Rubik', 'MS Sans Serif', 'System', 'Arial Narrow']
        6. 元素菜单和组件菜单，右单击的字体也太大
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
    extract_folder = "tests\supermemo\extracted"
    modified_folder = "tests\supermemo\extracted"  # 假设修改后的资源仍在同一文件夹
    output_exe_file = r"C:\Users\Snowy\Downloads\SuperMemo\sm20_modified.exe"

    extract_resources(
        exe_file,
        extract_folder,
        rh_path=r"C:\Users\Snowy\Desktop\ResourceHacker5.2.8.448V5\ResourceHacker.exe",
    )
    # repack_resources(
    #     exe_file,
    #     output_exe_file,
    #     modified_folder,
    #     resource_type="RCData",
    #     lang_id=1033,
    #     rh_path=r"C:\Users\Snowy\Desktop\ResourceHacker5.2.8.448V5\ResourceHacker.exe",
    # )

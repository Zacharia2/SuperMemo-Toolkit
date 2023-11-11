import codecs
import os
import shutil


def secure_file_write(target_file, temp_dir):
    """写入文件的安全机制——文件备份和临时文件

    文件备份和临时文件将在函数完成后删除。

    Args:
        target_file (_type_): 目标文件
        temp_dir (_type_): 临时文件夹, 存储文件备份和临时文件
    """
    original_name = os.path.basename(target_file)
    backup_file = os.path.join(temp_dir, original_name + ".bak")
    temp_file = os.path.join(temp_dir, original_name + ".tmp")
    try:
        # 创建并写入临时文件
        with codecs.open(temp_file, "w") as f:
            print("正在处理：", original_name)
            f.seek(0)
            f.write("Hello, world!")
            f.truncate()
            # 在此处进行其他文件操作

        # 备份原始文件
        shutil.copyfile(target_file, backup_file)

        # 重命名临时文件为目标文件
        shutil.move(temp_file, target_file)
    except Exception as e:
        # 发生异常时回滚备份文件
        shutil.move(backup_file, target_file)
        print(f"写入文件时发生错误：{str(e)}")
    finally:
        # 删除临时文件和备份文件
        if os.path.exists(temp_file):
            os.remove(temp_file)
        if os.path.exists(backup_file):
            os.remove(backup_file)


mtxt = "这是一个火狐狸。\n这是一个火狐狸。\n这是一个火狐狸。\n这是一个火狐狸。\n这是一个火狐狸。\n这是一个火狐狸。\n"

with open("pathpix/test/file.txt", "w", encoding="utf-8") as file:
    file.write(mtxt)

secure_file_write("pathpix/test/file.txt", "pathpix/test")

    # def find_htm_files_in_directory(directory):
    #     nonlocal waiting_process_htm_files
    #     nonlocal processed_count
    #     with os.scandir(directory) as entries:
    #         for entry in entries:
    #             if entry.is_file() and is_html_file(entry.path):
    #                 waiting_process_htm_files.append(entry.path)
    #                 processed_count += 1
    #                 print(
    #                     "PathPix:: 正在收集HTM文件, 请稍后.",
    #                     f"[{processed_count}]\r",
    #                     end="",
    #                 )
    #             if entry.is_dir():
    #                 find_htm_files_in_directory(entry.path)

    # find_htm_files_in_directory(elements_path)
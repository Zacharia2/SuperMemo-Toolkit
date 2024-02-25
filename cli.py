# encoding:utf-8
#!/usr/bin/env python
"""SMTK CLI Tool
Usage:
    smtk config (set <key> <value> | list)
    smtk clist
    smtk e2sm (-t | -l) <epub-path> <targetfolder>
    smtk pathpix (<col_name> [--clean] | --fullpath=<htmlpath> | --gui | --least-col)
    smtk imtex <formula_text> <outpath>
    smtk placeholders
Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""
# import shutil

import psutil
from smtk.utilscripts import config
from docopt import docopt
from smtk.epub2sm import epub2sm
from smtk.pathpix import index as pathpix 
from smtk.pathpix import gui
import os
from smtk.latex2img import index as latex2img

# def move_to_primaryStorage(source_folder_name, target_folder):
#     shutil.move(source_folder_name, target_folder)

# pyinstaller --add-data "conf.json;." smtk.py
# pyinstaller smtk.spec


def cmd():
    args = docopt(__doc__)

    config_dir = config.get_config_dir()
    conf_path = os.path.join(config_dir, "conf.json")
    init_conf_json = {"program": "D:\\SuperMemo"}

    if not os.path.exists(config_dir):
        os.makedirs(config_dir)
        config.update_config(conf_path, init_conf_json)
    elif os.path.exists(config_dir) and not os.path.exists(conf_path):
        config.update_config(conf_path, init_conf_json)
    elif os.path.exists(conf_path):
        m_conf = config.read_config(conf_path)
    sm_location = m_conf["program"]

    if args.get("config") and args.get("set"):
        if args["<key>"] == "program":
            m_conf[args["<key>"]] = args["<value>"]
            config.update_config(conf_path, m_conf)
            m_conf = config.read_config(conf_path)
            print(m_conf)
        elif args["<key>"] == "systems" and args.get("set"):
            m_conf[args["<key>"]] = args["<value>"]
            config.update_config(conf_path, m_conf)
            m_conf = config.read_config(conf_path)
            print(m_conf)
    elif args.get("config") and args.get("list"):
        print(config.read_config(conf_path))

    elif args.get("clist"):
        col_list = config.get_collections_primaryStorage(sm_location)
        for col_name in col_list:
            print("集合名称：", col_name)

    elif args.get("e2sm"):
        # python index.py e2s a b
        if args.get("-t"):
            epub2sm.start_with_toc(args["<epub-path>"], args["<targetfolder>"])
        if args.get("-l"):
            epub2sm.start_with_linear(args["<epub-path>"], args["<targetfolder>"])

    elif args.get("imtex"):
        latex2img.latex2img(
            text=args["<formula_text>"],
            size=48,
            color=(0.1, 0.8, 0.8),
            out=args["<outpath>"],
        )

    elif args.get("pathpix"):
        # smkit pathpix --least-col
        if args.get("--least-col"):
            sm_system1 = config.read_sm_system1(sm_location)
            least_used_col = config.get_collection_primaryStorage(
                sm_location, sm_system1
            )
            pathpix.start(least_used_col)
        elif args.get("<col_name>"):
            elements_path = config.get_collection_primaryStorage(
                sm_location, args["<col_name>"]
            )
            if args.get("--clean"):
                pathpix.organize_unused_im(elements_path)
            else:
                pathpix.start(elements_path)
        elif args.get("--fullpath"):
            pathpix.single(args["--fullpath"])
        elif args.get("--gui"):
            gui.run()


def check_console():
    image_name = "explorer.exe"
    s = psutil.Process().parent()
    if s.name() == image_name or s.parent().name() == image_name:
        return True
    return False


# 使用kernel32.GetConsoleWindow()获取命令行窗口的句柄，
# 然后使用user32.ShowWindow()将其隐藏起来
# def hide_console():
#     kernel32 = ctypes.WinDLL("kernel32")
#     user32 = ctypes.WinDLL("user32")
#     SW_HIDE = 0
#     hWnd = kernel32.GetConsoleWindow()
#     user32.ShowWindow(hWnd, SW_HIDE)


if __name__ == "__main__":
    cmd()

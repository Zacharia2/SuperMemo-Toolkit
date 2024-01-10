# encoding:utf-8
#!/usr/bin/env python
"""SMKit CLI Tool
Usage:
    smkit config set <key> <value>
    smkit config list
    smkit e2sm ( [-t] | [-l] ) <epub-path> <targetfolder>
    smkit pathpix ( <collection> | [--clean=<collection>] | [--least-col] | [--fullpath=<htmlfullpath>] )
    smkit clist
    smkit indexer <epub> <output>

Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""
# import shutil
import psutil
from scripts import config
from docopt import docopt
from epub2sm import epub2sm
from pathpix import index as pathpix
from pathpix import ui
import os


# def move_to_primaryStorage(source_folder_name, target_folder):
#     shutil.move(source_folder_name, target_folder)

# Main
# 需要填写sm的位置
# sm_location = "C:/Users/Snowy/Desktop/sm18"

# def set_sm_location(sm_path):
#     global sm_location
#     sm_location = sm_path


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

    elif args.get("e2sm"):
        # python index.py e2s a b
        if args.get("-t"):
            epub2sm.start_with_toc(args["<epub-path>"], args["<targetfolder>"])
        if args.get("-l"):
            epub2sm.start_with_linear(args["<epub-path>"], args["<targetfolder>"])

    elif args.get("pathpix"):
        # smkit pathpix --least-col
        if args.get("--least-col"):
            sm_system1 = config.read_sm_system1(sm_location)
            least_used_col = config.get_collection_primaryStorage(
                sm_location, sm_system1
            )
            pathpix.start(least_used_col)
        elif args.get("<collection>"):
            elements_path = config.get_collection_primaryStorage(
                sm_location, args["<collection>"]
            )
            pathpix.start(elements_path)
        elif args.get("--clean"):
            elements_path = config.get_collection_primaryStorage(
                sm_location, args["--clean"]
            )
            pathpix.organize_unused_im(elements_path)
        elif args.get("--fullpath"):
            pathpix.single(args["--fullpath"])
    elif args.get("clist"):
        col_list = config.get_collections_primaryStorage(sm_location)
        for col_name in col_list:
            print("集合名称：", col_name)


def check_console():
    image_name = "explorer.exe"
    s = psutil.Process().parent()
    if s.name() == image_name or s.parent().name() == image_name:
        return True
    return False


if __name__ == "__main__":
    if check_console():
        # 双击执行是进入扩展UI
        ui.run_ui()
    else:
        cmd()

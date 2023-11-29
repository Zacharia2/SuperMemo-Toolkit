# encoding:utf-8
#!/usr/bin/env python
"""SMKit CLI Tool
Usage:
    smkit config set <key> <value>
    smkit config list
    smkit e2sm <epub-path> <targetfolder>
    smkit pathpix ( <collection> | [--clean=<collection>] | [--least-col] )
    smkit clist
    smkit indexer <epub> <output>

Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""
# import shutil
from scripts import config
from docopt import docopt
from epub2sm import epub2sm
from pathpix import index as pathpix
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
    this_folder = os.path.dirname(os.path.abspath(__file__))
    conf_path = os.path.join(this_folder, "conf.json")
    m_conf = config.read_config(conf_path)
    sm_location = m_conf["program"]

    if args.get("config") and args.get("set"):
        if args["<key>"] == "program":
            m_conf["program"] = args["<value>"]
            config.update_config(conf_path, m_conf)
            m_conf = config.read_config(conf_path)
            print(m_conf)
        else:
            m_conf[args["<key>"]] = args["<value>"]
            config.update_config(conf_path, m_conf)
            m_conf = config.read_config(conf_path)
            print(m_conf)

    elif args.get("config") and args.get("list"):
        print(config.read_config(conf_path))

    elif args.get("e2sm"):
        # python index.py e2s a b
        epub2sm.start(args["<epub-path>"], args["<targetfolder>"])

    elif args.get("pathpix"):
        # smkit pathpix --least-col
        if args.get("--least-col"):
            sm_system1 = config.read_sm_system1(sm_location)
            least_used_col = config.get_collection_primaryStorage(
                sm_location, sm_system1
            )
            save_img_folder = os.path.join(least_used_col, "web_pic")
            print(least_used_col)
            print(save_img_folder)
            # pathpix.relative_and_localize(least_used_col, save_img_folder)
        elif args.get("<collection>"):
            col_folder = config.get_collection_primaryStorage(
                sm_location, args["<collection>"]
            )
            collection_temp_path = config.get_collections_temp(
                os.path.join(sm_location, "systems", args["<collection>"])
            )
            save_img_folder = os.path.join(col_folder, "web_pic")
            local_pic = os.path.join(col_folder, "local_pic")
            print("集合元素：", col_folder)
            print("图片位置：", [save_img_folder, local_pic])
            print("临时文件：", collection_temp_path)
            pathpix.start(col_folder, save_img_folder, collection_temp_path)
        elif args.get("--clean"):
            print("print::  smkit pathpix --clean", args["--clean"])
    elif args.get("clist"):
        col_list = config.get_collections_primaryStorage(sm_location)
        for col_name in col_list:
            print("集合名称：", col_name)


if __name__ == "__main__":
    cmd()

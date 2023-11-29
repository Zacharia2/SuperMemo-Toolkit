# encoding:utf-8
#!/usr/bin/env python
"""SMKit CLI Tool
Usage:
    smkit config set <key> <value>
    smkit config list
    smkit pathpix <collection>
    smkit clist

Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""
from docopt import docopt
import index as pathpix
import os
import sys

sys.path.insert(0, sys.path[0] + "/../")
from scripts import config  # noqa: E402

# pyinstaller --add-data "conf.json;." smkit.py


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

    elif args.get("pathpix"):
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
    elif args.get("clist"):
        col_list = config.get_collections_primaryStorage(sm_location)
        for col_name in col_list:
            print("集合名称：", col_name)


if __name__ == "__main__":
    cmd()

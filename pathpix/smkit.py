# encoding:utf-8
#!/usr/bin/env python
"""SMKit CLI Tool
Usage:
    smkit config set <key> <value>
    smkit config list
    smkit pathpix ( <collection> | [--clean=<collection>] | [--least-col] )
    smkit clist

Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""
from docopt import docopt
from pathpix import index as pathpix
import os
import sys

sys.path.insert(0, sys.path[0] + "/../")
from scripts import config  # noqa: E402

# pyinstaller --add-data "conf.json;." smkit.py
# pyinstaller smkit.spec


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

    elif args.get("pathpix"):
        sm_location = m_conf["program"]
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
    elif args.get("clist"):
        col_list = config.get_collections_primaryStorage(sm_location)
        for col_name in col_list:
            print("集合名称：", col_name)


if __name__ == "__main__":
    cmd()

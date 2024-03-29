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

import os

from docopt import docopt
from src.utilscripts import config
from src.epub2sm import epub2sm
from src.pathpix import index as pathpix
from src.pathpix import gui
from src.latex2img import index as latex2img


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


if __name__ == "__main__":
    cmd()

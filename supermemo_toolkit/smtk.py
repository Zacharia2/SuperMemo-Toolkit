# encoding:utf-8
# !/usr/bin/env python
"""SMTK CLI Tool
Usage:
    smtk config (set <key> <value> | list)
    smtk clist
    smtk e2sm (-t | -l | -c) <epub-path> <targetfolder>
    smtk pathpix (<col_name> [--clean] | --fullpath=<htmlpath> | --gui | --least-col)
    smtk imtex <formula_text> <outpath>
    smtk placeholders
Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""

import os

from docopt import docopt

from supermemo_toolkit.epub2sm import epub_convert
from supermemo_toolkit.latex2img import formula_to_png as latex2img
from supermemo_toolkit.pathpix import gui
from supermemo_toolkit.pathpix import im_sort_out as pathpix
from supermemo_toolkit.utilscripts import config


# pyinstaller smtk.spec


def main():
    args = docopt(__doc__)

    config_dir = config.get_config_dir()
    conf_path = os.path.join(config_dir, "conf.json")
    init_conf_json = {"program": "D:\\SuperMemo"}
    m_conf = dict()
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
            epub_convert.start_with_toc(args["<epub-path>"], args["<targetfolder>"])
        if args.get("-l"):
            epub_convert.start_with_linear(args["<epub-path>"], args["<targetfolder>"])
        if args.get("-c"):
            epub_convert.start_with_topic(args["<epub-path>"], args["<targetfolder>"])

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
    main()

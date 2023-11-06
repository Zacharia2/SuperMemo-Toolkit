# encoding:utf-8
""" CLI Demo Tool
Usage:
    clidemo cmdA <valueA>
    clidemo cmdB paramB <valueB>

Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""
# import pkg
import os
from docopt import docopt


def cmd():
    args = docopt(__doc__)
    if args.get("cmdA"):
        os.system("tree")
        os.system("ipconfig")
        os.system("netstat -ano")
        os.system("tasklist")
        print("#" * 100)
        print(args["<valueA>"])
        print("#" * 100)
    elif args.get("cmdB") and args.get("paramB"):
        os.system("tree")
        os.system("ipconfig")
        os.system("netstat -ano")
        os.system("tasklist")
        print("#" * 100)
        print(args["<valueB>"])
        print("#" * 100)


if __name__ == "__main__":
    cmd()

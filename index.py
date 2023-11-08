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
from epub2sm import epub2sm


def cmd():
    args = docopt(__doc__)
    if args.get("cmdA"):
        print("#" * 100)
        print(args["<valueA>"])
        print("#" * 100)
        epub2sm.test()



if __name__ == "__main__":
    cmd()

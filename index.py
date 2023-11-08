# encoding:utf-8
"""SMKit CLI Tool
Usage:
    smkit test <valueA>
    smkit e2s <valueA> <valueB>

Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""

import os
from docopt import docopt
from epub2sm import epub2sm


def cmd():
    args = docopt(__doc__)
    if args.get("test"):
        # python index.py e2s a
        print("#" * 100)
        print(args["<valueA>"])
        print("#" * 100)
        epub2sm.test()
    elif args.get("e2s"):
        epub2sm.test()
        # python index.py e2s a b
        pass


if __name__ == "__main__":
    cmd()

# encoding:utf-8
"""SMKit CLI Tool
Usage:
    smkit set config programs <path>
    smkit get config --all
    smkit e2s [<collection>] <epub-path> <targetfolder>
    smkit pathpix <collection>
    smkit indexer <epub> <output>
    smkit codetitlefix <node.txt>
    smkit test <valueA>

Options:
    -h --help       Show Help doc.
    -v --version    Show Version.
"""

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

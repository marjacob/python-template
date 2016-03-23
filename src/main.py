#!/usr/bin/env python
# -*- coding: utf-8 -*-


import os
import sys


def main(args):
    print("Hello, world!")
    print("Got {0} arguments...".format(len(args)))
    for arg in args:
        print("\t{0}".format(arg))
    return os.EX_OK


if __name__ == "__main__":
    sys.exit(main(sys.argv))

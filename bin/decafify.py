#!/usr/bin/env python

import sys
import os

####

if __name__ == "__main__":

    source = sys.argv[1]
    target = sys.argv[2]
    if not source: sys.exit("no source directory provided")
    if not target: sys.exit("no sarget directory provided")

    for filename in os.listdir(source):
        if filename.endswith(".decaf"): 
            sfilename = os.path.join(source, filename)
            tfilename = os.path.join(target, filename)+".rkt"

            with open(tfilename, "w") as tf:
                tf.write("#lang decaf\n\n")
                with open(sfilename, "r") as sf:
                    tf.write(sf.read())
        else:
            continue



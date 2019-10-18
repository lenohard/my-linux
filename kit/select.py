#! /usr/bin/env python
import os
import sys

options = sys.stdin.readlines()
for idx, val in enumerate(options):
    sys.stderr.write("%d:  %s\n" % (idx, val.rstrip()))

if len(options) == 0:
    sys.stderr.write("No options\n")
    exit(0)

f = open("/dev/tty", "r")
ns = set()
while 1:
    sys.stderr.write("your choice:> ")
    c = f.readline().rstrip()
    fs = c.split()
    for i in fs:
        try:
            n = int(i)
        except:
            break
        if n < len(options) and n >= 0:
            ns.add(n)
        else:
            break
    else:
        arguments = " ".join([ options[i].rstrip() for i in list(ns)])
        sys.stdout.write(arguments)
        exit(0)

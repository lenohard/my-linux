#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
sort the contents of 'result.txt' based on the numeric value present at the end of each line, regardless of the number of fields in each line

example content in 'result.txt':
    line1w1 line1w2 line1w3 123
    line2w1 line1w2 43
    line3w1 line1w2 line1w3 line1w4 12
    ...
"""

import re
import sys

def sort_file(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()
        lines = [re.split(r'\s+', line.strip()) for line in lines]
        lines = sorted(lines, key=lambda x: int(x[-1]))
        lines = [' '.join(line) for line in lines]
        return lines

if __name__ == '__main__':
    if len(sys.argv) >= 2:
        filename = sys.argv[1]
        lines = sort_file(filename)
        # output to stdout
        print("after sorting: \n {}".format('\n'.join(lines)))
        # write to original file
        with open(filename, 'w') as f:
            f.write('\n'.join(lines))
        # notify user that the file has been sorted, output to stdout with green color
        print("\033[32m{} has been sorted\033[0m".format(filename))
    else:
        lines = sort_file('./result.txt')
        print("after sorting: \n {}".format('\n'.join(lines)))
        with open('./result.txt', 'w') as f:
            f.write('\n'.join(lines))
        print("\033[32m{} has been sorted\033[0m".format('./result.txt'))


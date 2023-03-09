#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import os

# this file define some global variables and export them to other files

# import values into dictionary 'api' from ~/.openai.env
api={}
with open(os.path.expanduser("~/.openai.env")) as f:
    for line in f:
        # if the line is not empty
        if line.strip():
            # split the line into key and value
            (key, val) = line.split("=")
            api[key] = val.strip()

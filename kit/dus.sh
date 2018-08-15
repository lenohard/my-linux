#!/bin/bash

du -xhd1 "$1" | sort -rh | less

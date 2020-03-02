#!/bin/bash -
set -o nounset                              # Treat unset variables as an error
ocr_generate content > tmp.awk
./tmp.awk result.txt > tmp
ocr_final.sh "$1"

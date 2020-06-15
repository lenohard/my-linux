#!/bin/bash -
set -o nounset                              # Treat unset variables as an error
ocr_generate content > tmp.awk
chmod +x tmp.aw
./tmp.awk result.txt > tmp
ocr_final.sh "$1"
rm *.info content tmp.awk

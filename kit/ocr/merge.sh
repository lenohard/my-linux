#!/bin/bash -
set -o nounset                              # Treat unset variables as an error


if [[ $(file "$1") =~ "DjVu" ]]; then
  ocr.py
  djvused "$1" -e "set-outline tmp" -s
else
  ocr_generate content > tmp.awk
  chmod +x tmp.awk
  ./tmp.awk result.txt > tmp
  ocr_final.sh "$1"
fi


rm *.info content tmp* -f 2> /dev/null

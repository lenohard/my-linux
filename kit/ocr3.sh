#!/bin/bash
set -e

if [[ $# -ne 3 ]]; then
    echo " ocr fileanme first last (please ;\) "
    exit
fi

f=$2
l=$3
file=$1

ls image* 2>/dev/null  && rm image*
pdftoppm "$file" -png -f $f -l $l image
for file in image*;
do
    n="${file:7:3}"
    tesseract "$file" tmp"$n" --oem 3 --psm 6
done
cat tmp* | tee result.txt
rm tmp* image*





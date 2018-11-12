#!/bin/bash
set -e

if [[ $# -ne 3 ]]; then
    echo " ocr fileanme first last (please ;\) "
    exit
fi

f=$2
l=$3
file=$1

pdftoppm "$file" -png -f $f -l $l image
ls -1 ./image* > tmp.txt
tesseract tmp.txt result --oem3 --psm6
rm tmp.txt image*



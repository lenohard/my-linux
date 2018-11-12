#!/bin/bash
set -e

if [[ $# -ne 3 ]]; then
    echo " ocr fileanme first last (please ;\) "
    exit
fi

f=$2
l=$3
file=$1
[ ${1#*.} = 'djvu' ] &&  dj2pdf.sh $1
while [[ ! $l -lt $f ]]
do
    pdftoppm "$file" -png  -f $f -singlefile image && tesseract image.png output$f --oem 3 --psm 6
    f=$((f+1))
done
cat output*  | tee result.txt
rm output*

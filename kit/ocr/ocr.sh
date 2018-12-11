#!/bin/bash
read -p "do you want to know the workflow of ocr_suite?" -n 1 -r
if [[ $REPLY =~ [yY] ]];
then
    echo ./readme
fi
set -e

if [[ $# -ne 3 ]]; then
    echo " ocr fileanme first last (please ;\) "
    exit
fi

f=$2
l=$3
[ ${1#*.} = 'djvu' ] &&  dj2pdf.sh $1
file="${1/.djvu/.pdf}"
echo $file
sleep 3
while [[ ! $l -lt $f ]]
do
    pdftoppm "$file" -png  -f $f -singlefile image && tesseract image.png output$f --oem 3 --psm 6
    f=$((f+1))
done
cat output*  | tee result.txt
rm output* image.png

#!/bin/zsh
set -e

if [[ $# -lt 3 ]]; then
    echo " ocr fileanme first last (please ;\) "
    exit
fi

f=$2
l=$3
file=$1

if [[ $(file "$file") =~ "DjVu" ]]; then
  for i in {$f..$l}
  do
    ddjvu --format=ppm -page=$i -size=2000x2000 "$file" > image${i}.ppm
  done
else
  pdftoppm "$file" -png -f $f -l $l image
fi

for file in image*;
do
    n="${file:6:3}"
    tesseract "$file" tmp"$n" --oem 3 --psm 6 -l ${4:-eng}
done

cat tmp* | tee result.txt

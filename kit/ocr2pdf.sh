#!/bin/bash -
#===============================================================================
#
#          FILE: ocr2pdf.sh
#
#         USAGE: ./ocr2pdf.sh
#
#   DESCRIPTION: convert unsearchable pdf to searchable pdf using tesseract
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: YOUR NAME (),
#  ORGANIZATION:
#       CREATED: 11/12/2018 10:49
#      REVISION:  ---
#===============================================================================

set -e
if [[ $# == 3 ]]; then
    f=$2
    l=$3
    file=$1
    ls image* 2>/dev/null  && rm image*
    pdftoppm "$file" -png -f $f -l $l image
elif [[ $# == 1 ]];then
    file="$1"
    ls image* 2>/dev/null  && rm image*
    pdftoppm "$file" -png image
else
    echo "ocr2pdf filename [-f n -l m]"
fi
pdftk "$file" dump_data output info
for f in image*;
do
    n="${f%%.*}"
    n="${n#image-}"
    tesseract "$f" tmp-"$n" -l eng+ell+equ pdf
done
pdftk tmp* cat output searchabele.pdf
rm tmp* image*
pdftk searchabele.pdf update_info info output "${file%.*}"_searchabele.pdf
rm info

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

  name=${1%.*}
  pdftk "$1" dump_data output "$name".info
  awk -i inplace "!/Bookmark/" "$name".info
  ed -s  "${name}".info <<EOF
H
/NumberOf/-r tmp
w tmp.info
q
EOF

  mv tmp "${name}".bm
  mv tmp.info "${name^^}".info
  pdftk "$1" update_info "${name^^}".info output "${name^^}".pdf

fi


rm *.info content tmp* -f 2> /dev/null

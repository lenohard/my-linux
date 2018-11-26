#!/bin/bash
set -e
name=${1%.*}
pdftk "$1" dump_data output "$name".info
awk -i inplace "!/Bookmark/" "$name".info

# mv "$name".bm tmp

ed -s  "${name}".info <<EOF
H
/NumberOf/-r tmp
w tmp.info
q
EOF
mv tmp "${name}".bm
mv tmp.info "${name^^}".info
pdftk "$1" update_info "${name^^}".info output "${name^^}".pdf



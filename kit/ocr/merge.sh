#!/usr/bin/env zsh
set -o nounset                              # Treat unset variables as an error


if [[ $(file "$1") =~ "DjVu" ]]; then
    ocr.py 'djvu'
    djvused "$1" -e "set-outline tmp" -s
    cp "${1}" "$HOME/Greek/Front/galileo/BooksWithContentsByOCR"
    # if this is in mac os, use 'open' command open the file created under BooksWithContentsByOCR else do nothing
    if [[ $(uname) == "Darwin" ]]; then
        open "$HOME/Greek/Front/galileo/BooksWithContentsByOCR/${1}"
    fi
else
    ocr.py 'pdf'
    name=${1%.*}
    pdftk "$1" dump_data output "$name".info
    # extract the original bookmark part.
    awk '/BookmarkBegin/,/BookmarkPageNumber/' "$name".info > original.bm
    # the scanned bookmark is stored in 'tmp.bm'
    # if merge the original bookmark and scanned bookmark, ask for confirmation
    # if yes, merge the original bookmarks into the tmp.bm,otherwise, do nothing
    # default is no
    # remove the originl bookmark in info file using awk inplace
    awk '!/Bookmark/' "$name".info > tmp && mv tmp "$name".info
    if [[ -f tmp.bm ]]; then
        echo "Do you want to merge the original bookmarks into the scanned bookmarks? (y/n)[n]"
        read -r answer
        if [[ $answer == "y" ]]; then
            # insert original bookmarks into the beginning of the scanned bookmarks
            cat original.bm tmp.bm > tmp.bm.new
            mv tmp.bm.new tmp.bm
        fi
    fi

    # append bookmark part after the line `NumberOf ...` of the metadata file of pdf, {name}.info output to tmp.info
    ed -s  "${name}".info <<EOF
H
/NumberOf/-r tmp.bm
w tmp.info
q
EOF
    pdftk "$1" update_info tmp.info output "${name}"_ocr.pdf
    cp "${name}"_ocr.pdf "/Users/senaca/Greek/Front/galileo/BooksWithContentsByOCR"
    if [[ $(uname) == "Darwin" ]]; then
        open "$HOME/Greek/Front/galileo/BooksWithContentsByOCR/${name}_ocr.pdf"
    fi
fi



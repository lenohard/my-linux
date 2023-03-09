#!/usr/bin/env zsh
# this is a script to insert a cover image into a pdf/djvu file
# it uses the pdftk package and the djvused package

# the first argument is required and is the path to the book file
# the second argument is optional and is the path to the cover image
# if the second argument is not provided, the script will ask for a link to the image of the cover

if [[ -z $1 ]]; then
    echo "Please provide the path to the book file"
    exit 1
elif [[ ! -f $1 ]]; then
    echo "The file does not exist"
    exit 1
fi

if [[ ${1##*.} != "pdf" && ${1##*.} != "djvu" ]]; then
    echo "The file is not a pdf or djvu file"
    exit 1
fi

if [[ -z $2 ]]; then
    echo "Please provide the path to the cover image"
    read -r cover
    # if $cover is a link then download the cover image and save it as cover.jpg under the same directory as the book file
    if [[ $cover == http* ]]; then
        # wget save into os temp directory
        wget -q -O /tmp/cover.jpg "$cover"
        cover=/tmp/cover.jpg
    fi
else
    cover=$2
fi

if [[ ! -f $cover ]]; then
    echo "The cover image does not exist"
    exit 1
fi

    # test if convert is installed
    if ! command -v convert &> /dev/null; then
        echo "convert could not be found"
        exit 1
    fi
    # test if identify is installed
    if ! command -v identify &> /dev/null; then
        echo "identify could not be found"
        exit 1
    fi
    # get the size of the first page of the book
    if [[ ${1##*.} == "pdf" ]]; then
        size=$(pdfinfo "$1" | grep "Page size" | awk '{print $3"x"$5}')
    elif [[ ${1##*.} == "djvu" ]]; then
        # djvused return size in 'width=xxxx height=xxxx' format, unit is pixel so the number needs to be divided by 10
        size=$(djvused  -e 'select 1; size' "$1" | awk 'match($0, /width=([0-9]+) height=([0-9]+)/, a) {print a[1]"x"a[2]}')
    fi
    echo "The size of the first page is $size"
    # convert the cover image with the same size as the first page of the book
    convert "$cover" -resize "$size" /tmp/cover.jpg

# insert the cover image at the beginning of the book file
if [[ ${1##*.} == "pdf" ]]; then
    # convert the cover image to a pdf file according the size of the first page of the book
    convert /tmp/cover.jpg /tmp/cover.pdf
    cover=/tmp/cover.pdf
    echo "Converting the cover image to a pdf file"
    # choose inserting cover or overwriting cover, default is inserting
    # zoom the image to match the size of the first page
    # then insert the image
    # output the result to a new file named [origin name]_cover.pdf
    echo "Do you want to insert(y) or overwriting(n) the cover? [y]"
    read -r choice
    # if $choice is empty, then set it to y, ignore case
    if [[ ${choice:-y} =~ [yY] ]]; then
        # insert in the first page
        pdftk "$cover" "$1" cat output "${1%.*}_cover.pdf"
        open "${1%.*}_cover.pdf"
    elif [[ ${choice:-y} =~ [nN] ]]; then
        # concate the cover pdf and the book except the first page
        pdftk A="$cover" B="$1" cat A B2-end output "${1%.*}_cover.pdf"
        # ask if user want to copy the metadata from the original file
        echo "Do you want to copy the metadata from the original file? (y/n)[y]"
        read -r choice
        if [[ ${choice:-y} =~ [yY] ]]; then
            # extrac metadata from the original file including the content
            pdftk "$1" dump_data output /tmp/metadata.txt
            # copy metadata to the new file
            pdftk "${1%.*}_cover.pdf" update_info /tmp/metadata.txt output "${1%.*}_cover_info.pdf"
            mv "${1%.*}_cover_info.pdf" "${1%.*}_cover.pdf"
            cp "${1%.*}_cover.pdf" "/Users/senaca/Greek/Front/galileo/BooksWithContentsByOCR/${1%.*}"
            open "/Users/senaca/Greek/Front/galileo/BooksWithContentsByOCR/${1%.*}"
        fi
    fi
fi

if [[ ${1##*.} == "djvu" ]]; then
    # convert the cover image to a pdf then to a djvu file
    convert /tmp/cover.jpg /tmp/cover.pdf
    echo "Converting the cover image to a pdf file"
    pdf2djvu -o /tmp/cover.djvu /tmp/cover.pdf
    echo "Converting the cover pdf file to a djvu file"
    cover=/tmp/cover.djvu

    # insert the cover image at the beginning of the book file
    # output the result to a new file named [origin name]_cover.djvu
    # if $choice is empty, then set it to y, ignore case
    read -r -p "Do you want to insert(y) or overwriting(n) the cover? [y]" choice
    if [[ ${choice:-y} =~ [yY] ]]; then
        # concate the cover djvu and the book
        djvm -c "${1%.*}_cover.djvu" "$cover" "$1"
        open "${1%.*}_cover.djvu"
    elif [[ ${choice:-y} =~ [nN] ]]; then
        # concate the cover pdf and the book except the first page
        djvm -c "${1%.*}_cover.djvu" "$cover" "$1"
        djvm -d "${1%.*}_cover.djvu" 2
        open "${1%.*}_cover.djvu"
    fi
fi

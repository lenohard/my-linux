#!/usr/bin/env zsh

# Exit immediately if a command exits with a non-zero status
set -e

# parameters: -c for simplified chinese

# Check that the required number of arguments was provided
if [[ $# -lt 3 ]]; then
    echo "Usage: ocr fileanme first_page last_page [textcleaner]"
    exit 1
fi

# Assign arguments to variables
file=$1
first_page=$2
last_page=$3
textcleaner=$4

# Check that the file exists and is a supported file type
if [[ ! -f "$file" ]]; then
    echo "Error: file does not exist"
    exit 1
elif [[ $(file "$file") =~ "DjVu" ]]; then
    # Extract pages from DjVu file
    for i in {$first_page..$last_page}; do
        if ! command -v ddjvu > /dev/null; then
            echo "Error: ddjvu command not found"
            exit 1
        fi
        ddjvu --format=ppm -page=$i -size=2000x2000 "$file" > "image${(l:4::0:)i}.ppm"
    done
elif [[ $(file "$file") =~ "PDF" ]]; then
    # Convert pages to images and extract text from PDF file
    if ! command -v pdftoppm > /dev/null; then
        echo "Error: pdftoppm command not found"
        exit 1
    fi
    pdftoppm "$file" -png -f $first_page -l $last_page image
    if ! command -v pdftotext > /dev/null; then
        echo "Error: pdftotext command not found"
        exit 1
    fi
    pdftotext -layout -f $first_page -l $last_page "$file" > result.txt
else
    echo "Error: unsupported file type"
    exit 1
fi

# Process image files
for file in image*; do
    # Extract page number from file name
    if ! command -v perl > /dev/null; then
        echo "Error: perl command not found"
        exit 1
    fi
    n=$(echo $file | perl -nle 'm/image-?(\d+).(ppm|png)/; print $1')

    # Apply text cleaner if requested
    if [[ -n "$textcleaner" && "$textcleaner" == "tc" ]]; then
        if ! command -v textcleaner > /dev/null; then
            echo "Error: textcleaner command not found"
            exit 1
        fi
        output="${file%.*}".tiff
        textcleaner  -g -e stretch -t 30 -s 2 -u -T "$file" "$output"
    else
        output="${file}"
    fi

    # Run OCR on image
    if ! command -v tesseract > /dev/null; then
        echo "Error: tesseract command not found"
        exit 1
    fi
    # if -c is provided, use simplified chinese
    if [[ $# -eq 4 && "$4" == "-c" ]]; then
        tesseract "$output" "tmp$n"  --oem 3 --psm 6 -l chi_sim
    else
        tesseract "$output" "tmp$n" -l eng --oem 3 --psm 6
    fi
    echo "tmp$n"
    echo "$output"
done

cat tmp*.txt | tee -a result.txt


#!env zsh
set -e

if [[ $# -lt 3 ]]; then
    echo " ocr fileanme first last (please) "
    exit
fi

f=$2
l=$3
file=$1

if [[ $(file "$file") =~ "DjVu" ]]; then
    for i in {$f..$l}
    do
        ddjvu --format=ppm -page=$i -size=2000x2000 "$file" > image${(l:4::0:)i}.ppm
    done
else
    pdftoppm "$file" -png -f $f -l $l image
    pdftotext -layout -f $f -l $l "$file" result.txt
fi

for file in image*;
do
    n=$(echo $file | perl -nle 'm/image(\d+).ppm/; print $1')
    if [[ $4 == "tc" ]];
    then
        output="${file%.*}".tiff
        textcleaner  -g -e stretch -t 30 -s 2 -u -T "$file" "$output"
    else
        output="${file}"
    fi
    tesseract "$output" tmp"$n" -l eng --oem 3 --psm 6
    # pdftotext -layout tmp"$n".pdf tmp"$n".layout
done

cat tmp*.txt | tee -a result.txt

}

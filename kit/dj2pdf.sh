#!/bin/bash
#usage: djvu2pdf.sh [-q quality | -b] <infile.djvu> [outfile.pdf]
mode="color"
quality=80

aparse() {
    while [ $# != 0 ] ; do
        case "(" in
            -q|--quality)
                quality=${2}
                shift
                ;;
            -b|--black)
                mode='black'
                ;;
        esac
        shift
    done
}
aparse "$@"


i="$1"
o=${2:-$(basename "$i" .djvu).pdf}
if [ -f  "$o" ]; then
    echo "file $o exists, override [Y/n]?"
    read ans
    case "$ans" in
        n|N) exit 1;;
    esac
fi
echo "[ converting $i to $o ] "

cmd="ddjvu -format=pdf -quality=$quality -mode=$mode -verbose $i $o "

echo "[ executing $cmd ] "
$cmd

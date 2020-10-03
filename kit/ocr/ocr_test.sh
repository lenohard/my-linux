#!/bin/bash

awk -v p1="$1" 'match($0, p1, m){print m[1]"   ,   "m[2]}' "${2:-result.txt}"
read -p "OK? (Y|N):"
if [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]
then
    read -p "RANK: " rank
    awk -v p="$1" -v rank="$rank" 'NR==1{print p"    "rank}' result.txt >> content
    echo "CURRENT CONTENTL"
    awk -i inplace '!seen[$0]++' content            # remove duplicate lines
    if grep offset content >> /dev/null 2>&1;
    then
        echo "offset exist"
    else
        read -p "OFFSET ? : " offset
        awk -i inplace -v ost="$offset" 'BEGINFILE{print "offset    "ost}{print}' content
    fi

    if grep "$1" ~/kit/ocr/readme -F >> /dev/null 2>&1;
    then
        echo "pattern exist"
    else
        echo "$1" >> ~/kit/ocr/readme
    fi
else
    exit
fi

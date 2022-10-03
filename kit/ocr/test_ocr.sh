#!/bin/bash
while [[ 1 ]]
do
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    if [[ -z $1 ]];
    then
        # readarray -t regexs < $SCRIPT_DIR/regexs
        # length=${#regexs[@]}
        # for (( j=0; j<${length}; j++ ));
        # do
        #     echo "$j ${regexs[j]}"
        # done
        while [[ 1 ]]
        do
            res=$(fzf < $SCRIPT_DIR/regexps)
            echo "$res"
            # awk -v p1="$res" 'match($0, p1, m){print m[1]"   ,   "m[2]}' "${2:-result.txt}"
            ocr_re result.txt "$res"
            read -p "continue (y(yes)|n(next)|q(quit)):"
            if [[ ${REPLY^^} == "Y" ]];
            then
                echo "pass"
                REG="$res"
                break;
            elif [[ ${REPLY^^} == "Q" ]];
            then
                echo "exit"
                exit 0
            fi
        done
    else
        REG=$1
        ocr_re result.txt "$REG"
        read -p "OK? (Y|N):"
    fi

    if [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]
    then
        read -p "RANK: " rank
        echo "$REG     $rank" >> content
        echo "current content:"
        cat content
        awk -i inplace '!seen[$0]++' content            # remove duplicate lines
        if grep offset content >> /dev/null 2>&1;
        then
            echo "offset exist"
        else
            read -p "OFFSET ? : " offset
            awk -i inplace -v ost="$offset" 'BEGINFILE{print "offset    "ost}{print}' content
        fi

    # if grep ifCover content >> /dev/null 2>&1;
    # then
    #     echo "ifCover exist"
    # else
    #     read -p "IFCOVER ? : " ifCover
    #     awk -i inplace -v ost="$ifCover" 'BEGINFILE{print "ifCover    "ost}{print}' content
    # fi

    if grep "$REG" ~/kit/ocr/regexps -F >> /dev/null 2>&1;
    then
        echo
    else
        echo "$REG" >> ~/kit/ocr/regexs
    fi
else
    exit
fi

read -p "EXIT? (Y|N):"
if [[ $REPLY =~ ^[Yy]$ ]]
then
    exit 0
fi
done

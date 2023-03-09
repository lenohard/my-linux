#!/usr/bin/env bash
while [[ 1 ]]
do
    SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    if [[ -z $1 ]];
    then
        while [[ 1 ]]
        do
            res=$(fzf < $SCRIPT_DIR/regexps)
            if [[ $res =~ .*:::(.*)$ ]]; then
                pat=${BASH_REMATCH[1]}
            fi
            echo "$pat"
            # if pat containing 'custome' then prompt for the custome string
            if [[ $pat =~ .*custome.* ]]; then
                echo "Enter custome string"
                read -r custome
                res=$(echo "$res" | sed "s/custome/$custome/g")
                if [[ $res =~ .*:::(.*)$ ]]; then
                    pat=${BASH_REMATCH[1]}
                fi
                echo "$pat"
            fi
            ocr_re result.txt "$pat"
            read -p "next step?  (y(yes)|n(next)|q(quit)):"
            if [[ ${REPLY^^} == "Y" ]];
            then
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
        echo "$REG:::$rank" >> content
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

        if grep ifCover content >> /dev/null 2>&1;
        then
            echo "ifCover exist"
        else
            read -p "IFCOVER(0:none; n:actual number) ? : " ifCover
            awk -i inplace -v ost="$ifCover" 'BEGINFILE{print "ifCover    "ost}{print}' content
        fi

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

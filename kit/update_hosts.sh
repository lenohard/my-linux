#!/bin/bash

cwd="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR

hosts=("arch" "wdh" "elementary" "imac" "test")

iplookup() {
    if nmblookup "$1" >/dev/null
    then
        nmblookup "$1" | awk '{print $1}'
        return 0
    else
        return 1
    fi
}

if  ! type nmblookup > /dev/null 2>&1;
then
    echo "there is no nmblookup in your PATH"
    echo "info maybe incorrect"
else
    for host in "${hosts[@]}"
    do
        #awk -v hst=$host '$2!~/^hst&/ {print $0}' /etc/hosts  > /etc/hosts
        # grep -wiv $host
        if nmblookup "$host" >/dev/null;then
            echo "$host $(iplookup $host)"  >> "$DIR"/etc/iplist
        fi
    done
fi

name=($(awk '{print $1}' "$DIR"/etc/iplist))
ip=($(awk '{print $2}' "$DIR"/etc/iplist))
for n in "${!name[@]}";
do
    if [[ $(uname) == "Darwin" ]];
    then
        sed -in  "/\b${name[n]}\b/d" /etc/hosts
    else
        sed -in  "/\b${name[n]}\b/d" /etc/hosts
    fi
    echo "${ip[n]} ${name[n]}" >> /etc/hosts
done
cd "$cwd"

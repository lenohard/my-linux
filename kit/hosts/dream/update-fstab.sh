#!/bin/bash

hosts=("arch" "wdh" "elementary")

iplookup() {
    if nmblookup "$1" >/dev/null
    then
        nmblookup "$1" | awk '{print $1}'
        return 0
    else
        return 1
    fi
}

ip=//"$( iplookup wdh )"/Humbee
if [ -n "$ip" ]
then
    awk -i inplace -v IP="$ip" '/\/mnt\/WDH/ {sub($1, IP)}{print}' /etc/fstab
fi

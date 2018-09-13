#!/bin/bash

set -e

if [ "$(find /mnt/WDH_Front -maxdepth 0 -type d -empty 2>/dev/null)" ];then
    if mount /mnt/WDH_Front;then
        :
    else
        exit 1
    fi
fi

if [ $(find /mnt/galileo/Front -maxdepth 0 -type d -emtpy 2>/dev/null) ];then
    if mount /mnt/galileo/Front;then
        :
    else
        exit 1
    fi
fi

rsync -aPv --delete '/mnt/WDH_Front/Front/' /mnt/galileo/Front/

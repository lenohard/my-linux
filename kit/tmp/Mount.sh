#!/bin/bash
set -e

if [ "$(find /mnt/elementary -maxdepth 0 -type d -empty 2>/dev/null)" ];then
    if mount /mnt/elementary;then
        :
    else
        exit 1
    fi
fi

if [ "$(find /mnt/WDH_Front -maxdepth 0 -type d -empty 2>/dev/null)" ];then
    if mount /mnt/WDH_Front;then
        :
    else
        exit 1
    fi
fi

if [ "$(find /mnt/WDH_Media -maxdepth 0 -type d -empty 2>/dev/null)" ];then
    if mount /mnt/WDH_Media;then
        :
    else
        exit 1
    fi
fi

if [ "$(find /mnt/WDH_baidupcs -maxdepth 0 -type d -empty 2>/dev/null)" ];then
    if mount /mnt/WDH_baidupcs;then
        :
    else
        exit 1
    fi
fi

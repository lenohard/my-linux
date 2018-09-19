#!/bin/bash

set -e

if [ "$(find /mnt/WDH_Front -maxdepth 0 -type d -empty 2>/dev/null)" ];then
    if mount /mnt/WDH_Front;then
        :
    else
        exit 1
    fi
fi

if [ $(find /mnt/share/racoon -maxdepth 0 -type d -emtpy 2>/dev/null) ];then
    if mount /mnt/share/racoon; then
        :
    else
        exit 1
    fi
fi

rsync -aPv --delete '/mnt/WDH/Front/' /mnt/share/racoon/Front
rsync -aPv --delete /mnt/WDH_Front/Calibre_Library/ /mnt/share/racoon/Calibre_Library
rsync -aPv '/mnt/WDH/music/' /mnt/share/racoon/music

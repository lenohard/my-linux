#!/bin/bash

set -e

if [ "$(find /mnt/WDH -maxdepth 0 -type d -empty 2>/dev/null)" ];then
    if sudo mount /mnt/WDH;then
        :
    else
        echo "cant mount /mnt/WDH"
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

for i in "$@"
do
    case "$i" in
        "book")
            sudo rsync -aPv --delete '/mnt/WDH/Front/' /mnt/share/racoon/Front
            ;;
        "library")
            sudo rsync -aPv /mnt/WDH/Calibre_Library/ /mnt/share/racoon/Calibre_Library
            sudo rsync -aPv /mnt/share/racoon/Calibre_Library/ /mnt/WDH/Calibre_Library
            ;;
        "music")
            sudo rsync -aPv '/mnt/WDH/music/' /mnt/share/racoon/music
            ;;
    esac
done

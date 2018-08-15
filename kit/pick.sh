#!/bin/bash
# pick: select arguments

PATH=/bin:/usr/bin
IFS=$'\n'
for i in $@
do
    echo -n "$i? " > /dev/tty
    read response
    case $response in
        y*) echo $i >>pick
             ;;
        q*) break ;;
    esac

done </dev/tty

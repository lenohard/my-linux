#!/bin/bash -
#===============================================================================
#
#          FILE: bili-after.sh
#
#         USAGE: ./bili-after.sh
#
#   DESCRIPTION: combine flv parts ,  titles strip \r , rename video files
#                accoding to titles
#
#       OPTIONS: ---
#  REQUIREMENTS: the videos, and title.txt urls.txt in current dir
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Carl Leohard
#  ORGANIZATION:
#       CREATED: 12/19/2018 11:19
#      REVISION:  ---
#===============================================================================

set -o nounset                              # Treat unset variables as an error

list=$(for i in *.flv;
do
    echo ${i%%-*}
done | uniq)

sed -i 's/\r$//g' title.txt
sed -i 's/\//|/g' title.txt

for i in $list;
do
    for j in $i*;
    do
        echo file $j >> m$i
    done
    ffmpeg -f concat -safe 0 -i m$i  -c copy $i.mp4
done

a=1
for file in *.mp4;
do
    title=$(awk -F "、" -v n=$a 'NR==n {print $2}' title.txt)
    mv "$file" "$title".mp4
    a=$((a+1))
done

rm m* *.flv

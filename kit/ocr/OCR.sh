#!/bin/bash -
#===============================================================================
#
#          FILE: OCR.sh
#
#
#   DESCRIPTION:
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Carlleonhard
#  ORGANIZATION:
#       CREATED: 11/21/2018 19:28
#      REVISION:  0
#===============================================================================

set -o nounset                              # Treat unset variables as an error
ocr_generate content > tmp.awk
./tmp.awk result.txt > tmp
ocr_final.sh "$1"

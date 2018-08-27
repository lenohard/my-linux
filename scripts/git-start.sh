#!/bin/bash
ROOT="$(realpath ../"$(dirname "${BASH_SOURCE[0]}" )")"
set -e
set -x
FILE1="$HOME/.gitignore_global"
[[ -f "$FILE1" ]] && mv "$FILE1" "$FILE1".bk
ln -s $ROOT/git/.gitignore_global "$FILE1"
FILE2="$HOME/.gitconfig"
[[ -f "$FILE2"  ]] && mv "$FILE2" "$FILE2".bk
ln -s  $ROOT/git/.gitconfig "$FILE2"

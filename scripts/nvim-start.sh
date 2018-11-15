#!/bin/bash -
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
ROOT="$(dirname $DIR)"

if [ -d ~/.config/nvim ] || [ -h ~/config/nvim ];then
    read -p  "nvim existed, do you want to delete it for a fresh install?(y|n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ || -z $REPLy ]]
    then
        rm -rf ~/.config/nvim
    else
        exit
    fi
fi

[ -d ~/.config ] || mkdir ~/.config
ln -s $ROOT/vim/vim_runtime $HOME/.config/nvim

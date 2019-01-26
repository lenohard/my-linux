#! /bin/bash

set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
ROOT="$(dirname $DIR)"

if [ -d ~/.vim_runtime ] || [ -h ~/.vim_runtime ];then
    read -p  ".vim_runtime existed, do you want to delete it for a fresh install?(y|n)" -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ || -z $REPLy ]]
    then
        rm -rf ~/.vim_runtime
    else
        exit
    fi
fi

ln -s $ROOT/vim/vim_runtime $HOME/.vim_runtime
ln -s $ROOT/vim/vimrc $HOME/.vimrc
# bash ~/.vim_runtime/scripts/install_awesome_vimrc.sh

read -p  "Continue PlugInstall? (y|n)" -n 1 -r
echo

if  [[ $REPLY =~ ^[Yy]$ || -z $REPLY ]]
then
    vim -c ":PlugInstall"
fi

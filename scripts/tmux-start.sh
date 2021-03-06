#!/bin/bash
cwd="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
if [ ! -n "$TMUX" ]; then
    TMUX=~/.tmux
fi

if [[ -d "$TMUX" ]]; then
    echo "You need to delete your previous ~/.tmux to go on"
    read -p "rm?[y|n]" -n 1 -r
    if [[ $REPLY =~ ^[yY]$ || -z $REPLY ]]
    then
        rm -rf ~/.tmux
    else
        exit
    fi
fi

if [ -h ~/.tmux.conf ]; then
    echo "Note: your ~/.tmux.conf will be mv to .tmux.conf.bk"
    mv ~/.tmux.conf ~/.tmux.conf.bk
fi
ln -s $(dirname $PWD)/tmux/tmux.conf ~/.tmux.conf
echo "creating link ~/.tmux.conf: ok!"

[[ -h ~/.tmux.conf.conf || -f ~/.tmux.conf.local ]] && mv ~/.tmux.conf.local ~/.tmux.conf.local.$RANDOM
ln -s $(dirname $PWD)/tmux/tmux.conf.local ~/.tmux.conf.local
echo "copying tmux.conf.local: ok!"
if [ ! -d ~/.tmux/plugins ]; then
    mkdir ~/.tmux/plugins/tpm -p
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
# ln -s $(dirname $DIR)/tmux/resurrect ~/.tmux/resurrect
cd $cwd

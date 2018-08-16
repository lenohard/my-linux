#!/bin/bash
cwd="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
if [ ! -n "$TMUX" ]; then
    TMUX=~/.tmux
fi

if [  -d "$TMUX" ]; then
    printf "Note: your ~/.tmux will be mv tu .zsh.bk\n"
    mv ~/.tmux ~/.tmux.bk.$RANDOM
fi

mkdir ~/.tmux
echo "mkdir ~/.tmux: ok!"

if [ -h ~/.tmux.conf ]; then
    echo "Note: your ~/.tmux.conf will be mv to .tmux.conf.bk"
    mv ~/.tmux.conf ~/.tmux.conf.bk
fi

cp ../tmux/tmux.conf "$TMUX"/.tmux.conf && ln -s  "$TMUX"/.tmux.conf ~/.tmux.conf
echo "creating link ~/.tmux.conf: ok!"
cp ../tmux/tmux.conf.local ~/.tmux.conf.local
echo "copying tmux.conf.local: ok!"
#cp ../tmux/plugins ~/.tmux/ -r
#echo "copying tmux/plugins/: ok!"
mkdir -p ~/.tmux/plugin
cd ~/.tmux/plugin
git clone https://github.com/tmux-plugins/tpm.git
git clone https://github.com/tmux-plugins/tmux-resurrect.git
cd $cwd

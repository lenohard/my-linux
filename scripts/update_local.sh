#! /bin/bash
set -e
if [[ ! -n $1 ]] ; then
    echo "exit: cloud path required!"
fi


PRO_PATH="$1"
set -x
cp $PRO_PATH/vim/my_configs.vim ~/.vim_runtime/my_configs.vim
cp $PRO_PATH/tmux/tmux.conf.local ~/.tmux.conf.local
cp $PRO_PATH/tmux/tmux.conf ~/.tmux/.tmux.conf
cp $PRO_PATH/tmux/plugins ~/.tmux/ -r
cp $PRO_PATH/tmux/resurrect ~/.tmux/ -r
cp $PRO_PATH/zsh/zshrc ~/.zshrc
cp $PRO_PATH/hosts/hosts /etc/hosts



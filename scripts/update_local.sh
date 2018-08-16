#! /bin/bash
set -e
#if [[ ! -n $1 ]] ; then
#    echo "exit: cloud path required!"
#    exit
#fi


PRO_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )"; cd .. >/dev/null && pwd )"

set -x
cp $PRO_PATH/vim/my_configs.vim ~/.vim_runtime/my_configs.vim
cp $PRO_PATH/tmux/tmux.conf.local ~/.tmux.conf.local
cp $PRO_PATH/tmux/tmux.conf ~/.tmux/.tmux.conf
cp $PRO_PATH/zsh/zshrc ~/.zshrc
sudo cp $PRO_PATH/hosts/hosts /etc/hosts
cp $PRO_PATH/git/.gitconfig $PRO_PATH/git/.gitignore_global ~



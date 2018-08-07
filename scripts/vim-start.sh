#! /bin/bash

#    if [[ -d ~/.vim_runtime ]]; then
#        echo "Note: previous .vim_runtime will be mvd to .vim_runtime.bk"
#        mv ~/.vim_runtime ~/.vim_runtime.bk$RANDOM
#    fi
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR

if [[ ! -d ~/.vim_runtime ]]; then
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime
fi

sh ~/.vim_runtime/install_awesome_vimrc.sh
cp ../vim/plug.vim ~/.vim_runtime/autoload/

cp  ../vim/my_configs.vim ~/.vim_runtime/ -f
echo "copying my_configs: ok!"
echo "copying my_plugins: ok!"
vim -c ":PlugInstall"

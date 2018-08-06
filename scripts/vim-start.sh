#! /bin/bash

git clone https://github.com/amix/vimrc.git .vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

cp  ../vim/my_configs.vim ~/.vim_runtime/ -f
cp ../vim/my_plugins ~/.vim_runtime -rf

#! /bin/bash

git clone https://github.com/amix/vimrc.git .vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

cp  ./my_configs.vim ~/.vim_runtime/ -f
cp ./my_plugins ~/.vim_runtime -rf
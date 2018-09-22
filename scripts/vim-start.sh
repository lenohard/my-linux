#! /bin/bash

#    if [[ -d ~/.vim_runtime ]]; then
#        echo "Note: previous .vim_runtime will be mvd to .vim_runtime.bk"
#        mv ~/.vim_runtime ~/.vim_runtime.bk$RANDOM
#    fi
set -e
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
ROOT="$(dirname $DIR)"

if [[ ! -d ~/.vim_runtime ]]; then
    git clone https://github.com/amix/vimrc.git ~/.vim_runtime
fi

sh ~/.vim_runtime/install_awesome_vimrc.sh
[[  -e ~/.vim_runtime/autoload/plug.vim ]] || cp ../vim/plug.vim ~/.vim_runtime/autoload/
[[ -e ~/.vim_runtime/.git/info/exclude  || -h ~/.vim_runtime/.git/info/exclude ]] && rm ~/.vim_runtime/.git/info/exclude && ln $ROOT/vim/exclude ~/.vim_runtime/.git/info/exclude -s

[[ -e ~/.vim_runtime/my_configs.vim || -h ~/.vim_runtime/my_configs.vim ]] && rm ~/.vim_runtime/my_configs.vim
ln  $ROOT/vim/my_configs.vim ~/.vim_runtime/ -s
echo "copying my_configs: ok!"
vim -c ":PlugInstall"

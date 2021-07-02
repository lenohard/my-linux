#!/bin/bash -
set -e

curl -L https://git.io/haskell-vim-now > /tmp/haskell-vim-now.sh
bash /tmp/haskell-vim-now.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
ROOT="$(dirname $DIR)"
ln  $ROOT/vim/haskell-vim-now/plugins.vim  ~/.config/haskell-vim-now/plugins.vim  -s
ln  $ROOT/vim/haskell-vim-now/vimrc.local  ~/.config/haskell-vim-now/vimrc.local  -s 

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
ROOT="$(dirname $DIR)"
ln  $ROOT/vim/haskell-vim-now/plugins.vim  ~/.config/haskell-vim-now/plugins.vim  -s
ln  $ROOT/vim/haskell-vim-now/vimrc.local  ~/.config/haskell-vim-now/vimrc.local  -s 

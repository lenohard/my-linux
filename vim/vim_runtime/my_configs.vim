"--------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim_runtime/my_plugins')

" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
Plug 'vim-syntastic/syntastic'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-unimpaired'
Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/Colorizer'
Plug 'wmvanvliet/jupyter-vim'
Plug 'Shougo/unite.vim'
Plug 'mileszs/ack.vim'
Plug 'corntrace/bufexplorer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'yuttie/comfortable-motion.vim'
Plug 'vim-scripts/mru.vim'
Plug 'wellle/targets.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'amix/vim-zenroom2'
Plug 'scrooloose/snipmate-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'nanotech/jellybeans.vim'

" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-sensible'
" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py ' }

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
Plug '~/.vim_runtime/sources_forked/peaksea'
Plug '~/.vim_runtime/sources_forked/set_tabline'
Plug '~/.vim_runtime/sources_forked/vim-peepopen'
Plug '~/.vim_runtime/sources_forked/vim-irblack-forked'

" Initialize plugin system
call plug#end()
"--------------------------------------------------------------------

source /home/carl/.vim_runtime/my_plugins_configs.vim
map <leader>ep :e! ~/.vim_runtime/my_plugins_configs.vim<cr>

"---------------
"UI
"---------------
set background=dark
colorscheme jellybeans
set nohlsearch
set number
set number relativenumber
set nowrap
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END
set cursorline


set rtp+=/usr/share/powerline/bindings/vim/
set t_Co=256
set autochdir

let maplocalleader=",,"

iabbrev gml mathestics@gmail.com
iabbrev unm carlleonhard
iabbrev wyyx mathestics@163.com
iabbrev pnb 15238723375
iabbrev seperate -----------------------------------------
nmap <leader>Se o------------------BEGIN------------------------------<c-c>0gcc
nmap <leader>SE o==================END================================<c-c>0gcc
nmap <leader>se ojkx,Seojkx,SE2ko

nnoremap nb /BEGIN<cr>
nnoremap ne /END<cr>

" au BufNewFile * :write
" au FileType vim 
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <leader>? :help 
nnoremap <leader>q :wq<esc>
nnoremap <leader>X :q!<esc>
nnoremap <leader>bb :bd<esc>

" unmap space for / and c-space for ? in basic.vim

"augroup cpp_group
"    autocmd!
"    au FileType c,cpp nnoremap <localleader>cc o/*<cr>*/<esc>O
"    au FileType c,cpp nnoremap <buffer> <localleader>sp I//seperate<esc>
"    au FileType c,cpp nnoremap <buffer> <localleader>c I//<esc>
"augroup END
"augroup shell_group
"    autocmd!
"    au FileType zsh,bash,sh nnoremap <buffer> <localleader>c I#<esc>
"    au FileType zsh,bash,sh nnoremap <buffer> <localleader>sp I#seperate<esc>
"augroup END
"augroup vim_group
"    autocmd!
"    au FileType vim nnoremap <buffer> <localleader>sp I"seperate<esc>
"    au FileType vim nnoremap <buffer> <localleader>c I"<esc>
"augroup END

map <leader>E :e! ~/.vim_runtime/vimrcs/basic.vim <cr>
map <leader>ee :e! ~/.vim_runtime/vimrcs/extended.vim <cr>
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
set ssop-=buffers

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set tags=./tags,tags;

"Z - cd to recent / frequent directories
"-------------------------------------------------------------------
command! -nargs=* Z :call Z(<f-args>)
function! Z(...)
    let cmd = 'fasd -d -e printf'
    for arg in a:000
        let cmd = cmd . ' ' . arg
    endfor
    let path = system(cmd)
    if isdirectory(path)
        echo path
        exec 'cd' fnameescape(path)
    endif
endfunction
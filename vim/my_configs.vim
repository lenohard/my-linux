set number
set nohlsearch

set rtp+=/usr/share/powerline/bindings/vim/
set t_Co=256

let maplocalleader=",,"

iabbrev gml mathestics@gmail.com
iabbrev unm carlleonhard
iabbrev wyyx mathestics@163.com
iabbrev pnb 15238723375
iabbrev sperate -----------------------------------------

au BufNewFile * :write
au FileType vim 

inoremap jk <esc>l
inoremap <esc> <nop>
nnoremap <leader>q :wq<esc>
nnoremap <leader>qq :q!<esc>
nnoremap <leader>bb :bd<esc>

augroup cpp_group
    autocmd!
    au FileType c,cpp nnoremap <localleader>cc o/*<cr>*/<esc>O
    au FileType c,cpp nnoremap <buffer> <localleader>sp I//seperate<esc>
    au FileType c,cpp nnoremap <buffer> <localleader>c I//<esc>
augroup END
augroup shell_group
    autocmd!
    au FileType zsh,bash,sh nnoremap <buffer> <localleader>c I#<esc>
    au FileType zsh,bash,sh nnoremap <buffer> <localleader>sp I#seperate<esc>
augroup END
augroup vim_group
    autocmd!
    au FileType vim nnoremap <buffer> <localleader>sp I''seperate<esc>
    au FileType vim nnoremap <buffer> <localleader>c I''<esc>
augroup END

map <leader>E :e! ~/.vim_runtime/vimrcs/basic.vim <cr>
map <leader>ee :e! ~/.vim_runtime/vimrcs/extended.vim <cr>
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
set ssop-=buffers

let g:syntastic_check_on_wq = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_always_populate_loc_list = 1
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1

set tags=./tags,tags;

set autochdir

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
Plug 'vim-airline/vim-airline-themes'
Plug 'tomlion/vim-solidity'
Plug 'Valloric/YouCompleteMe'

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

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'



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

" airline config
" -----------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
"=======================================================

" Initialize plugin system
call plug#end()

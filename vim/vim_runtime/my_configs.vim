"--------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim_runtime/my_plugins')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'vim-scripts/paredit.vim'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-easy-align'
Plug 'vim-syntastic/syntastic'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-unimpaired'
Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/Colorizer'
Plug 'Shougo/unite.vim'
Plug 'mileszs/ack.vim'
Plug 'corntrace/bufexplorer'
Plug 'ap/vim-buftabline'
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
Plug 'amdt/vim-niji'
Plug 'nanotech/jellybeans.vim'
" Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'zchee/deoplete-zsh'
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-vim'
Plug 'vim-scripts/bash-support.vim'
Plug 'tpope/vim-obsession'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'Chiel92/vim-autoformat'
Plug 'metakirby5/codi.vim'
Plug 'easymotion/vim-easymotion'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'


" Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'tpope/vim-sensible'
" Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py ' }

if has('nvim')
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    " Plug 'Vigemus/iron.nvim'
else
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
Plug '~/.vim_runtime/sources_forked/peaksea'
" Plug '~/.vim_runtime/sources_forked/set_tabline'
Plug '~/.vim_runtime/sources_forked/vim-peepopen'
Plug '~/.vim_runtime/sources_forked/vim-irblack-forked'

" Initialize plugin system
call plug#end()
"--------------------------------------------------------------------

if has('win32')
    let g:python3_host_prog='C:\Python37\python'
    set undodir=~/_vim_undo//
endif
let s:path=fnamemodify(resolve(expand('<sfile>:p')), ':h')
map <leader>es :so ~/.vimrc

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
" Automatically save the session when leaving Vim
" autocmd! VimLeave * mksession
" Automatically load the session when entering vim
" autocmd! VimEnter * source ~/Session.vim
set cursorline


set rtp+=/usr/share/powerline/bindings/vim/
set t_Co=256

let maplocalleader=",,"

iabbrev gml mathestics@gmail.com
iabbrev unm carlleonhard
iabbrev wyyx mathestics@163.com
iabbrev pnb 15238723375
iabbrev seperate -----------------------------------------
nmap <leader>Se o------------------BEGIN------------------------------<c-c>0gcc
nmap <leader>SE o==================END================================<c-c>0gcc
nmap <leader>se ojkx,Seojkx,SE2ko ==><c-c>A
nmap <leader>Si :SyntasticToggleMode<cr>
nmap <leader>py 0:.,/^$/ s/^.*: //<cr>

nnoremap nb /-BEGIN<cr>0
nnoremap Nb ?-BEGIN<cr>0
nnoremap ne /=END<cr>$
nnoremap Ne ?=END<cr>$
nnoremap <leader>ds j?-BEGIN<cr>0d/=END<cr>dd
nnoremap <leader>re :e!<cr>

" au BufNewFile * :write
" au FileType vim
inoremap jk <esc>
inoremap <esc> <nop>
nnoremap <leader>? :help 
nnoremap <leader>q :wq<esc>
nnoremap <leader>X :q!<esc>
nnoremap <leader>bb :bd<esc>
nnoremap <leader>BB :bd!<esc>
nnoremap <c-w>v :vsplit<cr>
nnoremap <c-w>s :split<cr>
nnoremap <leader>cd :cd %:h<cr>
nnoremap <leader>bf :BufExplorer<cr>
nnoremap <localleader>P :%!python -m json.tool
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

"enable y to copy/paste selected text
set clipboard^=unnamed,unnamedplus

autocmd filetype lisp,scheme,art setlocal equalprg=~/kit/scmindent.rkt

filetype plugin on
map <leader>ee :e! ~/.vim_runtime/vimrcs/basic.vim <cr>
map <leader>ex :e! ~/.vim_runtime/vimrcs/extended.vim <cr>
map <leader>ep :e! ~/.vim_runtime/vimrcs/plugins_config.vim<cr>
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



" ------------------BEGIN------------------------------
"  ==> pre
colo desert
set sessionoptions+=buffers
" ==================END================================

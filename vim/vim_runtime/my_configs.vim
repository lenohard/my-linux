"--------------------------------------------------------------------
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim_runtime/my_plugins')
" Make sure you use single quotes

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'tommcdo/vim-ninja-feet'

" Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" Plug 'naoyuki1019/vim-autoupload'
Plug 'kshenoy/vim-signature'
Plug 'embear/vim-foldsearch'
Plug 'eshion/vim-sync'
Plug 'skywind3000/asyncrun.vim'
Plug 'voldikss/vim-mma'
Plug 'vimlab/split-term.vim'
Plug 'guns/vim-sexp'
Plug 'wesQ3/vim-windowswap'
Plug 'lervag/vimtex'
Plug 'vim-scripts/paredit.vim'
Plug 'dense-analysis/ale'
Plug 'jpalardy/vim-slime'
Plug 'junegunn/vim-easy-align'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-unimpaired'
Plug 'tomlion/vim-solidity'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/Colorizer'
" Plug 'Shougo/unite.vim'
Plug 'tpope/vim-commentary'
Plug 'chrisbra/Colorizer'
Plug 'mileszs/ack.vim'
Plug 'ap/vim-buftabline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
Plug 'yuttie/comfortable-motion.vim'
" Plug 'vim-scripts/mru.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'wellle/targets.vim'
Plug 'maxbrunsfeld/vim-yankstack'
Plug 'amix/vim-zenroom2'
Plug 'scrooloose/snipmate-snippets'
Plug 'terryma/vim-multiple-cursors'
Plug 'kana/vim-textobj-user'
Plug 'amdt/vim-niji'
Plug 'nanotech/jellybeans.vim'
Plug 'Yggdroot/indentLine'
Plug 'Shougo/echodoc.vim'
Plug 'Shougo/neco-vim'
Plug 'tpope/vim-obsession'
Plug 'xolox/vim-session'
Plug 'xolox/vim-misc'
Plug 'Chiel92/vim-autoformat'
Plug 'metakirby5/codi.vim'
Plug 'easymotion/vim-easymotion'
Plug 'guns/xterm-color-table.vim'
Plug 'ap/vim-css-color'
Plug 'dyng/ctrlsf.vim'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Raimondi/delimitMate'
Plug 'andymass/vim-matchup'
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
Plug 'albfan/vim-breakpts'
Plug 'vim-scripts/genutils'
Plug 'bfredl/nvim-miniyank'
Plug 'tpope/vim-abolish'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'neovimhaskell/haskell-vim'
Plug 'alx741/vim-hindent'
Plug 'camspiers/animate.vim'
Plug 'camspiers/lens.vim'
Plug 'morhetz/gruvbox'


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
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}

if has('nvim')
    Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Vigemus/iron.nvim'
else
    Plug 'Shougo/denite.nvim'
    Plug 'Shougo/deoplete.nvim'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
endif

" Unmanaged plugin (manually installed and updated)
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


if has('gui_running')
    try
        :set gfn=Ubuntu_Mono:h11:cANSI:qDRAFT
    endtry
endif

"---------------
"UI
"---------------
set background=dark
set nohlsearch
set number
set number relativenumber
set nowrap
set fileencodings=gb2312,utf-8,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END


"Automatically save the session when leaving Vim
"autocmd! VimLeave * :mksession!

"Automatically load the session when entering vim
" if filereadable(expand("./Session.vim"))
"     autocmd! VimEnter * if argc() == 0 | source ./Session.vim | endif
" elseif filereadable(expand("~/.vim/sessions/default.vim"))
"     autocmd! VimEnter * if argc() == 0 | source ~/.vim/sessions/default.vim | endif
" endif

if has('nvim')
    augroup TerminalStuff
        au!
        autocmd TermOpen * setlocal nonumber norelativenumber
    augroup END
endif

autocmd BufNewFile,BufRead *.spacemacs set filetype=lisp

set cursorline
set smartcase
set ignorecase
set rtp+=/usr/share/powerline/bindings/vim/
set t_Co=256

let maplocalleader=",,"

iabbrev gml mathestics@gmail.com
iabbrev unm carlleonhard
iabbrev wyyx mathestics@163.com
iabbrev pnb 15238723375

" ------------------BEGIN------------------------------
"   ==>
iabbrev seperate -----------------------------------------
nmap <leader>Se o------------------BEGIN------------------------------<c-c>0gcc
nmap <leader>SE o==================END================================<c-c>0gcc
nmap <leader>se ojkx,Seojkx,SE2ko ==><c-c>A
nmap <leader>py 0:.,/^$/ s/^.*: //<cr>
nnoremap <leader>ds j?-BEGIN<cr>0d/=END<cr>dd
nnoremap <leader>re :e!<cr>
" ==================END================================

nnoremap n( ya(
nnoremap n{ ya{
nnoremap n[ ya[
nnoremap nt yat
nnoremap np yap
nnoremap N( ya(%
nnoremap N{ ya{%
nnoremap N[ ya[%
nnoremap Nt yat%
nnoremap <leader>zf :set foldmethod=indent<cr>
nnoremap <leader>zF :set foldmethod=manual<cr>
tnoremap kj <c-\><c-n>
tnoremap jk <c-\><c-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

noremap <leader>P o<esc>p
nnoremap zz :Z
inoremap jk <esc>
inoremap kj <esc>
inoremap <esc> <nop>
nnoremap <leader>? :help 
nnoremap <leader>qw :bp<bar>sp<bar>bn<bar>bd<CR>
nnoremap <leader>qq :wq<esc>
nnoremap <leader>qa :wqa<esc>
nnoremap <leader>X :q!<esc>
nnoremap <leader>bb :bd<esc>
nnoremap <leader>BB :bd!<esc>
nnoremap <c-w>v :vsplit<cr>
nnoremap <c-w>s :split<cr>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
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
nnoremap <cr> <esc>
"enable y to copy/paste selected text
set clipboard^=unnamed,unnamedplus

nnoremap <leader>M :<C-u>marks<CR>

set scrolloff=2

"use this script to help write lisp-like () 
" autocmd filetype lisp,scheme,art setlocal equalprg=~/kit/scmindent.rkt

" au BufRead,BufNewFile,BufNew *.hss setl ft=haskell.script
" autocmd filetype lisp,scheme,art setlocal equalprg=~/kit/scmindent.rkt

augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

map <leader>ee :e! ~/.vim_runtime/vimrcs/basic.vim <cr>
map <leader>ex :e! ~/.vim_runtime/vimrcs/extended.vim <cr>
map <leader>ep :e! ~/.vim_runtime/vimrcs/plugins_config.vim<cr>
set ssop-=options    " do not store global and local values in a session
set ssop-=folds      " do not store folds
set ssop-=buffers
"open new buffer instead new tab when open file with quickfix
set switchbuf-=newtab

set wrap
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set tags=./tags,tags;

"remove trailing space
noremap <leader>rm :%s/\([^ ]\) *$/\1/<cr>

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
set background=dark
colorscheme jellybeans
set sessionoptions+=buffers
" ==================END================================


" ------------------BEGIN------------------------------
"   ==> Haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

let g:haskell_indent_if = 3
let g:haskell_indent_do = 3
" ==================END================================



" ------------------BEGIN------------------------------
"   ==>
"   jsonc file comment hightlight settting
autocmd FileType json syntax match Comment +\/\/.\+$+

" ==================END================================


" ------------------BEGIN------------------------------
"   ==> Len
let g:lens#disabled = 0
" ==================END================================



" ------------------BEGIN------------------------------
"   ==> package.yaml haskell
autocmd BufWritePost package.yaml call Hpack()

function Hpack()
  let err = system('hpack ' . expand('%'))
  if v:shell_error
    echo err
  endif
endfunction
" ==================END================================

" Vim Configuration File
" Author: Carl Leonhard
" Last Modified: 2024-08-29

" ============================================================================
" Plugin Management
" ============================================================================
" Plugin management is now handled by lazy.nvim in lua/plugins/init.lua

" ============================================================================
" General Settings
" ============================================================================
set nohlsearch
set number relativenumber
set nowrap
set cursorline
set smartcase
set ignorecase
set clipboard+=unnamed,unnamedplus
set scrolloff=2
set conceallevel=2
set ssop-=options
set ssop-=folds
set ssop-=buffers
set switchbuf-=newtab
set wrap
set tags=./tags,tags;

" File encoding
set fileencodings=gb2312,utf-8,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030

" Color scheme
colorscheme jellybeans
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE

" ============================================================================
" Key Mappings
" ============================================================================
let mapleader = ","
let maplocalleader = ",,"

" Normal mode mappings
nnoremap <leader>W :wq!<esc>
nnoremap <leader>X :q!<esc>
nnoremap <leader>bb :bd<esc>
nnoremap <leader>BB :bd!<esc>
nnoremap <c-w>v :vsplit<cr>
nnoremap <c-w>s :split<cr>
nnoremap <Leader>s :%s/\<<C-r><C-w>\>/
nnoremap <leader>cd :cd %:h<cr>
nnoremap <leader>so gg=G<c-o>
nnoremap <leader>M :<C-u>marks<CR>
nnoremap <silent> <F8> :let mycurf=expand("<cfile>")<cr><c-w>p:execute("e ".mycurf)<cr>
nmap <c-s> :w<cr>

" Insert mode mappings
inoremap jk <esc>
inoremap kj <esc>
inoremap <esc> <nop>

" Terminal mode mappings
tnoremap jk <c-\><c-n>
tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l

" Buffer navigation
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
nnoremap <c-6> :buffer #<CR>

" Fast editing of vimrc
map <leader>ee :e! ~/.vim_runtime/my_configs.vim <cr>
map <leader>ea :e! ~/.vim_runtime/vimrcs/basic.vim <cr>
map <leader>ex :e! ~/.vim_runtime/vimrcs/extended.vim <cr>
map <leader>ep :e! ~/.vim_runtime/lua/plugins/plugins.lua <cr>
" map <leader>em :e! ~/note.md<cr>

" ============================================================================
" Plugin Configurations
" ============================================================================

" NERDTree
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>

" FZF
nnoremap <silent> <c-p> :Files<CR>
nnoremap <silent> <c-[> :Buffers<CR>
nnoremap <silent> <c-]> :History<CR>
nnoremap <silent> <leader>A :Windows<CR>
nnoremap <silent> <leader>; :BLines<CR>
nnoremap <silent> <leader>o :BTags<CR>
nnoremap <silent> <leader>O :Tags<CR>
nnoremap <silent> <leader>? :GFiles<CR>
nnoremap <silent> <leader>/ :execute 'Ag ' . input('Ag/')<CR>

" Ag (Silver Searcher)
if executable('ag')
    let g:ctrlp_use_caching = 0
endif

" LSP keybindings
nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> <leader>rn <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> [g <cmd>lua vim.diagnostic.goto_prev()<CR>
nnoremap <silent> ]g <cmd>lua vim.diagnostic.goto_next()<CR>

" Telescope keybindings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Fugitive
nnoremap <leader>ge :Gvsplit HEAD:%<CR>
nnoremap <leader>gs :Gedit HEAD:% \| vert diffsplit %<CR>

" Rainbow Parentheses
augroup rainbow_lisp
    autocmd!
    autocmd FileType lisp,clojure,scheme RainbowParentheses
augroup END

" ============================================================================
" Custom Functions
" ============================================================================

" Search functions
function! SearchWordWithAg()
    execute 'Ag' expand('<cword>')
endfunction

function! SearchVisualSelectionWithAg() range
    let old_reg = getreg('"')
    let old_regtype = getregtype('"')
    let old_clipboard = &clipboard
    set clipboard&
    normal! ""gvy
    let selection = getreg('"')
    call setreg('"', old_reg, old_regtype)
    let &clipboard = old_clipboard
    execute 'Ag' selection
endfunction

function! SearchWithAgInDirectory(...)
    call fzf#vim#ag(join(a:000[1:], ' '), extend({'dir': a:1}, g:fzf#vim#default_layout))
endfunction
command! -nargs=+ -complete=dir AgIn call SearchWithAgInDirectory(<f-args>)

" Hpack function for Haskell
function! Hpack()
    let err = system('hpack ' . expand('%'))
    if v:shell_error
        echo err
    endif
endfunction

" ============================================================================
" Auto Commands
" ============================================================================

" Relative line numbers
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave * if &number | set relativenumber | endif
    autocmd BufLeave,FocusLost,InsertEnter * set norelativenumber
augroup END

" Terminal settings
if has('nvim')
    augroup TerminalStuff
        au!
        autocmd TermOpen * setlocal nonumber norelativenumber
    augroup END
endif

" File type specific settings
autocmd BufNewFile,BufRead *.spacemacs set filetype=lisp
autocmd FileType json syntax match Comment +\/\/.\+$+
autocmd BufWritePost package.yaml call Hpack()

" WSL specific settings
let s:clip = '/mnt/c/Windows/System32/clip.exe'
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

" ============================================================================
" Platform Specific Settings
" ============================================================================

if has('win32')
    let g:python3_host_prog='C:\Python37\python'
    set undodir=~/_vim_undo//
endif

if has('gui_running')
    try
        set transparency=25
    catch
    endtry
endif

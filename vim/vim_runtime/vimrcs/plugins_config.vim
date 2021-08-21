"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Important:
"       This requries that you install https://github.com/amix/vimrc !
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
let g:yankstack_yank_keys = ['y', 'd']

nmap <c-[> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste


""""""""""""""""""""""""""""""
" => CTRL-P
""""""""""""""""""""""""""""""
let g:ctrlp_working_path_mode = 0

let g:ctrlp_map = ''
map <leader>mm :CtrlPMRUFiles<cr>
" map <c-b> :CtrlPBuffer<cr>
nnoremap <leader>j :CtrlPMixed<CR>

let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = 'node_modules\|^\.DS_Store\|^\.git\|^\.coffee'

if executable('ag')
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    " HatTip: http://robots.thoughtbot.com/faster-grepping-in-vim and
    " @ethanmuller
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif

""""""""""""""""""""""""""""""
" => ZenCoding
""""""""""""""""""""""""""""""
" Enable all functions in all modes
let g:user_zen_mode='a'



""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Nerd Tree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "left"
let NERDTreeShowHidden=0
let g:NERDTreeMinmalUI=1
let g:NERDTreeHightCursorline=0
let g:NERDTreeChDirMode=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeShowLineNumbers=0
let NERDTreeShowHidden=1
" let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>
map <leader>nc :NERDTreeCWD<cr>
autocmd FileType nerdtree setlocal nocursorline
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType")
            \&& b:NERDTreeType == "primary") | q | endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-multiple-cursors
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:multi_cursor_use_default_mapping=0

" Default mapping
let g:multi_cursor_start_word_key      = '<C-s>'
let g:multi_cursor_select_all_word_key = '<A-s>'
let g:multi_cursor_start_key           = 'g<C-s>'
let g:multi_cursor_select_all_key      = 'g<A-s>'
let g:multi_cursor_next_key            = '<C-s>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => surround.vim config
" Annotate strings with gettext
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap Si S(i_<esc>f)
au FileType mako vmap Si S"i${ _(<esc>2f"a) }<esc>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vimroom
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:goyo_width=100
let g:goyo_margin_top = 2
let g:goyo_margin_bottom = 2
nnoremap <silent> <leader>z :Goyo<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:go_fmt_command = "goimports"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Git gutter (Git diff)
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:gitgutter_enabled=0
nnoremap <silent> <leader>d :GitGutterToggle<cr>

" -----------------------------------------------------
let g:GitGutterEnable=1
" -----------------------------------------------------

" airline config
" -----------------------------------------------------
let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#formatter='unique_tail_improved'
" let g:airline#extensions#tabline#overflow_marker='...'
" let g:airline#extensions#tabline#buffer_idx_mode = 1
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline#extensions#tabline#buffer_nr_show = 1
" let g:airline#extensions#tabline#tabs_label = 't'
" let g:airline#extensions#tabline#buffers_label = 'b'

" let g:airline#extensions#coc#enabled = 1
" let airline#extensions#coc#error_symbol = 'E:'
" -----------------------------------------------------


" ------------------BEGIN------------------------------
"  ==> python specifc commands

augroup python
    autocmd!
    au FileType python iabbrev pdb import ipdb;ipdb.set_trace()
augroup END

" ==================END================================


" ------------------BEGIN------------------------------
"  ==> buftabline
let g:buftabline_show =1
let g:buftabline_numbers=1
let g:buftabline_indicators= 1
" let g:buftabline_separators= off
" ==================END================================

" ------------------BEGIN------------------------------
"  ==> vim-session
let g:session_autoload = 'yes'
let g:session_autosave = 'no'
set sessionoptions+=buffers
" ==================END================================

" ------------------BEGIN------------------------------
"   ==>vim-slime
if has('win32')
    let g:slime_target='conemu'
else
    let g:slime_target = "tmux"
endif
let g:slime_python_ipython=1
nmap <c-c>l <Plug>SlimeLineSend
nmap <c-c>c <Plug>SlimeMotionSend
let g:slime_haskell_ghci_add_let = 0
" ==================END================================


" ------------------BEGIN------------------------------
"   ==>ale
let g:ale_lint_on_text_changed = 'never'
" let g:ale_sign_column_always = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '▲'

highlight link ALEWarningSign String
highlight link ALEErrorSign Title

nmap <silent> <leader>a <Plug>(ale_next_wrap)
nnoremap ]l :ALENextWrap<CR>
nnoremap [l :ALEPreviousWrap<CR>

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

let g:airline_theme='random'
" let g:airline_theme='base16_nord'
" let g:airline_theme='base16_flat'

" Disabling highlighting
let g:ale_set_highlights = 0

" Only run linting when saving the file
let g:ale_lint_on_enter = 0
let g:ale_linters = {
            \   'javascript': ['jshint'],
            \   'python': ['flake8'],
            \   'go': ['go', 'golint', 'errcheck'],
            \   'haskell': ['hdevtools', 'hlint', 'ghc-mod']
            \}
" ==================END================================

" ------------------BEGIN------------------------------
"   ==>CtrlSF
nmap     <leader>ff <Plug>CtrlSFPrompt
vmap     <leader>ff <Plug>CtrlSFVwordPath
vmap     <leader>fF <Plug>CtrlSFVwordExec
nmap     <leader>fn <Plug>CtrlSFCwordPath
nmap     <leader>fp <Plug>CtrlSFPwordPath
nnoremap <leader>fo :CtrlSFOpen<CR>
nnoremap <leader>ft :CtrlSFToggle<CR>
inoremap <leader>ft <Esc>:CtrlSFToggle<CR>
" ==================END================================



" ------------------BEGIN------------------------------
"   ==>vim-mma
let g:mma_candy = 1

" ==================END================================

" ------------------BEGIN------------------------------
"   ==>split-term.vim
set splitright
set splitbelow
" ==================END================================


" ------------------BEGIN------------------------------
"   ==>coc.nvim
set hidden
set updatetime=300

set shortmess+=c
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

command! -nargs=0 Prettier :CocCommand prettier.formatFile
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
nnoremap <silent> <space>m  :<C-u>CocList marketplace<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>)

nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>


let g:coc_global_extensions = [ 'coc-tsserver', 'coc-json' ]
" ==================END================================


" ------------------BEGIN------------------------------
"   ==>vim-hardtime
let g:hardtime_default_on = 0
" ==================END================================

" ------------------BEGIN------------------------------
"   ==>Unite
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
if executable('pt')
    let g:unite_source_grep_command = 'pt'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor'
    let g:unite_source_grep_recursive_opt = ''
    let g:unite_source_grep_encoding = 'utf-8'
endif
" ==================END================================


" ------------------BEGIN------------------------------
"   ==>MatchUp
let g:matchup_transmute_enabled = 1
let g:matchup_matchparen_deferred = 1
" ==================END================================


" ------------------BEGIN------------------------------
"   ==> nerdcommenter
" nerdcommenter
" let g:SynDebug = 0
" map <leader>cd :call ToggleDebug()<CR>
" imap <leader>ci <SPACE><BS><ESC>:call Comment('Insert')<cr>
" map <leader>ca :call Comment('AltDelims')<cr>
" xmap <leader>c$ :call Comment('ToEOL', 'x')<cr>
" nmap <leader>c$ :call Comment('ToEOL', 'n')<cr>
" xmap <leader>cA :call Comment('Append', 'x')<cr>
" nmap <leader>cA :call Comment('Append', 'n')<cr>
" xmap <leader>cs :call Comment('Sexy', 'x')<cr>
" nmap <leader>cs :call Comment('Sexy', 'n')<cr>
" xmap <leader>ci :call Comment('Invert', 'x')<cr>
" nmap <leader>ci :call Comment('Invert', 'n')<cr>
" xmap <leader>cm :call Comment('Minimal', 'x')<cr>
" nmap <leader>cm :call Comment('Minimal', 'n')<cr>
" xmap <leader>c<space> :call Comment('Toggle', 'x')<cr>
" nmap <leader>c<space> :call Comment('Toggle', 'n')<cr>
" xmap <leader>cl :call Comment('AlignLeft', 'x')<cr>
" nmap <leader>cl :call Comment('AlignLeft', 'n')<cr>
" xmap <leader>cb :call Comment('AlignBoth', 'x')<cr>
" nmap <leader>cb :call Comment('AlignBoth', 'n')<cr>
" xmap <leader>cc :call Comment('Comment', 'x')<cr>
" nmap <leader>cc :call Comment('Comment', 'n')<cr>
" xmap <leader>cn :call Comment('Nested', 'x')<cr>
" nmap <leader>cn :call Comment('Nested', 'n')<cr>
" xmap <leader>cu :call Comment('Uncomment', 'x')<cr>
" nmap <leader>cu :call Comment('Uncomment', 'n')<cr>
" xmap <leader>cy :call Comment('Yank', 'x')<cr>
" nmap <leader>cy :call Comment('Yank', 'n')<cr>
" let g:NERDCreateDefaultMappings=0
" let g:NERDSpaceDelims=1
" let g:NERDCustomDelimiters = {'pug': { 'left': '//-', 'leftAlt': '//' }}
" function! ToggleDebug()
"   let g:SynDebug = !g:SynDebug
"   echo 'Syntax Debug Mode: '.g:SynDebug
" endfunction
" function! Comment(...) range
"   let mode = a:0
"   let type = a:1
"   let ft = &ft
"   let stack = synstack(line('.'), col('.'))
"   if g:SynDebug
"     echo ft
"     echo map(stack, 'synIDattr(v:val, "name")')
"   endif
"   if ft == 'vue'
"     if len(stack) > 0
"       let syn = synIDattr((stack)[0], 'name')
"       if len(syn) > 0
"         let syn = tolower(syn)
"         if g:SynDebug
"           echo syn
"         endif
"         exe 'setf '.syn
"       endif
"     endif
"   endif
"   if type == 'AltDelims'
"     exe "normal \<plug>NERDCommenterAltDelims"
"   elseif type == 'Insert'
"     call NERDComment('i', "insert")
"   else
"     exe 'silent '.a:firstline.','.a:lastline.'call NERDComment(mode, type)'
"   endif
"   if g:SynDebug
"     echo &ft
"   endif
"   exe "setf ".ft
" endfunction

let g:ft = ''
function! NERDCommenter_before()
  if &ft == 'vue'
    let g:ft = 'vue'
    let stack = synstack(line('.'), col('.'))
    if len(stack) > 0
      let syn = synIDattr((stack)[0], 'name')
      if len(syn) > 0
        exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
      endif
    endif
  endif
endfunction
function! NERDCommenter_after()
  if g:ft == 'vue'
    setf vue
    let g:ft = ''
  endif
endfunction"

" ==================END================================



" ------------------BEGIN------------------------------
"   ==>fzf
nnoremap <silent><leader>B :Buffers<CR>
nnoremap <C-g> :Ag<Cr>
nnoremap <C-p> :GFiles<Cr>
" ==================END================================

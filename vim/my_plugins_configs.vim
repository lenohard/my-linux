" -----------------------------------------------------
let g:GitGutterEnable=1
" -----------------------------------------------------

" airline config
" -----------------------------------------------------
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
" -----------------------------------------------------


" -----------------------------------------------------
let g:syntastic_check_on_wq = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:ackprg = 'ag --vimgrep --smart-case'
" -----------------------------------------------------

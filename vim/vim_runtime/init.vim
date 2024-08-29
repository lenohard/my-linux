set runtimepath+=~/.vim_runtime

lua require('config.lazy')
source ~/.vim_runtime/vimrcs/basic.vim
source ~/.vim_runtime/vimrcs/filetypes.vim
source ~/.vim_runtime/vimrcs/plugins_config.vim
source ~/.vim_runtime/vimrcs/extended.vim

let &packpath=&runtimepath

try
source ~/.vim_runtime/my_configs.vim
lua require('config.init')
catch
endtry

if @% == ""
  bd
endif

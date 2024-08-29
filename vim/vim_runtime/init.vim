set runtimepath+=~/.config/nvim

lua require('config.lazy')
source ~/.config/nvim/vimrcs/basic.vim
source ~/.config/nvim/vimrcs/filetypes.vim
source ~/.config/nvim/vimrcs/plugins_config.vim
source ~/.config/nvim/vimrcs/extended.vim

let &packpath=&runtimepath

try
source ~/.config/nvim/my_configs.vim
lua require('config.init')
catch
endtry

if @% == ""
  bd
endif

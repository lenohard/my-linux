
set runtimepath+=~/.config/nvim

source ~/.config/nvim/vimrcs/basic.vim
source ~/.config/nvim/vimrcs/filetypes.vim
source ~/.config/nvim/vimrcs/plugins_config.vim
source ~/.config/nvim/vimrcs/extended.vim

let &packpath=&runtimepath

try
source ~/.config/nvim/my_configs.vim
catch
endtry

REM requirements 1:pip install pynvim 2:python2/3 3:vim8.1 4:nvim 

REM get current dir and decide  $root/vim/vim_runtime
SET root=%~dp0..
mkline /D %userprofiler%/_vimrc %root%/vim/vim_runtime/vimrc
mkline /D %userprofiler%/.vim_runtime %root%/vim/vim_runtime
mkline /D %userprofiler%/AppData/Local/nvim  %root%/vim/vim_runtime
PAUSE

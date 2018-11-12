#!/bin/bash
cd ~
if [[ -f .vimrc && -f .vimrcori ]]
then
    mv .vimrc .vimrctmp
    mv .vimrcori .vimrc
    mv .vimrctmp .vimrcori
fi

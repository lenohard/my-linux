#!/bin/bash

#git clone https://github.com/gpakosz/.tmux.git ~/
mkdir ~/.tmux
cp ../tmux.conf ~/.tmux/.tmux.conf
ln -s  .tmux/.tmux.conf ~/.tmux.conf

cp ../tmux/tmux.conf.local ~/.tmux.conf.local

cp ../tmux/plugins ~/.tmux/ -r

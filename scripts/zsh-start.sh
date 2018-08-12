#! /bin/bash

../zsh/install.sh

echo "start copying the zshrc file"
if [[ -e ~/.zshrc ]]; then
    echo "the existing zshrc will be mv to .zshrc_bk"
    mv ~/.zshrc ~/.zshrc_bk
fi
cp ../zsh/zshrc ~/.zshrc

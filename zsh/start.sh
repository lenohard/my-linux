#! /bin/bash

./install.sh

echo "start copying the zshrc file"
if [[ -e ~/.zshrc ]]; then
    echo "he existing zshrc will be mv to .zshrc_bk"
    mv ~/.zshrc ~/.zshrc_bk
fi
cp ./zshrc ~/.zshrc

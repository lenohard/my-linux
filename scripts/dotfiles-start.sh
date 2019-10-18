#! /bin/bash
CURT=$(dirname $(readlink -f $0))
ROOT=$(readlink -f $(dirname "$CURT"))
echo root dir is \"$ROOT\"


if [[ -e ~/.inputrc || -h ~/.inputrc ]]; then
	echo "the existing zshrc will be mv to .zshrc_bk"
	mv ~/.inputrc ~/.inputrc_bk
fi
ln -s $ROOT/zsh/inputrc ~/.inputrc
if [[ -e ~/.ssh || -h ~/.ssh ]]; then
	echo "the existing zshrc will be mv to .zshrc_bk"
	mv ~/.ssh ~/.ssh_bk
fi
ln -s $ROOT/zsh/ssh ~/.ssh
if [[ -e ~/.racketrc || -h ~/.racketrc ]]; then
	echo "the existing racketrc will be mv to .zshrc_bk"
    mv ~/.racketrc ~/.racketrc_bk
fi
ln -s $ROOT/zsh/racketrc ~/.racketrc

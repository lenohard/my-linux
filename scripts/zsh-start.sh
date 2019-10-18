#! /bin/bash
CURT=$(dirname $(readlink -f $0))
ROOT=$(readlink -f $(dirname "$CURT"))
echo root dir is \"$ROOT\"

bash $ROOT/zsh/install.sh
if [[ -e ~/.zshrc || -h ~/.zshrc ]]; then
	echo "the existing zshrc will be mv to .zshrc_bk"
	mv ~/.zshrc ~/.zshrc_bk
fi
bash $ROOT/scripts/switch_zsh antigen

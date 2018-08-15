#!/bin/bash
path="`pwd`"
if [[ -z $1 ]]
then
    echo "Usage: tpm <the name of plugin1>  <....2>  ....." 2>&1
    exit $E_NORRGS
fi

if [[ -z $TMUX_PATH ]]
then
    DIR="/home/carl/.tmux"
else
    DIR="$TMUX_PATH"
fi
cd "$DIR"

if   [[ !  -e plugins  ]]
then
    mkdir plugins
fi
cd plugins

for plg in "$@"
do
    git clone https://github.com/tmux-plugins/"$plg"
done

cd "$path"

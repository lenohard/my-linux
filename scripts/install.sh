#!/bin/bash
set -e
[[ -n $1 ]] || ( echo "Usage: install [vim] [tmux] [zsh]";exit )

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR
for app in $@;do
    set -x
    source ./$app-start.sh
    set +x
done


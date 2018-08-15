#!/bin/bash
PRO_PATH="$( cd ../"$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

set -e
set -x
cp $PRO_PATH/git/gitignore_global ~/.gitignore_global
cp $PRO_PATH/git/gitconfig ~/.gitconfig


#!/bin/bash
cwd="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR


if [ -d ~/kit ]; then
    rm ~/kit -rf
fi
ln -s $(dirname $PWD)/kit ~/kit
echo "creating link  ok"

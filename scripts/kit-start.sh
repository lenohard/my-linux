#!/bin/bash
cwd="$(pwd)"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
cd $DIR

if [ -d ~/kit ]; then
    rm ~/kit -rf
fi
ln -s $(dirname $PWD)/kit ~/kit
echo "creating link  ok"

# ------------------BEGIN------------------------------
# ==> fasd
if !  which fasd 2>&1 > /dev/null ;
then
    mkdir tmp_fasd
    git clone https://github.com/clvv/fasd.git tmp_fasd
    cd tmp_fasd
    sudo make install
    cd ../..; rm -rf tmp_fasd 
fi
# ==================END================================

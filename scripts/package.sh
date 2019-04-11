#!/bin/bash -

set -o nounset                              # Treat unset variables as an error
OS="$(lsb_release -is)"
SOURCE_UBUNTU='# 默认注释了源码镜像以提高 apt update 速度，如有需要可自行取消注释
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-updates main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-security main restricted universe multiverse

# 预发布软件源，不建议启用
# deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse
# deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ bionic-proposed main restricted universe multiverse'

MIRROR_INFO="your origin sourcelist has been backup, and replaced with tsinghua mirror"
APT_PACKAGES="fasd tmux python3 ack htop node ranger neovim"
if [[ $OS == "CentOS" ]]
then
    echo "CentOS";



elif [[ $OS == "Ubuntu" ]]
then
    echo "Your OS is Ubuntu";
    sudo mv /etc/apt/sources.list /etc/apt/source.list.bk
    echo $SOURCE_UBUNTU > /etc/apt/sources.list
    echo $MIRROR_INFO
    sudo apt-get install python3 python3-pip
    pip3 install pip -U
    pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    pip install pip -U
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
    sudo add-apt-repository ppa:aacebedo/fasd
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update && sudo apt-get install $apt-packages
elif [[ $OS == "ArchLinux" ]]
then
    echo "Your OS is Archlinux";
else
    echo "Unsupport";
fi



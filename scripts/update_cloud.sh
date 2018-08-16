#! /bin/bash
set -e
if [[ -z $1 ]];then
    echo "Usage: udpate_cloud.sh all|[vim][tmux][....]"
    exit
fi

PRO_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}"; cd .. )" >/dev/null && pwd )"

if [[ $1 = "all" ]];then
    set -- "tmux" "vim" "hosts" "git" "zsh"
fi

for para in "$@"
do
    case "${para^^}" in
        TMUX)
            set -x
            cp ~/.tmux.conf.local $PRO_PATH/tmux/tmux.conf.local
            cp ~/.tmux/.tmux.conf $PRO_PATH/tmux/tmux.conf
            set +x
            ;;
        VIM)
            set -x
            cp ~/.vim_runtime/my_configs.vim $PRO_PATH/vim/my_configs.vim
            set +x
            ;;
        GIT)
            set -x
            cp ~/.gitconfig ~/.gitignore_global $PRO_PATH/git/
            set +x
            ;;
        HOSTS)
            set -x
            sudo cp /etc/hosts $PRO_PATH/hosts/hosts
            set +x
            ;;
        ZSH)
            set -x
            cp ~/.zshrc $PRO_PATH/zsh/zshrc
            set +x
            ;;
    esac
done



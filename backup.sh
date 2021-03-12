#!/bin/bash

OS="$(uname -s)"
case "${OS}" in
    Darwin*)
        cp ${HOME}/.{vimrc,basic.vimrc,plug.vimrc} ./
        cp ${HOME}/.gitignore_global ./
        cp ${HOME}/.{zshrc,zshenv,functions.zsh} ./
        cp ${HOME}/.tmux.conf ./

        # Remove personal info in git-config file
        awk '!/name = |email = |signingkey = |essethon/' ${HOME}/.gitconfig > ./.gitconfig
        ;;
    Linux*)
        cp ${HOME}/.zshrc ./.zshrc-linux-simple
        ;;
    *)
        echo "Unknown OS: ${OS}"
esac



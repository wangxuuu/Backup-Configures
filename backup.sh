#!/bin/bash

cp ${HOME}/.{vimrc,basic.vimrc,plug.vimrc} ./
cp ${HOME}/.gitignore_global ./
cp ${HOME}/.{zshrc,zsh_functions} ./

# Remove personal info in git-config file
awk '!/name = |email = |signingkey = |essethon/' ${HOME}/.gitconfig > ./.gitconfig

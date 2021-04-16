#!/usr/bin/env zsh

cp ./.functions.zsh ~/.functions.zsh
cp ./.zshenv ~/.zshenv
cp ./.vimrc ~/.vimrc
cp ./.basic.vimrc ~/.basic.vimrc
cp ./.plug.vimrc ~/.plug.vimrc
cp ./.tmux.conf ~/.tmux.conf

# echo 'Please set gitconfig by'
# echo '  git config --global user.name <your name>'
# echo '  git config --global user.email <your email>'

os=`uname`

echo -n "Select zsh theme: [1] p10k [2] spaceship (default [1]): "
read theme
case $theme in
2)
    echo "Using Spaceship-prompt."
    cp ./.zshrc.nogui.spaceship.zsh ${HOME}/.zshrc
    case $os in
    Darwin|FreeBSD)
        echo "Using BSD style config files."
        cp ./.alias.bsd.zsh ${HOME}/.alias.zsh;;
    Linux)
        echo "Using GNU stype config files."
        cp ./.alias.gnu.zsh ${HOME}/.alias.zsh;;
    *)
        echo "Unsupported Operating System. Exiting."
        exit 1;;
    esac
    ;;
*)
    echo "Using Powerlevel10k"
    cp ./.zshrc.nogui.p10k.zsh ${HOME}/.zshrc
    case $os in
    Darwin|FreeBSD)
        echo "Using BSD style config files."
        cp ./.alias.bsd.zsh ${HOME}/.alias.zsh;;
    Linux)
        echo "Using GNU stype config files."
        cp ./.alias.gnu.zsh ${HOME}/.alias.zsh;;
    *)
        echo "Unsupported Operating System. Exiting."
        exit 1;;
    esac
    ;;
esac

gitconfig() {
    echo -n "
===================================
      * Git Configuration *
-----------------------------------
Please input Git Username: "

    read username

    echo -n "
-----------------------------------
Please input Git Email: "

    read email

    echo -n "
-----------------------------------
Done!
===================================
"

    git config --global user.name "${username}"
    git config --global user.email "${email}"
}

# Read git config
git_username=$(git config --global user.name)
git_email=$(git config --global user.email)
cp ./.gitconfig ~/.gitconfig

if [ -z "$git_username" ]; then
    gitconfig
else
    git config --global user.name ${git_username}
    git config --global user.email ${git_email}
fi

echo -n "

Auto-sign commits when using git? [Y/n]:
"

read sign
case $sign in
n|N)
    git config --global commit.gpgsign false
    ;;
*)
    git config --global commit.gpgsign true
    git config --global gpg.program $(which gpg)
    ;;
esac

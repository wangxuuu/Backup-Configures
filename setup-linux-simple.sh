cp ./.zshrc-linux-simple ~/.zshrc
cp ./.zsh_functions ~/.zsh_functions
cp ./.vimrc ~/.vimrc
cp ./.basic.vimrc ~/.basic.vimrc
# cp ./.plug.vimrc ~/.plug.vimrc
cp ./.gitconfig ~/.gitconfig
cp ./.tmux.conf ~/.tmux.conf

# echo 'Please set gitconfig by'
# echo '  git config --global user.name <your name>'
# echo '  git config --global user.email <your email>'

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

gitconfig

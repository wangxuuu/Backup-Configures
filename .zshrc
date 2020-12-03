
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk

# Load oh-my-zsh git library and plugin
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
# zinit snippet OMZP::osx

zinit light-mode for \
    zsh-users/zsh-autosuggestions \
    zdharma/history-search-multi-word \
    denysdovhan/spaceship-prompt # \
    # laggardkernel/zsh-thefuck

zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
    zsh-users/zsh-completions
zinit wait lucid atinit"zicompinit; zicdreplay" blockf for \
    zdharma/fast-syntax-highlighting


# zsh-completions settings
# allow autocomplete from the middle of file/folder name
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# autoload -U compinit && compinit
unsetopt LIST_BEEP  # turn off auto completion beep

# Spaceship-Prompt options
# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md
export SPACESHIP_DOCKER_SHOW=false

# GPG Agent
# ---------
# export GPG_TTY="$(tty)"
# export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
# gpg-connect-agent updatestartuptty /bye > /dev/null
# gpgconf --launch gpg-agent
# export PATH="/usr/local/sbin:$PATH"

# Secretive macOS
# ---------------
export SSH_AUTH_SOCK=${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# export SSH_AUTH_SOCK=${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# pyenv
# -----
eval "$(pyenv init - --no-rehash)"
eval "$(pyenv virtualenv-init - --no-rehash)"

# rbenv
# -----
# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.
# To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following
# to your ~/.zshrc:
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

eval "$(rbenv init - --no-rehash)"

# Perl
# ----
# By default non-brewed cpan modules are installed to the Cellar. If you wish
# for your modules to persist across updates we recommend using `local::lib`.

# You can set that up like this:
# PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"

# Just for fun
# ------------
alias please="sudo"

alias ls="ls -G"
alias ll="ls -aGl"
alias lh="ls -aGhl"
alias la="ls -AG"

# JDK environment
# ---------------
export JAVA_HOME=/Library/Java/JavaVirtualMachines/adoptopenjdk-14.jdk/Contents/Home

# iTerm2 shell integration
# ------------------------
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true

function iterm2_print_user_vars() {
	iterm2_set_user_var proxy_status $([ -z "$ALL_PROXY" ] || echo "📡")
}

# Include user functions
if [ -f ~/.zsh_functions ]; then
    source ~/.zsh_functions
fi

# Credentials, e.g. Homebrew Github API Token
if [ -f ~/.credentials ]; then
    source ~/.credentials
fi

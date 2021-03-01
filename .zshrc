
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

# Defer slow commands
zinit light romkatv/zsh-defer

# Load oh-my-zsh git library and plugin
zsh-defer zinit snippet OMZL::git.zsh
zsh-defer zinit snippet OMZP::git
zsh-defer zinit snippet OMZP::osx

zinit light-mode for \
    zsh-users/zsh-autosuggestions \
    denysdovhan/spaceship-prompt \
    zdharma/history-search-multi-word \
    # laggardkernel/zsh-thefuck

zsh-defer zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
    zsh-users/zsh-completions
zsh-defer zinit wait lucid atinit"zicompinit; zicdreplay" blockf for \
    zdharma/fast-syntax-highlighting

# zsh-completions settings
# allow autocomplete from the middle of file/folder name
zsh-defer zstyle ':completion:*' completer _complete
zsh-defer zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' '+l:|=* r:|=*'
# autoload -U compinit && compinit
unsetopt LIST_BEEP  # turn off auto completion beep

# Spaceship-Prompt options
# https://github.com/denysdovhan/spaceship-prompt/blob/master/docs/Options.md
export SPACESHIP_DOCKER_SHOW=false

# GPG Agent
# ---------
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
zsh-defer -c 'gpg-connect-agent updatestartuptty /bye > /dev/null'
# gpgconf --launch gpg-agent
# export PATH="/usr/local/sbin:$PATH"

# Secretive macOS
# ---------------
# export SSH_AUTH_SOCK=${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# export SSH_AUTH_SOCK=${HOME}/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# pyenv
# -----
zsh-defer -c 'eval "$(pyenv init - --no-rehash)"'
zsh-defer -c 'eval "$(pyenv virtualenv-init - --no-rehash)"'

# rbenv
# -----
# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed and these are never upgraded.
# To link Rubies to Homebrew's OpenSSL 1.1 (which is upgraded) add the following
# to your ~/.zshrc:
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

zsh-defer -c 'eval "$(rbenv init - --no-rehash)"'

# Perl
# ----
# By default non-brewed cpan modules are installed to the Cellar. If you wish
# for your modules to persist across updates we recommend using `local::lib`.

# You can set that up like this:
# PERL_MM_OPT="INSTALL_BASE=$HOME/perl5" cpan local::lib
zsh-defer -c 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"'

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
zsh-defer -c 'test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true'

function iterm2_print_user_vars() {
	iterm2_set_user_var proxy_status $([ -z "$ALL_PROXY" ] || echo "📡")
}

# Google Cloud SDK
source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
zsh-defer -c 'source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"'

# Include user functions
if [ -f ~/.zsh_functions ]; then
    source ~/.zsh_functions
fi

# Credentials, e.g. Homebrew Github API Token
if [ -f ~/.credentials ]; then
    source ~/.credentials
fi

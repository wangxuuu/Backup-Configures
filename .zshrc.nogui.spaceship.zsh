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

zinit light denysdovhan/spaceship-prompt

zsh-defer zinit for \
    light-mode  zsh-users/zsh-autosuggestions \
    light-mode  zdharma/history-search-multi-word

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

# GPG Agent forward
zsh-defer gpgconf --create-socketdir

[[ ! -f ~/.alias.zsh ]] || source ~/.alias.zsh
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

(( $PATH[(I)/usr/local/sbin] )) || export PATH="/usr/local/sbin:$PATH"
(( $PATH[(I)/usr/local/bin] )) || export PATH="/usr/local/bin:$PATH"
(( $PATH[(I)$HOME/.local/bin] )) || export PATH="$HOME/.local/bin:$PATH"

# Go
export GOROOT=$HOME/.go/go1.16
export GOPATH=$HOME/go
export GOBIN=$GOPATH/bin

(( $PATH[(I)$GOROOT] )) || export PATH="$GOROOT/bin:$PATH"
(( $PATH[(I)$GOBIN] )) || export PATH="$GOBIN:$PATH"

# Rust
[[ ! -f $HOME/.cargo/env ]] || source $HOME/.cargo/env

# should only contain user's environment variables
# -----

# set xdg base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# set language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# default editor
export EDITOR="vim"
export VISUAL="vim"

# zsh history
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000

# use 256 color term
export TERM=xterm-256color
export CLICOLOR=1

# set gopath
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

#this must be at the end of the file for sdkman to work!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

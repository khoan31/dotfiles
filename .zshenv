# Should only contain user's environment variables

# Set XDG base directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# Set language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Default editor
export EDITOR="vim"
export VISUAL="vim"

# Zsh history
HISTFILE=$HOME/.zhistory
SAVEHIST=10000
HISTSIZE=10000

# Use 256 color term
export TERM=xterm-256color
export CLICOLOR=1

# Scripts directory
export CHORES="$HOME/chores"
export PATH="$HOME/chores:$PATH"

# Repositories
export REPOS="$HOME/repos"

# Fzf options
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' 
 --color=fg:#777777,bg:-1,hl:#f05050,gutter:-1
 --color=fg+:#000000,bg+:-1,hl+:#aa3731,gutter:-1
 --color=info:#cb9000,prompt:#7a3e9d,pointer:#0083b2
 --color=marker:#ffbc5d,spinner:#448c27,header:#325cc0'

# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


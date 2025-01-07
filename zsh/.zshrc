# Fix for scripts setting up completion
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit 

export LC_ALL=en_US.UTF-8

# Colorize
export CLI_COLOR=1
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias wgrep='egrep --color=auto'
alias ls='ls -kpFG'

# NeoVim
alias vim="nvim"
alias vi="nvim"

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

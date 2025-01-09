# --- Shell Options ---

export LC_ALL=en_US.UTF-8

# https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/

# Use `cd` if directory name is used as a command
setopt AUTO_CD
# Case-insensitive glob completion
setopt NO_CASE_GLOB 
# Save history to a file
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
# Save timestamps and time elapsed in history
setopt EXTENDED_HISTORY
# Share history across multiple zsh sessions
setopt SHARE_HISTORY
# Append to history
setopt APPEND_HISTORY
# Adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# Expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST 
# Do not store duplications
setopt HIST_IGNORE_DUPS
# Ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# Removes blank lines from history
setopt HIST_REDUCE_BLANKS
# Autocorrection
setopt CORRECT
setopt CORRECT_ALL


# --- Prompt ---

# https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
# Last directory, green check if zero return code else red cross, and prompt
PROMPT='%F{blue}%1~%f %(?.%F{green}%f.%F{red}%f) %F{blue}%(!.#.>)%f '

# Time on the right
#RPROMPT='%F{#cc9944}%*%f'


# --- Aliases ---

# Colorize
export CLI_COLOR=1
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias wgrep='egrep --color=auto'
alias ls='ls -kpFG'
alias lldb='PATH="/usr/bin:$PATH" /usr/bin/lldb'
alias man='tmux split-window -h man'

# NeoVim
alias vim="nvim"
alias vi="nvim"

# fzf, open as a tmux window
alias fzf="fzf --tmux center"

# Git aliases
alias gs="git status -sb"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gca="git commit --amend"
alias gp="git push"
alias gpf="git push --force"


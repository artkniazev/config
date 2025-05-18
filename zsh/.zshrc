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
#setopt SHARE_HISTORY
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
#setopt CORRECT
#setopt CORRECT_ALL
# Allow susbtitutions in a prompt, see https://stackoverflow.com/questions/59558252/make-zsh-prompt-update-each-time-a-command-is-executed
# A better alternative is to add a precmd_functions, as below
#setopt PROMPT_SUBST

# --- Prompt ---

_prompt_git_head()
{
	local cwd=${1:-`pwd`}

	# Exit if not a git repo
	(git -C "$cwd" rev-parse --git-dir > /dev/null 2>&1) || return 0

	local res=''

	# If on a branch, then output branch name
	local symbolic_ref=$(git -C "$cwd" symbolic-ref -q HEAD)
	if [[ -n $symbolic_ref ]]; then
		res="%F{green}(${symbolic_ref#refs/heads/})%f"
	fi

	# If HEAD is detached, then output commit hash
	if [[ -z $res ]]; then
		#local commit_hash=`git -C "$cwd" rev-parse HEAD`
		#res=${commit_hash:0:7}
		# from https://stackoverflow.com/questions/39689789/zsh-setopt-prompt-subst-not-working
		res=$(git name-rev --name-only --no-undefined --always HEAD)
		res="%F{red}(${res})%f"
	fi

	echo $res
}

_prompt()
{
	# https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
	# Also see https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html

	# cwd name, is prev command succeeded, prompt
	PROMPT='%F{blue}%1~%f %(?.%F{green}%f.%F{red}%f) %F{white}%(!.#.>)%f '

	# git branch
	RPROMPT="$(_prompt_git_head)"
}

precmd_functions+=(_prompt)


# --- Aliases ---

# Colorize
export CLI_COLOR=1
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias wgrep='egrep --color=auto'
alias ls='ls -kpFG'
alias lldb='PATH="/usr/bin:$PATH" /usr/bin/lldb'
alias mman='tmux split-window -h man'
alias mann='tmux split-window -v man'

# NeoVim
alias vim="nvim"
alias vi="nvim"

# Emacs
alias em="emacs -nw"
alias emacs="emacs -nw"

# fzf, open as a tmux window
#alias fzf="fzf --tmux center"

# Git aliases
alias gs="git status -s"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit"
alias gca="git commit --amend"
alias gp="git push"
alias gpf="git push --force"
alias gl="git log"
alias glg="git --no-pager log --oneline --graph"
alias gbr="git branch"
alias gsw="git switch"

# --- Env vars ---
export XDG_CONFIG_HOME="$HOME/.config/"


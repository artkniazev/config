# --- Env vars ---
export LC_ALL=en_US.UTF-8
export XDG_CONFIG_HOME="$HOME/.config/"


# --- Shell Options ---

# https://scriptingosx.com/2019/06/moving-to-zsh-part-3-shell-options/
setopt AUTO_CD                          # Use `cd` if directory name is used as a command
setopt NO_CASE_GLOB                     # Case-insensitive glob completion
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history # Save history to a file
setopt EXTENDED_HISTORY                 # Save timestamps and time elapsed in history
setopt APPEND_HISTORY                   # Append to history
setopt INC_APPEND_HISTORY               # Adds commands as they are typed, not at shell exit
setopt HIST_EXPIRE_DUPS_FIRST           # Expire duplicates first
setopt HIST_IGNORE_DUPS                 # Do not store duplications
setopt HIST_FIND_NO_DUPS                # Ignore duplicates when searching
setopt HIST_REDUCE_BLANKS               # Removes blank lines from history

bindkey -e # emacs input mode

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

# https://scriptingosx.com/2019/07/moving-to-zsh-06-customizing-the-zsh-prompt/
# Also see https://zsh.sourceforge.io/Doc/Release/Prompt-Expansion.html
_prompt()
{
	# cwd name, is prev command succeeded, prompt
	PROMPT='%F{blue}%1~%f %(?.%F{green}%f.%F{red}%f) %F{white}%(!.#.>)%f '
	# git branch
	# RPROMPT="$(_prompt_git_head)"
}

#precmd_functions+=(_prompt)

# brew install starship
if command -v starship &> /dev/null; then
	eval "$(starship init zsh)"
fi

# --- Aliases ---

# Colorize
export CLI_COLOR=1
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias wgrep='egrep --color=auto'
alias ls='ls -kpFG'

# NeoVim
alias nv="nvim"
alias vim="nvim"
alias vi="nvim"
alias vimdiff="nvim -d"

# Emacs
alias em="emacs -nw"
alias magit="emacs --eval '(progn (magit-status) (delete-other-windows))'"

# Misc
alias veracrypt="/Applications/VeraCrypt.app/Contents/MacOS/VeraCrypt -t"
alias mount_veracrypt="veracrypt -k '' --pim=0 --protect-hidden=no"


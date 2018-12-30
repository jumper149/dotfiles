#
# ~/.zshrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# source general shell configuration
source $HOME/.posixrc

unsetopt BEEP NOTIFY

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# compinstall
zstyle :compinstall filename '/home/jumper/.zshrc'
# auto completion
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES
# compdef for compatible aliases in ~/.posixrc
compdef dotgit="git"

# prompt
autoload -U colors && colors
setopt PROMPT_SUBST
ZLE_RPROMPT_INDENT="0"
local function PROMPT_LAST_RETURN() {
	echo "%(?.%F{green}[%f%?%F{green}].%F{red}[%f%?%F{red}])%f"
}
local function PROMPT_SSH_HOST() {
	if [[ -n "$SSH_CONNECTION" ]]
	then
		echo "%f@%F{yellow}%m"
	else
		echo ""
	fi
}
local function PROMPT_GIT_INFO() {
	# exit if not inside a Git repository
	if [ "`git rev-parse --is-inside-work-tree 2> /dev/null`" != "true" ]
	then
		return 1
	fi

	# git branch/tag, or name-rev if on detached head
	local GIT_LOCATION=${$(git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD)#(refs/heads/|tags/)}

	# possible additions to prompt
	local GIT_MERGING="%F{magenta}●%f"
	local GIT_UNTRACKED="%F{red}●%f"
	local GIT_MODIFIED="%F{yellow}●%f"
	local GIT_STAGED="%F{green}●%f"

	# put right flags into $GIT_FLAGS
	local GIT_FLAGS=""
	local GIT_DIR="`git rev-parse --git-dir 2> /dev/null`"
	if [ -n $GIT_DIR ] && test -r $GIT_DIR/MERGE_HEAD; then
		GIT_FLAGS+="$GIT_MERGING"
	fi
	if [ -n "`git ls-files --other --exclude-standard 2> /dev/null`" ]; then
		GIT_FLAGS+="$GIT_UNTRACKED"
	fi
	if ! git diff --quiet 2> /dev/null; then
		GIT_FLAGS+="$GIT_MODIFIED"
	fi
	if ! git diff --cached --quiet 2> /dev/null; then
		GIT_FLAGS+="$GIT_STAGED"
	fi

	# return string for prompt
	if [ -n "$GIT_FLAGS" ]
	then
		echo "${GIT_FLAGS} ${GIT_LOCATION}"
	else
		echo "${GIT_LOCATION}"
	fi
}
# prompt needs '' instead of ""
PS1='%f[%F{blue}%n`PROMPT_SSH_HOST` %F{red}%1~%f]%B$%b '
RPS1='`PROMPT_GIT_INFO` `PROMPT_LAST_RETURN`'

# vim input
bindkey -v

# fish-like syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# use colors from ~/.Xresources on tty, start tmux
if [ "$TERM" = "linux" ]
then
	source ~/.scripts/tty-colors.sh
	tmux && tput reset && exit 0
fi

#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# source general shell configuration
source $HOME/.posixrc

# auto completion
source /usr/share/git/completion/git-completion.bash # provides __git_ps1
__git_complete dotgit __git_main

# shell prompt
source /usr/share/git/completion/git-prompt.sh # provides __git_ps1
function __exit_ps1() {
	local EXIT="$?"
	local EXIT_COLOR=""
	if [ "$EXIT" = 0 ]; then
		EXIT_COLOR="\e[32m"
	else
		EXIT_COLOR="\e[31m"
	fi
	echo -e "$EXIT_COLOR"
	return "$EXIT"
}
function __hostname_ps1() {
	local EXIT="$?" # preserve exit status
	local HOSTNAME_STRING="\e[39m@\e[35m$1"
	if [ -n "$SSH_CONNECTION" ]; then
		echo -e "$HOSTNAME_STRING"
	fi
	return "$EXIT"
}
PS1='\[\e[39m\][`__exit_ps1`\u`__hostname_ps1 \h` \[\e[34m\]\W`__git_ps1 " \[\e[39m\]@\[\e[33m\]%s"`\[\e[39m\]]\[\e[1;97m\]\$\[\e[0m\] '

# vim input
set -o vi

# use colors from ~/.Xresources on tty, start tmux
if [ "$TERM" = "linux" ]
then
	source ~/.scripts/tty-colors.sh
	tmux && tput reset && exit 0
fi

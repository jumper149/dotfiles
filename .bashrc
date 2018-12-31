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
__red_ps="`tput setaf 1`"
__green_ps="`tput setaf 2`"
__orange_ps="`tput setaf 3`"
__blue_ps="`tput setaf 4`"
__purple_ps="`tput setaf 5`"
__yellow_ps="`tput setaf 11`"
__white_ps="`tput setaf 15`"
__bold_ps="`tput bold`"
__normal_ps="`tput sgr0`"
function __exit_ps1() {
	local EXIT="$?"
	local EXIT_COLOR=""
	if [ "$EXIT" = 0 ]; then
		EXIT_COLOR="${__green_ps}"
	else
		EXIT_COLOR="${__red_ps}"
	fi
	printf '\001%s\002' "$EXIT_COLOR"
	return "$EXIT"
}
function __hostname_ps1() {
	local EXIT="$?" # preserve exit status
	if [ -n "$SSH_CONNECTION" ]; then
		printf "\001%s\002@\001%s\002%s" "${__white_ps}" "${__purple_ps}" "$1"
	fi
	return "$EXIT"
}
PS1='\001${__white_ps}\002[`__exit_ps1`\u`__hostname_ps1 \h` \001${__blue_ps}\002\W`__git_ps1 " \001${__white_ps}\002@\001${__orange_ps}\002%s"`\001${__white_ps}\002]\001${__bold_ps}\002\$\001${__normal_ps}\002 '
function __whitespace_ps2() {
	local EXIT="$?" # preserve exit status
	local EXTRA_SPACE="3"
	local USERNAME="$1"
	local HOSTNAME=""
	if [ -n "$SSH_CONNECTION" ]; then
		HOSTNAME="@$2"
	fi
	local DIRECTORY="$3"
	if [ "$DIRECTORY" = "$HOME" ]; then
		DIRECTORY="~"
	fi
	local GIT_BRANCH="`__git_ps1 " @%s"`"
	local LENGTH="$(( $EXTRA_SPACE + ${#USERNAME} + ${#HOSTNAME} + ${#DIRECTORY} + ${#GIT_BRANCH} ))"
	printf '%*s' "$LENGTH"
	return "$EXIT"
}
PS2='`__whitespace_ps2 \u \h \W`\001${__yellow_ps}\002>\001${__white_ps}\002 '

# vim input
set -o vi

# use colors from ~/.Xresources on tty, start tmux
if [ "$TERM" = "linux" ]
then
	source ~/.scripts/tty-colors.sh
	tmux && tput reset && exit 0
fi

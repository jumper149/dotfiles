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
__red_ps1="`tput setaf 1`"
__green_ps1="`tput setaf 2`"
__orange_ps1="`tput setaf 3`"
__blue_ps1="`tput setaf 4`"
__purple_ps1="`tput setaf 5`"
__white_ps1="`tput setaf 15`"
__bold_ps1="`tput bold`"
__normal_ps1="`tput sgr0`"
function __exit_ps1() {
	local EXIT="$?"
	local EXIT_COLOR=""
	if [ "$EXIT" = 0 ]; then
		EXIT_COLOR="${__green_ps1}"
	else
		EXIT_COLOR="${__red_ps1}"
	fi
	printf '\001%s\002' "$EXIT_COLOR"
	return "$EXIT"
}
function __hostname_ps1() {
	local EXIT="$?" # preserve exit status
	if [ -n "$SSH_CONNECTION" ]; then
		printf "\001%s\002@\001%s\002%s" "${__white_ps1}" "${__purple_ps1}" "$1"
	fi
	return "$EXIT"
}
PS1='\001${__white_ps1}\002[`__exit_ps1`\u`__hostname_ps1 \h` \001${__blue_ps1}\002\W`__git_ps1 " \001${__white_ps1}\002@\001${__orange_ps1}\002%s"`\001${__white_ps1}\002]\001${__bold_ps1}\002\$\001${__normal_ps1}\002 '


# vim input
set -o vi

# use colors from ~/.Xresources on tty, start tmux
if [ "$TERM" = "linux" ]
then
	source ~/.scripts/tty-colors.sh
	tmux && tput reset && exit 0
fi

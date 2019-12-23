#!/usr/bin/env bash

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# source general shell configuration
source "${HOME}/.profile"
source "${HOME}/.posixrc"

# auto completion
source /usr/share/git/completion/git-completion.bash # provides __git_main
__git_complete dotgit __git_main
__git_complete safegit __git_main

# shell prompt
source /usr/share/git/completion/git-prompt.sh # provides __git_ps1
__red_ps="$(tput setaf 1)"
__green_ps="$(tput setaf 2)"
__orange_ps="$(tput setaf 3)"
__blue_ps="$(tput setaf 4)"
__purple_ps="$(tput setaf 5)"
__yellow_ps="$(tput setaf 11)"
__bold_ps="$(tput bold)"
__normal_ps="$(tput sgr0)"
function __exit_ps1() {
	local EXIT="${?}"
	local EXIT_COLOR=""
	if [ "${EXIT}" = 0 ]; then
		EXIT_COLOR="${__green_ps}"
	else
		EXIT_COLOR="${__red_ps}"
	fi
	printf '\001%s\002' "${EXIT_COLOR}"
	return "${EXIT}"
}
function __hostname_ps1() {
	local EXIT="${?}"
	if [ -n "${SSH_CONNECTION}" ]; then
		printf "\001%s\002@\001%s\002%s" "${__normal_ps}" "${__purple_ps}" "${1}"
	fi
	return "${EXIT}"
}
PS1='\001${__normal_ps}\002[$(__exit_ps1)\u$(__hostname_ps1 \h) \001${__blue_ps}\002\W$(__git_ps1 " \001${__normal_ps}\002@\001${__orange_ps}\002%s")\001${__normal_ps}\002]\001${__bold_ps}\002\$\001${__normal_ps}\002 '
function __whitespace_ps2() {
	local EXIT="${?}"
	local EXTRA_SPACE="3"
	local USERNAME="${1}"
	local HOSTNAME=""
	if [ -n "${SSH_CONNECTION}" ]; then
		HOSTNAME="@${2}"
	fi
	local DIRECTORY="${3}"
	if [ "${DIRECTORY}" = "${HOME}" ]; then
		DIRECTORY="~"
	fi
	local GIT_BRANCH
	GIT_BRANCH="$(__git_ps1 " @%s")"
	local LENGTH="$(( EXTRA_SPACE + ${#USERNAME} + ${#HOSTNAME} + ${#DIRECTORY} + ${#GIT_BRANCH} ))"
	printf '%*s' "${LENGTH}" ""
	return "${EXIT}"
}
PS2='$(__whitespace_ps2 \u \h \W)\001${__yellow_ps}${__bold_ps}\002|\001${__normal_ps}\002 '

# vim input
set -o vi

if [ "${TERM}" = "linux" ]; then
	__graphical_session="$("${HOME}/.scripts/decide/terminal.sh" "Xmonad" "i3" "tmux" "TTY")"
	case $__graphical_session in
		"TTY")
			;;
		"tmux")
			blugon --once --backend="tty" && clear
			(blugon --backend="tty")&
			tmux && tput reset && exit
			;;
		"i3")
			startx ~/.xinitrc "i3" && exit
			;;
		"Xmonad")
			startx ~/.xinitrc "xmonad" && exit
			;;
	esac
fi

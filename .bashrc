#
# ~/.bashrc
#

# if not running interactively, don't do anything
[[ $- != *i* ]] && return

# source general shell configuration
source $HOME/.posixrc

# shell prompt colors
if [ "$(hostname)" = "x220arch" ]
then
	PS1='\[\e[35m\][\[\e[34m\]\u\[\e[32m\]@\[\e[33m\]\h \[\e[31m\]\W\[\e[35m\]]\[\e[1;97m\]\$\[\e[0m\] '
elif [ "$(hostname)" = "x201arch" ]
then
	PS1='\[\e[35m\][\[\e[34m\]\u\[\e[33m\]@\[\e[32m\]\h \[\e[31m\]\W\[\e[35m\]]\[\e[1;97m\]\$\[\e[0m\] '
elif [ "$(hostname)" = "deskarch" ]
then
	PS1='\[\e[35m\][\[\e[31m\]\u\[\e[33m\]@\[\e[32m\]\h \[\e[34m\]\W\[\e[35m\]]\[\e[1;97m\]\$\[\e[0m\] '
fi

# vim input
set -o vi

# use colors from ~/.Xresources on tty, start tmux
if [ "$TERM" = "linux" ]
then
	source ~/.scripts/tty-colors.sh
	tmux && tput reset && exit 0
fi

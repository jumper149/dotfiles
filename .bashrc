#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

alias dotgit='git --git-dir=/home/jumper/.dotfiles/ --work-tree=/home/jumper/'

PS1='\[\e[35m\][\[\e[34m\]\u\[\e[32m\]@\[\e[33m\]\h \[\e[31m\]\W\[\e[35m\]]\[\e[1;97m\]\$\[\e[0m\] '

set -o vi

export VISUAL='vim'
export EDITOR='$VISUAL'

export PAGER='vimpager'
alias less='$PAGER'
alias zless='$PAGER'

alias usbmount='~/.config/i3/scripts/mount_known.sh'
alias usbumount='~/.config/i3/scripts/umount.sh'

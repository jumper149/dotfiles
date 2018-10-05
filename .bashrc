#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ls colors
alias ls='ls --color=auto'

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

# dotfiles
alias dotgit='git --git-dir=/home/jumper/.dotfiles/ --work-tree=/home/jumper/'

# system update pacman
alias pacup="sudo pacman -Syu"
alias pacsync="~/.readme/install_core.sh"

# usb scripts
alias usbmount='~/.config/i3/scripts/usb_mount.sh'
alias usbumount='~/.config/i3/scripts/usb_umount.sh'
alias usbbackup='~/.config/i3/scripts/usb_backup.sh'

# for gpg-agent from manpage
export GPG_TTY=$(tty)
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# record ffmpeg
alias ffmpegscreen='~/.config/i3/scripts/record_screen.sh'

# clear ranger-trash
alias ranger-trash-clear='~/.config/ranger/empty_trash.sh'

# ssh and local ip
IPDESK='192.168.1.199'
IPJUMP='192.168.1.198'
IPPI64='192.168.1.197'
IPPI32='192.168.1.187'
IPX201='192.168.1.196'
IPX220='192.168.1.195'
IPA3='192.168.1.190'

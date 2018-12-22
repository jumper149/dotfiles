#
# ~/.zshrc
#

unsetopt AUTO_CD BEEP EXTENDEDGLOB NOTIFY

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt APPENDHISTORY

# compinstall
zstyle :compinstall filename '/home/jumper/.zshrc'
# auto completion
autoload -Uz compinit
compinit
setopt COMPLETE_ALIASES NOMATCH

# shell prompt colors
if [ "`hostname`" = "x220arch" ]
then
	PS1=$'%{\e[35m%}[%{\e[34m%}z%{\e[32m%}%{\e[33m%}s%{\e[31m%}h%{\e[35m%}]%{\e[1;97m%}\$%{\e[0m%} '
elif [ "`hostname`" = "x201arch" ]
then
	PS1=$'%{\e[35m%}[%{\e[34m%}z%{\e[33m%}%{\e[32m%}s%{\e[31m%}h%{\e[35m%}]%{\e[1;97m%}\$%{\e[0m%} '
elif [ "`hostname`" = "deskarch" ]
then
	PS1=$'%{\e[35m%}[%{\e[31m%}z%{\e[33m%}%{\e[32m%}s%{\e[34m%}h%{\e[35m%}]%{\e[1;97m%}\$%{\e[0m%} '
fi

# vim
bindkey -v
export VISUAL='vim -p'
export EDITOR="$VISUAL"
alias vi="$EDITOR"
alias vim="$EDITOR"
export PAGER='vimpager'
alias less="$PAGER"
alias zless="$PAGER"

# dotfiles
alias dotgit='git --git-dir=/home/jumper/.dotfiles/ --work-tree=/home/jumper/'

# system update pacman
alias pacup="sudo pacman -Syu"
alias pacsync="~/.readme/install_core.sh"

# usb scripts
alias usbmount='~/.scripts/usb/mount.sh'
alias usbumount='~/.scripts/usb/umount.sh'
alias usbbackup='~/.scripts/usb/backup.sh'

# mail
export MAIL="$HOME/.mail/"

# record ffmpeg
alias ffmpegscreen='~/.scripts/record_screen.sh'

# ranger-cd
function ranger-cd {
	tempfile="$(mktemp -t tmp.XXXXXX)"
	ranger --choosedir="$tempfile" "${@:-$(pwd)}"
	test -f "$tempfile" &&
		if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
			cd -- "$(cat "$tempfile")"
		fi
		rm -f -- "$tempfile"
	}

# clear ranger-trash
alias ranger-trash-clear='~/.config/ranger/empty_trash.sh'

# fastermelee
alias fastermelee='LD_LIBRARY_PATH=~/Templates/fm-git/lib/ ~/Templates/fm-git/FasterMelee-installer/src/launch-fm'

# ssh and local ip
IPDESK='192.168.1.199'
IPJUMP='192.168.1.198'
IPPI64='192.168.1.197'
IPPI32='192.168.1.187'
IPX201='192.168.1.196'
IPX220='192.168.1.195'
IPA3='192.168.1.190'

# for gpg-agent from manpage
export GPG_TTY=$(tty)
unset SSH_AGENT_PID
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
	export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi

# use colors from ~/.Xresources on tty, start tmux
if [ "$TERM" = "linux" ]
then
	source ~/.scripts/tty-colors.sh
	tmux && tput reset && exit 0
fi

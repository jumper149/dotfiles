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
autoload -Uz promptinit
promptinit
prompt redhat
# overwrite with custom (prior part necessary?)
PS1='%f[%F{blue}%n%f@%F{blue}%m %F{red}%1~%f]%B$%b '
RPS1='%(?.%F{green}[%f%?%F{green}].%F{red}[%f%?%F{red}])%f'

# vim input
bindkey -v

# source general shell configuration
source $HOME/.posixrc

# fish-like syntax-highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# use colors from ~/.Xresources on tty, start tmux
if [ "$TERM" = "linux" ]
then
	source ~/.scripts/tty-colors.sh
	tmux && tput reset && exit 0
fi

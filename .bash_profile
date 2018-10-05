#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# vim
set -o vi
export VISUAL='vim -p'
export EDITOR="$VISUAL"
alias vi="$EDITOR"
alias vim="$EDITOR"
export PAGER='vimpager'
alias less="$PAGER"
alias zless="$PAGER"

# mail
export MAIL="$HOME/.mail/"

# qt theme
export QT_SELECT=5
export QT_QPA_PLATFORMTHEME=gtk2
alias vlc='export DESKTOP_SESSION=gnome; vlc' # only gives gtk-theme when started from terminal

# fastermelee
alias fastermelee='LD_LIBRARY_PATH=~/Templates/fm-git/lib/ ~/Templates/fm-git/FasterMelee-installer/src/launch-fm'

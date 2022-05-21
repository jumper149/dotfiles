#!/usr/bin/env sh

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export PATH="${PATH}:${HOME}/.bin:${HOME}/.cabal/bin"

export INPUTRC="${XDG_CONFIG_HOME}/inputrc"

export VISUAL="nvim"
export EDITOR="${VISUAL}"
export PAGER="less"
export BROWSER="qutebrowser"

# TODO: Using sgr0 to reset color might be resetting too much
export LESS_TERMCAP_ke="$(tput rmkx; tput setaf 4)" # send commands
export LESS_TERMCAP_ks="$(tput smkx; tput setaf 3)" # send digits
export LESS_TERMCAP_mb="$(tput blink)"              # start blink
export LESS_TERMCAP_md="$(tput bold; tput setaf 1)" # start bold
export LESS_TERMCAP_me="$(tput sgr0)"               # stop bold, blink, underline
export LESS_TERMCAP_se="$(tput rmso; tput sgr0)"    # stop standout
export LESS_TERMCAP_so="$(tput smso; tput setaf 5)" # standout
export LESS_TERMCAP_ue="$(tput rmul; tput sgr0)"    # stop underline
export LESS_TERMCAP_us="$(tput smul; tput setaf 2)" # start underline
#export LESS_TERMCAP_vb="$(tput flash)"              # visual bell, TODO: leads to error on TTY

export MAIL="${HOME}/.mail/"

export XMONAD_CACHE_DIR="${XDG_CACHE_HOME}/xmonad"
export XMONAD_CONFIG_DIR="${XDG_CONFIG_HOME}/xmonad"
export XMONAD_DATA_DIR="${XDG_DATA_HOME}/xmonad"

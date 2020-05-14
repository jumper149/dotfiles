#!/usr/bin/env sh

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export PATH="${PATH}:${HOME}/.bin:${HOME}/.cabal/bin"

export VISUAL="vim"
export EDITOR="${VISUAL}"
export PAGER="vimpager"
export BROWSER="qutebrowser"

export MAIL="${HOME}/.mail/"

export VIMINIT=":source ${XDG_CONFIG_HOME}/vim/vimrc"

export XMONAD_CACHE_DIR="${XDG_CACHE_HOME}/xmonad"
export XMONAD_CONFIG_DIR="${XDG_CONFIG_HOME}/xmonad"
export XMONAD_DATA_DIR="${XDG_DATA_HOME}/xmonad"

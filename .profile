#!/usr/bin/env sh

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"

export PATH="${PATH}:${HOME}/.bin:${HOME}/.cabal/bin"

export VISUAL="vim"
export EDITOR="${VISUAL}"
export PAGER="vimpager"
export BROWSER="firefox"

export MAIL="${HOME}/.mail/"

export VIMINIT=":source ${XDG_CONFIG_HOME}/vim/vimrc"

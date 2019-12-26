#!/usr/bin/env sh

export PATH="${PATH}:${HOME}/.cabal/bin:${HOME}/.scripts"

export VISUAL="vim"
export EDITOR="${VISUAL}"
export PAGER="vimpager"
export BROWSER="firefox"

export MAIL="${HOME}/.mail/"

alias dotgit='git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}'
alias safegit='git --git-dir=${HOME}/.dotsafe --work-tree=${HOME}'

alias sprunge='curl -F "sprunge=<-" http://sprunge.us'
alias ixio='curl -F "f:1=<-" http://ix.io'

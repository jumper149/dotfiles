autocmd BufRead,BufNewFile *.purs setfiletype purescript
autocmd FileType purescript let &l:commentstring='{--%s--}'

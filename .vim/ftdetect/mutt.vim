autocmd BufRead,BufNewFile /tmp/mutt-* setfiletype mail
autocmd FileType mail let &colorcolumn=&textwidth+1

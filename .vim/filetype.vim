augroup filetypedetect
  " Mail
  autocmd BufRead,BufNewFile /tmp/mutt-*              setfiletype mail

  " Wolfram-Language
  autocmd BufRead,BufNewFile *.wl                     setfiletype wolfram
  autocmd BufRead,BufNewFile *.wls                    setfiletype wolfram
  autocmd BufRead,BufNewFile *.m                      setfiletype wolfram
augroup END

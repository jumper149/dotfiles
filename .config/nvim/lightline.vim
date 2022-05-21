if &t_Co >= 256 || has("gui_running")
  let g:lightline = {
    \ 'colorscheme': 'wombat'
    \ }
endif

" Makes information not be shown 2 times with lightline
set shortmess=F

" Dont overwrite settings
if exists('skip_defaults_vim')
  finish
endif

" Activates Vim > Vi
if &compatible
  set nocompatible
endif

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=200		" keep 200 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line

set ttimeout		" time out for key codes
set ttimeoutlen=100	" wait up to 100ms after Esc for special key

" Use incremental searching timeout possible
if has('reltime')
  set incsearch
endif

" Enable mouse support
if has('mouse')
  set mouse=a
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection
  filetype plugin indent on

  " Put these in an autocmd group, so that you can revert them with:
  " ":augroup vimStartup | au! | augroup END"
  augroup vimStartup
    au!

    " Remember last cursors position
    autocmd BufReadPost *
      \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
      \ |   exe "normal! g`\""
      \ | endif

  augroup END

endif

" Set UTF-8
set encoding=utf-8
set fileencoding=utf-8

" Convert tab to spaces
set expandtab

" Sets line numbers relative to the current line
set number
set relativenumber

" Provides X-clipboard support (requires gvim)
vmap <C-c> "+yi<ESC>
vmap <C-x> "+c<ESC>
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" Color and font
if &t_Co >= 8 || has("gui_running")

  " Revert with ":syntax off".
  syntax on
  set hlsearch

  " Use italic font for comments in 256-color terminal
  " and set colorscheme
  if &t_Co >= 256 || has("gui_running")
    colorscheme wombat256
    highlight Comment cterm=italic
  else
    colorscheme default
  endif 

endif

" Set minimal distance from cursor to border
set scrolloff=8

" Removes Highlighting from search patterns
nnoremap <silent> <Space> :noh<Enter><Space>

" Highlight current line
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" Configure vim-airline, vim-airline-themes
let g:airline_theme='wombat'
let g:airline#extensions#tabline#enabled = 1
let g:airline_symbols_ascii = 1
let g:airline#extensions#whitespace#enabled = 0

" Makes information not be shown 2 times with vim-airline
set shortmess=F

" Keeps terminal background transparent (comment for being productive)
"highlight Normal ctermbg=none

" vim-latexsuite
set grepprg=grep\ -nH\ $*
let g:tex_flavor = "latex"
" Dont highlight underscores (_)
let g:tex_no_error=1

" Hotkeys
nmap mm :w <Enter>:!./% <Enter>
nmap mp :w <Enter>:!python % <Enter>
nmap mt :w <Enter>:!pdflatex -interaction nonstopmode -halt-on-error -file-line-error % <Enter>
nmap mcs :w <Enter>:!chez-scheme --script % <Enter>

" Legacy setup, when vim and nvim configuration were combined
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Enable mouse support for normal and visual mode
if has('mouse')
  set mouse=nv
endif

" Remember last cursor position
autocmd BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif

" Convert tab to spaces
set expandtab
set shiftwidth=4
set softtabstop=-1

" Automatic indentation
set smartindent

" Sets line numbers relative to the current line
set number
set relativenumber

" Set minimal distance from cursor to border
set scrolloff=8

" Enable Highlighting
syntax on

" Leader keys
let mapleader='ml'

" Set colorscheme
if &t_Co >= 256 || has("gui_running")
  colorscheme wombat256jumper
else
  colorscheme default
endif

" Highlight current line
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Configure lightline
source $XDG_CONFIG_HOME/nvim/lightline.vim

" Enable file type detection
filetype plugin indent on

" Provides X-clipboard support (requires gvim)
vmap <C-c> "+yi<ESC>
vmap <C-x> "+c<ESC>
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+

" Removes Highlighting from search patterns
nnoremap <silent> <Space> :nohlsearch<Enter>

" Configure rainbow
source $XDG_CONFIG_HOME/nvim/rainbow.vim

" Highlight spaces
lua << EOF
vim.opt.list = true
vim.opt.listchars:append("eol:$")
vim.opt.listchars:append("tab:<⋅>")
vim.opt.listchars:append("space:⋅")
EOF

" indent-blankline-nvim, nvim-treesitter, nvim-treesitter-context
let g:indent_blankline_char_list = ['|', '¦', '┆', '┊', '│', '│', '│', '│', '│', '│']
let g:space_char_blankline = " "
let g:indent_blankline_use_treesitter = v:true " required for context indent highlighting
let g:indent_blankline_context_char = '│'
let g:indent_blankline_show_current_context = v:true
lua << EOF
-- Enable tree-sitter syntax highlighting
require'nvim-treesitter.configs'.setup { highlight = { enable = true } }
EOF

" LSP, nvim-lspconfig, nvim-cmp
source $XDG_CONFIG_HOME/nvim/lsp.vim

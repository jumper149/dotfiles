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
" Local Leader mainly for idris2
let maplocalleader='mi'

" Set colorscheme
if &t_Co >= 256 || has("gui_running")
  colorscheme wombat256jumper
else
  colorscheme default
endif

" Configure lightline
if &t_Co >= 256 || has("gui_running")
  let g:lightline = {
    \ 'colorscheme': 'wombat'
    \ }
endif

" Highlight current line
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Makes information not be shown 2 times with lightline
set shortmess=F

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

" Commands
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :quit!

" Hotkeys
nmap mm :w <Enter>:!./% <Enter>

" LSP, nvim-lspconfig, nvim-cmp
set completeopt=menuone,noselect
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.source = {}
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.emoji = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.path = v:true
let g:compe.source.tags = v:true
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : compe#complete()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set signcolumn=no
sign define LspDiagnosticsSignError text=E texthl=LspDiagnosticsSignError linehl= numhl=LspDiagnosticsSignError
sign define LspDiagnosticsSignWarning text=W texthl=LspDiagnosticsSignWarning linehl= numhl=LspDiagnosticsSignWarning
sign define LspDiagnosticsSignInformation text=W texthl=LspDiagnosticsSignInformation linehl= numhl=LspDiagnosticsSignInformation
sign define LspDiagnosticsSignHint text=W texthl=LspDiagnosticsSignHint linehl= numhl=LspDiagnosticsSignHint
lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n', 'mla', '<CMD>lua vim.lsp.buf.code_action()<CR>'    , opts)
    buf_set_keymap('n', 'mld', '<CMD>lua vim.lsp.buf.declaration()<CR>'    , opts)
    buf_set_keymap('n', 'mlg', '<CMD>lua vim.lsp.buf.definition()<CR>'     , opts)
    buf_set_keymap('n', 'mlG', '<CMD>lua require(\'telescope.builtin\').lsp_definitions( { jump_type = "tab" } )<CR>', opts)
    buf_set_keymap('n', 'mlf', '<CMD>lua vim.lsp.buf.formatting()<CR>'     , opts)
    buf_set_keymap('n', 'mlk', '<CMD>lua vim.lsp.buf.hover()<CR>'          , opts)
    buf_set_keymap('n', 'mli', '<CMD>lua vim.lsp.buf.implementation()<CR>' , opts)
    buf_set_keymap('n', 'mlr', '<CMD>lua vim.lsp.buf.references()<CR>'     , opts)
    buf_set_keymap('n', 'mlc', '<CMD>lua vim.lsp.buf.rename()<CR>'         , opts)
    buf_set_keymap('n', 'mlh', '<CMD>lua vim.lsp.buf.signature_help()<CR>' , opts)
    buf_set_keymap('n', 'mlt', '<CMD>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', 'mlwa', '<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>'   , opts)
    buf_set_keymap('n', 'mlwr', '<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', 'mlwl', '<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', 'ml<SPACE><SPACE>', '<CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'  , opts)
    buf_set_keymap('n', 'ml<SPACE>p', '<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>'                    , opts)
    buf_set_keymap('n', 'ml<SPACE>n', '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>'                    , opts)
    buf_set_keymap('n', 'ml<SPACE>q', '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>'                  , opts)
  end
  nvim_lsp.bashls.setup { on_attach=on_attach }
  nvim_lsp.cssls.setup { on_attach=on_attach, cmd={ "css-languageserver", "--stdio" } }
  nvim_lsp.dhall_lsp_server.setup { on_attach=on_attach }
  nvim_lsp.hls.setup { on_attach=on_attach }
  nvim_lsp.html.setup { on_attach=on_attach, cmd={ "html-languageserver", "--stdio" } }
  require('idris2').setup { server = { on_attach=on_attach } }
  nvim_lsp.jsonls.setup { on_attach=on_attach, cmd={ "json-languageserver", "--stdio" } }
  nvim_lsp.rnix.setup { on_attach=on_attach }
  nvim_lsp.vimls.setup { on_attach=on_attach }
  nvim_lsp.yamlls.setup { on_attach=on_attach }
EOF

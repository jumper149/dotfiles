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
let g:rainbow_active=1
let g:rainbow_conf = {
  \   'guifgs'  : ['#8787d7', '#5f87d7', '#87af87', '#afaf87', '#af87af']
  \ , 'ctermfgs': [     104 ,       68 ,      108 ,      144 ,      139 ]
  \ , 'guis'    : [       '',        '',        '',        '',        '']
  \ , 'cterms'  : [       '',        '',        '',        '',        '']
  \ , 'operators': '_,_'
  \ , 'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold']
  \ , 'separately': {
  \     '*': {}
  \   , 'markdown': {
  \       'parentheses_options': 'containedin=markdownCode contained'
  \     }
  \   , 'haskell': {
  \       'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/\v\{\ze[^-]/ end=/}/ fold']
  \     }
  \   , 'vim': {
  \       'parentheses_options': 'containedin=vimFuncBody'
  \     }
  \   , 'perl': {
  \       'syn_name_prefix': 'perlBlockFoldRainbow'
  \     }
  \   , 'stylus': {
  \       'parentheses': ['start=/{/ end=/}/ fold contains=@colorableGroup']
  \     }
  \   , 'css': 0
  \   }
  \ }

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_guide_size=1
let g:indent_guides_auto_colors=0

" Commands
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :quit!

" Hotkeys
nmap mm :w <Enter>:!./% <Enter>

" LSP, nvim-lspconfig
set signcolumn=yes:1
lua << EOF
  local nvim_lsp = require('lspconfig')
  local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local opts = { noremap=true, silent=true }
    buf_set_keymap('n',  'mla', '<CMD>lua vim.lsp.buf.code_action()<CR>'                               , opts)
    buf_set_keymap('n',  'mld', '<CMD>lua vim.lsp.buf.declaration()<CR>'                               , opts)
    buf_set_keymap('n',  'mlg', '<CMD>lua vim.lsp.buf.definition()<CR>'                                , opts)
    buf_set_keymap('n',  'mlf', '<CMD>lua vim.lsp.buf.formatting()<CR>'                                , opts)
    buf_set_keymap('n',  'mlk', '<CMD>lua vim.lsp.buf.hover()<CR>'                                     , opts)
    buf_set_keymap('n',  'mli', '<CMD>lua vim.lsp.buf.implementation()<CR>'                            , opts)
    buf_set_keymap('n',  'mlr', '<CMD>lua vim.lsp.buf.references()<CR>'                                , opts)
    buf_set_keymap('n',  'mlc', '<CMD>lua vim.lsp.buf.rename()<CR>'                                    , opts)
    buf_set_keymap('n',  'mlh', '<CMD>lua vim.lsp.buf.signature_help()<CR>'                            , opts)
    buf_set_keymap('n',  'mlt', '<CMD>lua vim.lsp.buf.type_definition()<CR>'                           , opts)
    buf_set_keymap('n', 'mlwa', '<CMD>lua vim.lsp.buf.add_workspace_folder()<CR>'                      , opts)
    buf_set_keymap('n', 'mlwr', '<CMD>lua vim.lsp.buf.remove_workspace_folder()<CR>'                   , opts)
    buf_set_keymap('n', 'mlwl', '<CMD>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', 'ml<SPACE>e', '<CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>'        , opts)
    buf_set_keymap('n', 'ml<SPACE>p', '<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>'                    , opts)
    buf_set_keymap('n', 'ml<SPACE>n', '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>'                    , opts)
    buf_set_keymap('n', 'ml<SPACE>q', '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>'                  , opts)
  end
  nvim_lsp.bashls.setup { on_attach=on_attach }
  nvim_lsp.cssls.setup { on_attach=on_attach, cmd={ "css-languageserver", "--stdio" } }
  nvim_lsp.dhall_lsp_server.setup { on_attach=on_attach }
  nvim_lsp.hls.setup { on_attach=on_attach }
  nvim_lsp.html.setup { on_attach=on_attach, cmd={ "html-languageserver", "--stdio" } }
  nvim_lsp.jsonls.setup { on_attach=on_attach, cmd={ "json-languageserver", "--stdio" } }
  nvim_lsp.rnix.setup { on_attach=on_attach }
  nvim_lsp.vimls.setup { on_attach=on_attach }
EOF

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

" Configure vim-airline
let g:airline#extensions#tabline#enabled=1
if &t_Co >= 256 || has("gui_running")
  let g:airline_theme='wombat'
else
  let g:airline_symbols_ascii=1
endif

" Highlight current line
augroup CursorLine
  autocmd!
  autocmd VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  autocmd WinLeave * setlocal nocursorline
augroup END

" Makes information not be shown 2 times with vim-airline
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

" deoplete
" Don't show documentation popup window with LanguageClient_neovim
set completeopt-=preview
let g:deoplete#enable_at_startup=1
autocmd VimEnter * call deoplete#custom#option({
  \   'auto_complete_delay': 0
  \ })
" Use <Tab> for auto-completion
" TODO: It would be awesome to automatically select the first entry with Tab,
" even when it was so slow, that it was activated with manual_complete. Not
" sure, how I can select the first entry from the popup-menu after having
" called deoplete#manual_complete().
inoremap <expr><Tab> pumvisible() ? "\<C-n>" : deoplete#manual_complete()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" LanguageClient-neovim
let g:LanguageClient_diagnosticsSignsMax=0
let g:LanguageClient_selectionUI="fzf"
let g:LanguageClient_setOmnifunc=v:false
let g:LanguageClient_serverCommands = {
  \   'haskell'  : ['haskell-language-server-wrapper', '--lsp']
  \ , 'nix'      : ['rnix-lsp']
  \ , 'python'   : ['pyls']
  \ , 'rust'     : ['rls']
  \ , 'sh'       : ['bash-language-server', 'start']
  \ , 'terraform': ['terraform-ls', 'serve']
  \ , 'vim'      : ['vim-language-server', '--stdio']
  \ }
" TODO: Is this the only way to handle the hls eval plugin?
nnoremap <Leader>e :call LanguageClient#handleCodeLensAction()<CR>
nnoremap <Leader>f :call LanguageClient#textDocument_references()<CR>
nnoremap <Leader>F :call LanguageClient#textDocument_formatting()<CR>
" TODO: This doesn't seem to be working for range
vnoremap <Leader>F :call LanguageClient#textDocument_rangeFormatting()<CR>
nnoremap <Leader>g :call LanguageClient#textDocument_definition()<CR>
nnoremap <Leader>h :call LanguageClient#textDocument_hover()<CR>
" Alias for <Leader>h
nnoremap <Leader>k :call LanguageClient#textDocument_hover()<CR>
nnoremap <Leader>m :call LanguageClient_contextMenu()<CR>
nnoremap <Leader>r :call LanguageClient#textDocument_rename()<CR>
nnoremap <Leader>s :call LanguageClient#textDocument_documentSymbol()<CR>
nnoremap <Leader>v :call LanguageClient#textDocument_documentHighlight()<CR>
nnoremap <Leader>V :call LanguageClient#clearDocumentHighlight()<CR>

" Commands
command W :execute ':silent w !sudo tee % > /dev/null' | :edit!
command Wq :execute ':silent w !sudo tee % > /dev/null' | :quit!

" Hotkeys
nmap mm :w <Enter>:!./% <Enter>

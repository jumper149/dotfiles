set background=dark

hi clear

if exists("syntax_on")
    syntax reset
endif

let colors_name = "wombat256jumper"


" General colors
hi Normal       ctermfg=254  ctermbg=234  cterm=none        guifg=#f6f3e8 guibg=#242424 gui=none
hi Cursor       ctermfg=none ctermbg=241  cterm=none                      guibg=#656565 gui=none
hi Visual       ctermfg=146  ctermbg=238  cterm=none        guifg=#f6f3e8 guibg=#444444 gui=none
" hi VisualNOS
" hi Search
hi Folded       ctermfg=103  ctermbg=238  cterm=none        guifg=#a0a8b0 guibg=#384048 gui=none
hi Title        ctermfg=7    ctermbg=none cterm=bold        guifg=#f6f3e8               gui=bold
hi StatusLine   ctermfg=7    ctermbg=238  cterm=none        guifg=#f6f3e8 guibg=#444444 gui=none
hi VertSplit    ctermfg=238  ctermbg=238  cterm=none        guifg=#444444 guibg=#444444 gui=none
hi StatusLineNC ctermfg=243  ctermbg=238  cterm=none        guifg=#857b6f guibg=#444444 gui=none
hi LineNr       ctermfg=243  ctermbg=0    cterm=none        guifg=#857b6f guibg=#000000 gui=none
hi SpecialKey   ctermfg=244  ctermbg=236  cterm=none        guifg=#808080 guibg=#343434 gui=none
hi NonText      ctermfg=236  ctermbg=none cterm=none        guifg=none    guibg=#343434 gui=none
hi Whitespace   ctermfg=236  ctermbg=none cterm=none        guifg=none    guibg=#343434 gui=none

" Vim >= 7.0 specific colors
if version >= 700
    hi CursorLine   ctermfg=none ctermbg=235  cterm=none                      guibg=#282828 gui=none
    hi MatchParen                ctermbg=233  cterm=bold                      guibg=#121212 gui=bold
    hi Pmenu        ctermfg=251  ctermbg=238  cterm=none        guifg=#f6f3e8 guibg=#444444 gui=none
    hi PmenuSel     ctermfg=234  ctermbg=192  cterm=bold        guifg=#000000 guibg=#cae682 gui=bold
endif

" Syntax highlighting
hi Comment      ctermfg=246  ctermbg=none cterm=italic    guifg=#99968b               gui=italic

hi Constant     ctermfg=179  ctermbg=none cterm=none      guifg=#d7af5f               gui=none
hi String       ctermfg=113  ctermbg=none cterm=none      guifg=#87d75f               gui=none
hi Number       ctermfg=173  ctermbg=none cterm=none      guifg=#d7875f               gui=none
hi Boolean      ctermfg=180  ctermbg=none cterm=none      guifg=#d7af87               gui=none

hi Identifier   ctermfg=193  ctermbg=none cterm=none      guifg=#d7ffaf               gui=none
hi Function     ctermfg=191  ctermbg=none cterm=none      guifg=#d7ff5f               gui=none

hi Statement    ctermfg=111  ctermbg=none cterm=none      guifg=#87afff               gui=none

hi PreProc      ctermfg=167  ctermbg=none cterm=none      guifg=#d75f5f               gui=none
hi Define       ctermfg=134  ctermbg=none cterm=none      guifg=#af5fd7               gui=none
hi Macro        ctermfg=133  ctermbg=none cterm=none      guifg=#af5faf               gui=none
hi PreCondit    ctermfg=169  ctermbg=none cterm=none      guifg=#d75faf               gui=none

hi Type         ctermfg=228  ctermbg=none cterm=none      guifg=#ffff87               gui=none
hi StorageClass ctermfg=108  ctermbg=none cterm=none      guifg=#87af87               gui=none
hi Structure    ctermfg=110  ctermbg=none cterm=none      guifg=#87afd7               gui=none
hi Typedef      ctermfg=110  ctermbg=none cterm=none      guifg=#87afd7               gui=none

hi Special      ctermfg=194  ctermbg=none cterm=none      guifg=#e7f6da               gui=none

hi Todo         ctermfg=88   ctermbg=none cterm=bold      guifg=#8f8f8f               gui=bold
hi Error                     ctermbg=88   cterm=none                    guibg=#870000


hi Warning                   ctermbg=130  cterm=none                    guibg=#af5f00

hi SpellCap                  ctermbg=22   cterm=none                    guibg=#005f00

" Links
hi! link FoldColumn   Folded
hi! link CursorColumn CursorLine

" vim-indent-guides
hi IndentBlanklineChar                ctermfg=236  ctermbg=none cterm=none guifg=none    guibg=#343434 gui=none
hi IndentBlanklineSpaceChar           ctermfg=236  ctermbg=none cterm=none guifg=none    guibg=#343434 gui=none
hi IndentBlanklineSpaceCharBlankline  ctermfg=236  ctermbg=none cterm=none guifg=none    guibg=#343434 gui=none
hi IndentBlanklineContextChar         ctermfg=242  ctermbg=none cterm=none guifg=none    guibg=#343434 gui=none
hi IndentBlanklineContextStart        ctermfg=none ctermbg=none cterm=none guifg=none    guibg=#343434 gui=none

" LanguageClient-neovim
hi SignColumn                           ctermfg=250 ctermbg=0    cterm=bold          guifg=#808080 guibg=none    gui=italic
"hi LspDiagnosticsDefaultError
"hi LspDiagnosticsDefaultWarning
"hi LspDiagnosticsDefaultInformation
"hi LspDiagnosticsDefaultHint
hi LspDiagnosticsFloatingError          ctermfg=161                                  guifg=#808080
hi LspDiagnosticsFloatingWarning        ctermfg=221                                  guifg=#808080
hi LspDiagnosticsFloatingInformation    ctermfg=107                                  guifg=#808080
hi LspDiagnosticsFloatingHint           ctermfg=107                                  guifg=#808080
hi LspDiagnosticsUnderlineError                                  cterm=strikethrough
hi LspDiagnosticsUnderlineWarning                                cterm=undercurl
hi LspDiagnosticsUnderlineInformation                            cterm=underline
hi LspDiagnosticsUnderlineHint                                   cterm=underline
hi LspDiagnosticsVirtualTextError       ctermfg=88               cterm=italic        guifg=#808080               gui=italic
hi LspDiagnosticsVirtualTextWarning     ctermfg=94               cterm=italic        guifg=#808080               gui=italic
hi LspDiagnosticsVirtualTextInformation ctermfg=58               cterm=italic        guifg=#808080               gui=italic
hi LspDiagnosticsVirtualTextHint        ctermfg=58               cterm=italic        guifg=#808080               gui=italic
hi LspDiagnosticsSignError              ctermfg=124 ctermbg=232  cterm=bold          guifg=#af0000 guibg=#080808 gui=bold
hi LspDiagnosticsSignWarning            ctermfg=172 ctermbg=233  cterm=bold          guifg=#d78700 guibg=#121212 gui=bold
hi LspDiagnosticsSignInformation        ctermfg=64  ctermbg=234  cterm=bold          guifg=#5f8700 guibg=#1c1c1c gui=bold
hi LspDiagnosticsSignHint               ctermfg=64  ctermbg=235  cterm=bold          guifg=#5f8700 guibg=#262626 gui=bold

" idris2-nvim
hi      LspSemantic_variable              ctermfg=217  ctermbg=none cterm=none          guifg=#ffafaf               gui=none
hi      LspSemantic_enumMember            ctermfg=179  ctermbg=none cterm=none          guifg=#d7af5f               gui=none
hi      LspSemantic_function              ctermfg=229  ctermbg=none cterm=none          guifg=#ffffaf               gui=none
hi      LspSemantic_type                  ctermfg=166  ctermbg=none cterm=none          guifg=#d75f5f               gui=none
hi      LspSemantic_keyword               ctermfg=109  ctermbg=none cterm=none          guifg=#87afaf               gui=none
hi      LspSemantic_namespace             ctermfg=106  ctermbg=none cterm=none          guifg=#87af5f               gui=none
hi      LspSemantic_postulate             ctermfg=123  ctermbg=none cterm=none          guifg=#87ffff               gui=none
hi      LspSemantic_module                ctermfg=70   ctermbg=none cterm=none          guifg=#5faf00               gui=none

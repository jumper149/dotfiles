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
hi NonText      ctermfg=246  ctermbg=237  cterm=none        guifg=#808080 guibg=#303030 gui=none

" Vim >= 7.0 specific colors
if version >= 700
    hi CursorLine   ctermfg=none ctermbg=236  cterm=none                      guibg=#2d2d2d gui=none
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
hi IndentGuidesOdd  ctermbg=236               cterm=none                    guibg=#343434 gui=none
hi IndentGuidesEven ctermbg=235               cterm=none                    guibg=#282828 gui=none

" LanguageClient-neovim
hi SignColumn                   ctermfg=250 ctermbg=0    cterm=bold          guifg=#808080 guibg=none    gui=italic
hi LanguageClientError                                   cterm=strikethrough
hi LanguageClientWarning                                 cterm=undercurl
hi LanguageClientInfo                                    cterm=underline
hi LanguageClientHint                                    cterm=underline
hi LanguageClientErrorVirtual   ctermfg=88               cterm=italic        guifg=#808080               gui=italic
hi LanguageClientWarningVirtual ctermfg=94               cterm=italic        guifg=#808080               gui=italic
hi LanguageClientInfoVirtual    ctermfg=58               cterm=italic        guifg=#808080               gui=italic
hi LanguageClientHintVirtual    ctermfg=58               cterm=italic        guifg=#808080               gui=italic
hi LanguageClientErrorSign      ctermfg=124 ctermbg=232  cterm=bold          guifg=#af0000 guibg=#080808 gui=italic
hi LanguageClientWarningSign    ctermfg=172 ctermbg=233  cterm=bold          guifg=#d78700 guibg=#121212 gui=italic
hi LanguageClientInfoSign       ctermfg=64  ctermbg=234  cterm=bold          guifg=#5f8700 guibg=#1c1c1c gui=italic
hi LanguageClientHintSign       ctermfg=64  ctermbg=235  cterm=bold          guifg=#5f8700 guibg=#262626 gui=italic

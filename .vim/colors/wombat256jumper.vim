" converting for 256-color terminals by Danila Bespalov (danila.bespalov@gmail.com)
" with great help of tool by Wolfgang Frisch (xororand@frexx.de)
" inspired by David Liang's version (bmdavll@gmail.com)
" originally maintained by Lars H. Nielsen (dengmao@gmail.com)

set background=dark

hi clear

if exists("syntax_on")
	syntax reset
endif

let colors_name = "wombat256jumper"


" General colors
hi Normal		ctermfg=254		ctermbg=234		cterm=none		guifg=#f6f3e8	guibg=#242424	gui=none
hi Cursor		ctermfg=none	ctermbg=241		cterm=none						guibg=#656565	gui=none
hi Visual		ctermfg=146		ctermbg=238		cterm=none		guifg=#f6f3e8	guibg=#444444	gui=none
" hi VisualNOS
" hi Search
hi Folded		ctermfg=103		ctermbg=238		cterm=none		guifg=#a0a8b0	guibg=#384048	gui=none
hi Title		ctermfg=7		ctermbg=none	cterm=bold		guifg=#f6f3e8					gui=bold
hi StatusLine	ctermfg=7		ctermbg=238		cterm=none		guifg=#f6f3e8	guibg=#444444	gui=none
hi VertSplit	ctermfg=238		ctermbg=238		cterm=none		guifg=#444444	guibg=#444444	gui=none
hi StatusLineNC	ctermfg=243		ctermbg=238		cterm=none		guifg=#857b6f	guibg=#444444	gui=none
hi LineNr		ctermfg=243		ctermbg=0		cterm=none		guifg=#857b6f	guibg=#000000	gui=none
hi SpecialKey	ctermfg=244		ctermbg=236		cterm=none		guifg=#808080	guibg=#343434	gui=none
hi NonText		ctermfg=246		ctermbg=237		cterm=none		guifg=#808080	guibg=#303030	gui=none

" Vim >= 7.0 specific colors
if version >= 700
hi CursorLine	ctermfg=none	ctermbg=236		cterm=none						guibg=#2d2d2d	gui=none
hi MatchParen	ctermfg=52		ctermbg=243		cterm=bold		guifg=#f6f3e8	guibg=#857b6f	gui=bold
hi Pmenu		ctermfg=251		ctermbg=238		cterm=none		guifg=#f6f3e8	guibg=#444444	gui=none
hi PmenuSel		ctermfg=234		ctermbg=192		cterm=bold		guifg=#000000	guibg=#cae682	gui=bold
endif

" Syntax highlighting
hi Keyword		ctermfg=110		ctermbg=none	cterm=none		guifg=#8ac6f2					gui=none
hi Statement	ctermfg=111		ctermbg=none	cterm=none		guifg=#8ac6f2					gui=none
hi Constant		ctermfg=179		ctermbg=none	cterm=none		guifg=#e5786d					gui=none
hi Number		ctermfg=173		ctermbg=none	cterm=none		guifg=#e5786d					gui=none
hi PreProc		ctermfg=167		ctermbg=none	cterm=none		guifg=#e5786d					gui=none
hi Function		ctermfg=191		ctermbg=none	cterm=none		guifg=#cae682					gui=none
hi Identifier	ctermfg=193		ctermbg=none	cterm=none		guifg=#cae682					gui=none
hi Type			ctermfg=192		ctermbg=none	cterm=none		guifg=#cae682					gui=none
hi Special		ctermfg=194		ctermbg=none	cterm=none		guifg=#e7f6da					gui=none
hi String		ctermfg=113		ctermbg=none	cterm=none		guifg=#95e454					gui=none
hi Comment		ctermfg=246		ctermbg=none	cterm=italic	guifg=#99968b					gui=italic
hi Todo			ctermfg=88		ctermbg=none	cterm=bold		guifg=#8f8f8f					gui=bold


" Links
hi! link FoldColumn		Folded
hi! link CursorColumn	CursorLine

" vim:set ts=4 sw=4 noet:

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

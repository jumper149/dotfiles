config.load_autoconfig(False)

c.content.autoplay = False

c.scrolling.smooth = True

c.confirm_quit = [ 'multiple-tabs', 'downloads' ]

c.downloads.remove_finished = 1000
c.scrolling.bar = 'never'
c.statusbar.show = 'in-mode'
c.tabs.show = 'multiple'

c.tabs.mousewheel_switching = False



config.unbind('q') # record macro
config.unbind('d') # close tab
config.unbind('u') # restore tab

config.bind('d', 'scroll-page 0 0.5')
config.bind('<Ctrl-d>', 'scroll-page 0 0.75')
config.bind('u', 'scroll-page 0 -0.5')
config.bind('<Ctrl-u>', 'scroll-page 0 -0.75')

config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')

config.bind('q', 'tab-close')

config.bind(',P', 'spawn --userscript qute-pass --password-only')
config.bind(',p', 'spawn --userscript qute-pass')
config.bind('Z', 'spawn mpv {url}')
config.bind('z', 'hint links spawn mpv {hint-url}')
config.bind('<Ctrl-r>', 'jseval -w main DarkReader.disable()')



c.url.default_page = "http://nixbase.wireguard/searx/"
c.url.start_pages = "http://nixbase.wireguard/searx/"

c.url.searchengines['DEFAULT'] = "http://nixbase.wireguard/searx/search?q={}"
c.url.searchengines['s'] = "http://nixbase.wireguard/searx/search?q={}"
c.url.searchengines['d'] = "https://duckduckgo.com/?q={}"
c.url.searchengines['g'] = "https://www.google.com/search?hl=en&q={}"
c.url.searchengines['w'] = "https://de.wikipedia.org/w/index.php?search={}"
c.url.searchengines['y'] = "https://www.youtube.com/results?search_query={}"
c.url.searchengines['gh'] = "https://github.com/search?q={}"
c.url.searchengines['h'] = "https://hackage.haskell.org/packages/search?terms={}"
c.url.searchengines['np'] = "https://nixos.org/nixos/packages.html?query={}"
c.url.searchengines['no'] = "https://nixos.org/nixos/options.html#{}"
c.url.searchengines['aw'] = "https://wiki.archlinux.org/?search={}"
c.url.searchengines['aur'] = "https://aur.archlinux.org/packages/?O=0&K={}&SB=p&SO=d"



#c.fonts.completion.category (Current: bold default_size default_family)
#c.fonts.completion.entry (Current: default_size default_family)
#c.fonts.contextmenu (Current: )
#c.fonts.debug_console (Current: default_size default_family)
c.fonts.default_family = 'Iosevka'
c.fonts.default_size = '11pt'
#c.fonts.downloads (Current: default_size default_family)
#c.fonts.hints (Current: bold default_size default_family)
#c.fonts.keyhint (Current: default_size default_family)
#c.fonts.messages.error (Current: default_size default_family)
#c.fonts.messages.info (Current: default_size default_family)
#c.fonts.messages.warning (Current: default_size default_family)
c.fonts.prompts = 'default_size default_family'
#c.fonts.statusbar (Current: default_size default_family)
#c.fonts.tabs #(Current: default_size default_family)

# style=... isn't applied
c.fonts.web.family.standard = 'Liberation Sans'
#c.fonts.web.family.cursive = 'Liberation Sans:style=Italic'
#c.fonts.web.family.fantasy = 'Liberation Sans:style=Bold Italic'
c.fonts.web.family.fixed = 'Liberation Mono'
c.fonts.web.family.sans_serif = 'Liberation Sans'
c.fonts.web.family.serif = 'Liberation Serif'



c.colors.webpage.preferred_color_scheme = "dark"



myBackground  = '#1c1c1c'

# black
myColor0      = '#282a2e'
myColor8      = '#373b41'

# red
myColor1      = '#a54242'
myColor9      = '#cc6666'

# green
myColor2      = '#8c9440'
myColorA      = '#b5bd68'

# yellow
myColor3      = '#de935f'
myColorB      = '#f0c674'

# blue
myColor4      = '#5f819d'
myColorC      = '#81a2be'

# magenta
myColor5      = '#85678f'
myColorD      = '#b294bb'

# cyan
myColor6      = '#5e8d87'
myColorE      = '#8abeb7'

# white
myColor7      = '#707880'
myColorF      = '#c5c8c6'

def myTransparent(color, alpha):
    color = color.lstrip('#')
    r = int(color[0:2], 16)
    g = int(color[2:4], 16)
    b = int(color[4:6], 16)
    return 'rgba({r}, {g}, {b}, {alpha})'.format(r=r, g=g, b=b, alpha=alpha)

c.colors.completion.category.bg = myColor0
c.colors.completion.category.border.bottom = myColor7
c.colors.completion.category.border.top = myColor7
c.colors.completion.category.fg = myColor7
c.colors.completion.even.bg = myColor8
c.colors.completion.fg = [ myColorF , myColorE , myColorD ]
c.colors.completion.item.selected.bg = myColor2
c.colors.completion.item.selected.border.bottom = myColorA
c.colors.completion.item.selected.border.top = myColorA
c.colors.completion.item.selected.fg = myColor0
c.colors.completion.item.selected.match.fg = myColor9
c.colors.completion.match.fg = myColor9
c.colors.completion.odd.bg = myColor8
c.colors.completion.scrollbar.bg = myColor0
c.colors.completion.scrollbar.fg = myColor7

# Don't set to keep Qt defaults
#colors.contextmenu.menu.bg (Current: )
#colors.contextmenu.menu.fg (Current: )
#colors.contextmenu.selected.bg (Current: )
#colors.contextmenu.selected.fg (Current: )

c.colors.downloads.bar.bg = myColor0
c.colors.downloads.error.bg = myColor1
c.colors.downloads.error.fg = myColorF
c.colors.downloads.start.bg = myColor3
c.colors.downloads.start.fg = myColorF
c.colors.downloads.stop.bg = myColor2
c.colors.downloads.stop.fg = myColorF
#c.colors.downloads.system.bg (Current: rgb)
#c.colors.downloads.system.fg (Current: rgb)

c.colors.hints.bg = myTransparent(myColorB, 0.8)
c.colors.hints.fg = myColor0
c.colors.hints.match.fg = myColor9
c.colors.keyhint.bg = myTransparent(myColorC, 0.9)
c.colors.keyhint.fg = myColor0
c.colors.keyhint.suffix.fg = myColor1

c.colors.messages.error.bg = myTransparent(myColor9, 0.8)
c.colors.messages.error.border = myTransparent(myColor1, 0.9)
c.colors.messages.error.fg = myColor0
c.colors.messages.info.bg = myTransparent(myColorC, 0.8)
c.colors.messages.info.border = myTransparent(myColor4, 0.9)
c.colors.messages.info.fg = myColor0
c.colors.messages.warning.bg = myTransparent(myColorB, 0.8)
c.colors.messages.warning.border = myTransparent(myColor3, 0.9)
c.colors.messages.warning.fg = myColor0

c.colors.prompts.bg = myColor8
c.colors.prompts.border = '1px solid ' + myColor0
c.colors.prompts.fg = myColorF
c.colors.prompts.selected.bg = myColor0

c.colors.statusbar.caret.bg = myColor8
c.colors.statusbar.caret.fg = myColor5
c.colors.statusbar.caret.selection.bg = myColor8
c.colors.statusbar.caret.selection.fg = myColorD
c.colors.statusbar.command.bg = myColor0
c.colors.statusbar.command.fg = myColorF
c.colors.statusbar.command.private.bg = myColor8
c.colors.statusbar.command.private.fg = myColorF
c.colors.statusbar.insert.bg = myColor8
c.colors.statusbar.insert.fg = myColor2
c.colors.statusbar.normal.bg = myColor0
c.colors.statusbar.normal.fg = myColorF
c.colors.statusbar.passthrough.bg = myColor8
c.colors.statusbar.passthrough.fg = myColor4
c.colors.statusbar.private.bg = myColor8
c.colors.statusbar.private.fg = myColorF
c.colors.statusbar.progress.bg = myColor2
c.colors.statusbar.url.error.fg = myColor9
c.colors.statusbar.url.fg = myColorF
c.colors.statusbar.url.hover.fg = myColorE
c.colors.statusbar.url.success.http.fg = myColor2
c.colors.statusbar.url.success.https.fg = myColorA
c.colors.statusbar.url.warn.fg = myColorB

c.colors.tabs.bar.bg = myColor0
c.colors.tabs.even.bg = myColor8
c.colors.tabs.even.fg = myColorF
c.colors.tabs.indicator.error = myColor1
c.colors.tabs.indicator.start = myColor4
c.colors.tabs.indicator.stop = myColor2
#c.colors.tabs.indicator.system (Current: rgb)
c.colors.tabs.odd.bg = myColor0
c.colors.tabs.odd.fg = myColorF
c.colors.tabs.pinned.even.bg = myColor8
c.colors.tabs.pinned.even.fg = myColorF
c.colors.tabs.pinned.odd.bg = myColor0
c.colors.tabs.pinned.odd.fg = myColorF
c.colors.tabs.pinned.selected.even.bg = myColorA
c.colors.tabs.pinned.selected.even.fg = myColor0
c.colors.tabs.pinned.selected.odd.bg = myColorA
c.colors.tabs.pinned.selected.odd.fg = myColor0
c.colors.tabs.selected.even.bg = myColorA
c.colors.tabs.selected.even.fg = myColor0
c.colors.tabs.selected.odd.bg = myColorA
c.colors.tabs.selected.odd.fg = myColor0

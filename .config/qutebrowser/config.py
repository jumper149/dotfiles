# Still load settings configured via autoconfig.yml
config.load_autoconfig()



c.url.start_pages = "https://www.google.com"

c.url.searchengines['DEFAULT'] = "https://www.google.com/search?hl=en&q={}"
c.url.searchengines['g'] = "https://www.google.com/search?hl=en&q={}"
c.url.searchengines['d'] = "https://duckduckgo.com/?q={}"
c.url.searchengines['y'] = "https://www.youtube.com/results?search_query={}"
c.url.searchengines['aw'] = "https://wiki.archlinux.org/?search={}"
c.url.searchengines['aur'] = "https://aur.archlinux.org/packages/?O=0&K={}&SB=p&SO=d"
c.url.searchengines['w'] = "https://de.wikipedia.org/w/index.php?search={}"



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

c.colors.hints.bg = myTransparent(myColorB, 0.5)
c.colors.hints.fg = myColor0
c.colors.hints.match.fg = myColor9
c.colors.keyhint.bg = myTransparent(myColorC, 0.5)
c.colors.keyhint.fg = myColor0
c.colors.keyhint.suffix.fg = myColor9

c.colors.messages.error.bg = myTransparent(myColor9, 0.7)
c.colors.messages.error.border = myTransparent(myColor1, 0.85)
c.colors.messages.error.fg = myColor0
c.colors.messages.info.bg = myTransparent(myColorC, 0.7)
c.colors.messages.info.border = myTransparent(myColor4, 0.85)
c.colors.messages.info.fg = myColor0
c.colors.messages.warning.bg = myTransparent(myColorB, 0.7)
c.colors.messages.warning.border = myTransparent(myColor3, 0.85)
c.colors.messages.warning.fg = myColor0

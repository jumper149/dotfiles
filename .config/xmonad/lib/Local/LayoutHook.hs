module Local.LayoutHook where

import XMonad
import XMonad.Hooks.ManageDocks ( avoidStruts
                                )
import XMonad.Layout.Decoration ( Theme (..)
                                , shrinkText
                                )
import XMonad.Layout.NoBorders ( noBorders
                               )
import XMonad.Layout.PerWorkspace ( onWorkspace
                                  )
import XMonad.Layout.Spacing ( Border (..)
                             , spacingRaw
                             )
import XMonad.Layout.Tabbed ( tabbed
                            )

import Local.Color
import Local.Workspace

myTabTheme :: Theme
myTabTheme = def { activeColor         = color2 colors
                 , inactiveColor       = color0 colors
                 , urgentColor         = color3 colors
                 , activeBorderColor   = color2 colors
                 , inactiveBorderColor = color0 colors
                 , urgentBorderColor   = color3 colors
                 , activeTextColor     = color0 colors
                 , inactiveTextColor   = color7 colors
                 , urgentTextColor     = color0 colors
                 , fontName            = "xft:Inconsolata:size=12:style=Bold:antialias=true"
                 }

myMainLayout =   avoidStruts tiled
             ||| avoidStruts (Mirror tiled)
             ||| noBorders Full
  where tiled = spacingRaw False
                  (Border outer outer outer outer) True
                  (Border inner inner inner inner) True
                   --     n   increment ratio
                  (Tall   1   (3/100)   (1/2))
        outer = 20
        inner = 10

myBrowserLayout =   avoidStruts (noBorders (tabbed shrinkText myTabTheme))
                ||| noBorders Full

myWritingLayout =   myMainLayout
                ||| avoidStruts single
  where single = spacingRaw False
                   (Border topbot topbot sides sides) True
                   (Border 0      0      0     0    ) False
                   Full
        topbot = 100
        sides  = 450

myLayoutHook = onWorkspace (show WsBrowser) myBrowserLayout
             . onWorkspace (show WsWriting) myWritingLayout
             $ myMainLayout

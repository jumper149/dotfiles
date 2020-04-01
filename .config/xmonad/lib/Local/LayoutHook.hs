{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

module Local.LayoutHook ( myLayoutHook
                        ) where

import XMonad
import XMonad.Hooks.ManageDocks ( avoidStruts
                                )
import XMonad.Layout.Decoration ( shrinkText
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

import Local.Layout
import Local.Workspace

myMainLayout = avoidStruts tiled
          |||| avoidStruts (Mirror tiled)
          |||| noBorders Full
  where tiled = spacingRaw False
                  (Border outer outer outer outer) True
                  (Border inner inner inner inner) True
                   --     n   increment ratio
                  (Tall   1   (3/100)   (1/2))
        outer = 20
        inner = 10

myBrowserLayout = avoidStruts (noBorders (tabbed shrinkText myTabTheme))
             |||| noBorders Full

myWritingLayout = myMainLayout
             |||| avoidStruts single
  where single = spacingRaw False
                   (Border topbot topbot sides sides) True
                   (Border 0      0      0     0    ) False
                   Full
        topbot = 100
        sides  = 450

myLayoutHook = onWorkspace (show WsBrowser) myBrowserLayout
             . onWorkspace (show WsWriting) myWritingLayout
             $ myMainLayout

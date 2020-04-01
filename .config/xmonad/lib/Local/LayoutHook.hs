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
import XMonad.Layout.Tabbed ( tabbed
                            )

import Local.Layout
import Local.Workspace

basicLayout = avoidStruts spacedTall
         |||| avoidStruts (Mirror spacedTall)
         |||| noBorders Full

browserLayout = avoidStruts (noBorders (tabbed shrinkText tabTheme))
           |||| noBorders Full

writingLayout = basicLayout -- TODO add other layouts

myLayoutHook = onWorkspace (show WsBrowser) browserLayout
             . onWorkspace (show WsWriting) writingLayout
             $ basicLayout

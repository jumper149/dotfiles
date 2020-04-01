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
import XMonad.Layout.Tabbed ( tabbed
                            )

import Local.Layout ( (||||)
                    , wsLayout
                    , spacedTall
                    , tabTheme
                    )
import Local.Workspace ( Workspace (..)
                       )

basicLayout = avoidStruts spacedTall
         |||| avoidStruts (Mirror spacedTall)
         |||| noBorders Full

browserLayout = avoidStruts (noBorders (tabbed shrinkText tabTheme))
           |||| noBorders Full

writingLayout = basicLayout

otherLayout = basicLayout

myLayoutHook = wsLayout WsBrowser browserLayout
             . wsLayout WsWriting writingLayout
             . wsLayout WsOther   otherLayout
             $ basicLayout

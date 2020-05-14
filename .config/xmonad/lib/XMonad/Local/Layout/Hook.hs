{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

module Local.Layout.Hook ( myLayoutHook
                         ) where

import XMonad.Layout.Magnifier ( magnifierOff
                               )
import XMonad.Hooks.ManageDocks ( avoidStruts
                                )
import XMonad.Layout.NoBorders ( noBorders
                               )

import Local.Config.Workspace ( Workspace (..)
                              )
import Local.Layout.Choose ( (-|||-)
                           )
import Local.Layout.Util ( wsLayout
                         , space
                         , spaceTabbed
                         , myToggled
                         , myMastered
                         , myTall
                         , myTabbed
                         , mySpacedAlwaysTabbed
                         , mySpacedTabbed
                         )

basicLayout = magnifierOff (avoidStruts (space 20 10 myTall))
        -|||- avoidStruts (spaceTabbed 20 10 mySpacedAlwaysTabbed)
        -|||- avoidStruts (spaceTabbed 20 10 (myMastered mySpacedTabbed))

browserLayout = avoidStruts (noBorders myTabbed)

myLayoutHook = myToggled $ wsLayout WsBrowser browserLayout
                         $ basicLayout

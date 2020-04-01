{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

module Local.Layout.Hook ( myLayoutHook
                         ) where

import XMonad
import XMonad.Hooks.ManageDocks ( avoidStruts
                                )
import XMonad.Layout.NoBorders ( noBorders
                               )

import Local.Layout.Choose ( (-|||-)
                           )
import Local.Layout.Util ( wsLayout
                         , space
                         , spaceTabbed
                         , myMastered
                         , myTall
                         , myTabbed
                         , mySpacedTabbed
                         )
import Local.Workspace ( Workspace (..)
                       )

basicLayout = avoidStruts (space 20 10 myTall)
        -|||- avoidStruts (spaceTabbed 20 10 (myMastered mySpacedTabbed))
        -|||- avoidStruts (Mirror (space 20 10 myTall))
        -|||- noBorders Full

browserLayout = avoidStruts (noBorders myTabbed)
          -|||- noBorders Full

myLayoutHook = wsLayout WsBrowser browserLayout
             $ basicLayout

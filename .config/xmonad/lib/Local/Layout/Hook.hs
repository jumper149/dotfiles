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
                         , myMastered
                         , myTall
                         , myTabbed
                         )
import Local.Workspace ( Workspace (..)
                       )

basicLayout = avoidStruts (space myTall)
        -|||- avoidStruts (Mirror (space myTall))
        -|||- noBorders Full

browserLayout = avoidStruts (noBorders myTabbed)
          -|||- noBorders Full

writingLayout = basicLayout

otherLayout = avoidStruts (myMastered (noBorders myTabbed))
        -|||- basicLayout

myLayoutHook = wsLayout WsBrowser browserLayout
             . wsLayout WsWriting writingLayout
             . wsLayout WsOther   otherLayout
             $ basicLayout

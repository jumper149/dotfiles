module Local.StartupHook ( myStartupHook
                         ) where

import XMonad
import qualified XMonad.StackSet as S

import Local.Workspace

myStartupHook :: X ()
myStartupHook = windows . S.greedyView $ show WsHacking

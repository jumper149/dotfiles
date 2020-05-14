module XMonad.Local.Log.Hook ( myLogHook
                             ) where

import XMonad
import XMonad.Hooks.DynamicLog ( dynamicLogWithPP
                               )

import GHC.IO.Handle ( Handle
                     )

import XMonad.Local.Log.XMobar ( myXMobarPP
                               )

myLogHook :: Handle -> X ()
myLogHook = dynamicLogWithPP . myXMobarPP

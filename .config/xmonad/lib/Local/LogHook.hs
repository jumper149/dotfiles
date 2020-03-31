module Local.LogHook ( myLogHook
                     ) where

import XMonad
import XMonad.Hooks.DynamicLog ( dynamicLogWithPP
                               )

import GHC.IO.Handle ( Handle
                     )

import Local.XMobar ( myPP
                    )

myLogHook :: Handle -> X ()
myLogHook = dynamicLogWithPP . myPP

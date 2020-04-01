module Local.Log.Hook ( myLogHook
                      ) where

import XMonad
import XMonad.Hooks.DynamicLog ( dynamicLogWithPP
                               )

import GHC.IO.Handle ( Handle
                     )

import Local.Log.XMobar ( myPP
                        )

myLogHook :: Handle -> X ()
myLogHook = dynamicLogWithPP . myPP

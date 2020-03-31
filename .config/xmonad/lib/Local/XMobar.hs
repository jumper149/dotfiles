module Local.XMobar ( myPP
                    , spawnXMobar
                    ) where

import XMonad
import XMonad.Hooks.DynamicLog ( PP (..)
                               , xmobarPP
                               )
import XMonad.Util.Run ( hPutStrLn
                       , spawnPipe
                       )

import Data.List ( intercalate
                 )
import GHC.IO.Handle ( Handle
                     )

spawnXMobar :: MonadIO m => m Handle
spawnXMobar = spawnPipe $ intercalate " " [ executable
                                          , flagIconroot
                                          , fileXMobarRc
                                          ]
    where executable = "xmobar"
          flagIconroot = "--iconroot=" <> xMobarConfigHome <> "/icons" -- can't be set with relative path in xmobarrc
          fileXMobarRc = xMobarConfigHome <> "/xmobarrc"
          xMobarConfigHome = "\"${XDG_CONFIG_HOME}\"/xmobar"

myPP :: Handle -> PP
myPP h = xmobarPP { ppOutput          = hPutStrLn h
                  , ppOrder           = \ (wss:_) -> [wss]
                  , ppWsSep           = ""
                  , ppCurrent         = xmobarWsPrep "current"
                  , ppVisible         = xmobarWsPrep "visible"
                  , ppUrgent          = xmobarWsPrep "urgent"
                  , ppHidden          = xmobarWsPrep "hidden"
                  , ppHiddenNoWindows = xmobarWsPrep "hiddenNoWindows"
                  }

xmobarWsPrep :: String -> WorkspaceId -> String
xmobarWsPrep status = clickableIcon status . take 1

clickableIcon :: String -> WorkspaceId -> String
clickableIcon status ws = let n = take 1 ws
                          in "<action=xdotool key super+" <> n <> ">" <>
                             "<icon=workspaces/" <> status <> "/workspace_" <> n <> ".xpm/>" <>
                             "</action>"

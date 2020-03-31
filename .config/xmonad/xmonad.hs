import XMonad hiding ( Color -- imports modules: Main, Core, Config, Layout, ManageHook, Operations
                     )
import qualified XMonad.StackSet as S
import XMonad.Actions.SpawnOn ( manageSpawn
                              )
import XMonad.Hooks.ManageDocks ( docks
                                )
import XMonad.Hooks.EwmhDesktops ( ewmh
                                 )

import Local.Color ( Colors (..)
                   , Color
                   , colors
                   )
import Local.Keys ( myApplyKeys
                  )
import Local.LayoutHook ( myLayoutHook
                        )
import Local.LogHook ( myLogHook
                     )
import Local.ManageHook ( myManageHook
                        )
import Local.Workspace ( Workspace (..)
                       )
import Local.XMobar ( spawnXMobar
                    )


myNormalBorderColor :: Color
myNormalBorderColor = color7 colors

myFocusedBorderColor :: Color
myFocusedBorderColor = color2 colors

myWorkspaces :: [WorkspaceId]
myWorkspaces = show <$> wss
    where wss = [ minBound .. maxBound ] :: [Workspace]

myStartupHook :: X ()
myStartupHook = windows . S.greedyView $ show WsHacking

main :: IO ()
main = do xmproc <- spawnXMobar
          let c = def { borderWidth        = 4
                      , normalBorderColor  = myNormalBorderColor
                      , focusedBorderColor = myFocusedBorderColor
                      , workspaces         = myWorkspaces
                      , layoutHook         = myLayoutHook
                      , manageHook         = myManageHook <+> manageSpawn <+> manageHook def
                      , startupHook        = myStartupHook
                      , logHook            = myLogHook xmproc
                      , focusFollowsMouse  = False
                      , modMask            = mod4Mask
                      , terminal           = "kitty"
                      }
              fc = myApplyKeys . docks . ewmh $ c
          xmonad fc

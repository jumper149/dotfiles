import XMonad hiding ( Color -- imports modules: Main, Core, Config, Layout, ManageHook, Operations
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
import Local.StartupHook ( myStartupHook
                         )
import Local.UrgencyHook ( applyUrgencyHook
                         )
import Local.Workspace ( workspaceIds
                       )
import Local.XMobar ( spawnXMobar
                    )


myNormalBorderColor :: Color
myNormalBorderColor = color7 colors

myFocusedBorderColor :: Color
myFocusedBorderColor = color2 colors

main :: IO ()
main = do xmproc <- spawnXMobar
          let c = def { borderWidth        = 4
                      , normalBorderColor  = myNormalBorderColor
                      , focusedBorderColor = myFocusedBorderColor
                      , workspaces         = workspaceIds
                      , layoutHook         = myLayoutHook
                      , manageHook         = myManageHook
                      , startupHook        = myStartupHook
                      , logHook            = myLogHook xmproc
                      , focusFollowsMouse  = False
                      , modMask            = mod4Mask
                      , terminal           = "kitty"
                      }
              fc = myApplyKeys . docks . applyUrgencyHook . ewmh $ c
          xmonad fc

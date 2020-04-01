import XMonad hiding ( Color -- imports modules: Main, Core, Config, Layout, ManageHook, Operations
                     )
import XMonad.Hooks.ManageDocks ( docks
                                )
import XMonad.Hooks.EwmhDesktops ( ewmh
                                 )

import Local.Border ( BorderTheme (..)
                    , myBorderTheme
                    )
import Local.Keys ( applyKeys
                  )
import Local.Layout.Hook ( myLayoutHook
                         )
import Local.Log.Hook ( myLogHook
                      )
import Local.Log.XMobar ( spawnXMobar
                        )
import Local.Manage.Hook ( myManageHook
                         )
import Local.Startup.Hook ( myStartupHook
                          )
import Local.UrgencyHook ( applyUrgencyHook
                         )
import Local.Workspace ( workspaceIds
                       )

main :: IO ()
main = do xmproc <- spawnXMobar
          let c = def { borderWidth        = borderWidth' myBorderTheme
                      , normalBorderColor  = inactiveBorderColor myBorderTheme
                      , focusedBorderColor = activeBorderColor myBorderTheme
                      , workspaces         = workspaceIds
                      , layoutHook         = myLayoutHook
                      , manageHook         = myManageHook
                      , startupHook        = myStartupHook
                      , logHook            = myLogHook xmproc
                      , focusFollowsMouse  = False
                      , modMask            = mod4Mask
                      , terminal           = "kitty"
                      }
              fc = applyKeys . docks . applyUrgencyHook . ewmh $ c
          xmonad fc

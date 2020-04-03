import XMonad hiding ( Color -- imports modules: Main, Core, Config, Layout, ManageHook, Operations
                     )
import XMonad.Hooks.ManageDocks ( docks
                                )
import XMonad.Hooks.EwmhDesktops ( ewmh
                                 )

import Local.Bindings.Bind ( mapBindings
                           , storeBindings
                           )
import Local.Bindings.Keys ( myKeys
                           )
import qualified Local.Config.Theme as T
import Local.Config.Workspace ( workspaceIds
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
import Local.Urgency.Hook ( applyUrgencyHook
                          )

main :: IO ()
main = do xmproc <- spawnXMobar
          let (applicableKeys , explainableBindings) = mapBindings $ myKeys . modMask
              c = def { borderWidth        = T.borderWidth T.myTheme
                      , normalBorderColor  = T.inactiveBorderColor T.myTheme
                      , focusedBorderColor = T.activeBorderColor T.myTheme
                      , terminal           = "kitty"
                      , focusFollowsMouse  = False
                      , clickJustFocuses   = False
                      , modMask            = mod4Mask
                      , keys               = applicableKeys
                      , workspaces         = workspaceIds
                      , layoutHook         = myLayoutHook
                      , manageHook         = myManageHook
                      , startupHook        = myStartupHook
                      , logHook            = myLogHook xmproc
                      }
              fc = storeBindings explainableBindings . docks . applyUrgencyHook . ewmh $ c
          xmonad fc

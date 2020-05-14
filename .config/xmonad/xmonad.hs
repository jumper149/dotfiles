import XMonad hiding ( Color -- imports modules: Main, Core, Config, Layout, ManageHook, Operations
                     )
import XMonad.Hooks.ManageDocks ( docks
                                )
import XMonad.Hooks.EwmhDesktops ( ewmh
                                 )

import XMonad.Local.Bindings.Bind ( mapBindings
                                  , storeBindings
                                  )
import XMonad.Local.Bindings.Keys ( myKeys
                                  )
import qualified XMonad.Local.Config.Theme as T
import XMonad.Local.Config.Workspace ( workspaceIds
                                     )
import XMonad.Local.Layout.Hook ( myLayoutHook
                                )
import XMonad.Local.Log.Hook ( myLogHook
                             )
import XMonad.Local.Log.XMobar ( spawnXMobar
                               )
import XMonad.Local.Manage.Hook ( myManageHook
                                )
import XMonad.Local.Startup.Hook ( myStartupHook
                                 )
import XMonad.Local.Urgency.Hook ( applyUrgencyHook
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

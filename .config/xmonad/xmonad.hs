import XMonad hiding ( Color -- imports modules: Main, Core, Config, Layout, ManageHook, Operations
                     )
import qualified XMonad.StackSet as S
import XMonad.Actions.SpawnOn ( manageSpawn
                              )
import XMonad.Layout.NoBorders ( noBorders
                               )
import XMonad.Layout.Spacing ( Border (..)
                             , spacingRaw
                             )
import XMonad.Layout.PerWorkspace ( onWorkspace
                                  )
import XMonad.Layout.Decoration ( Theme (..)
                                , shrinkText
                                )
import XMonad.Layout.Tabbed ( tabbed
                            )
import XMonad.Hooks.ManageDocks ( docks
                                , avoidStruts
                                )
import XMonad.Hooks.EwmhDesktops ( ewmh
                                 )

import Local.Color ( Colors (..)
                   , Color
                   , colors
                   )
import Local.Keys ( myApplyKeys
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

myTabTheme :: Theme
myTabTheme = def { activeColor         = color2 colors
                 , inactiveColor       = color0 colors
                 , urgentColor         = color3 colors
                 , activeBorderColor   = color2 colors
                 , inactiveBorderColor = color0 colors
                 , urgentBorderColor   = color3 colors
                 , activeTextColor     = color0 colors
                 , inactiveTextColor   = color7 colors
                 , urgentTextColor     = color0 colors
                 , fontName            = "xft:Inconsolata:size=12:style=Bold:antialias=true"
                 }

myMainLayout =   avoidStruts tiled
             ||| avoidStruts (Mirror tiled)
             ||| noBorders Full
  where tiled = spacingRaw False
                  (Border outer outer outer outer) True
                  (Border inner inner inner inner) True
                   --     n   increment ratio
                  (Tall   1   (3/100)   (1/2))
        outer = 20
        inner = 10

myBrowserLayout =   avoidStruts (noBorders (tabbed shrinkText myTabTheme))
                ||| noBorders Full

myWritingLayout =   myMainLayout
                ||| avoidStruts single
  where single = spacingRaw False
                   (Border topbot topbot sides sides) True
                   (Border 0      0      0     0    ) False
                   Full
        topbot = 100
        sides  = 450

myLayoutHook = onWorkspace (show WsBrowser) myBrowserLayout
             . onWorkspace (show WsWriting) myWritingLayout
             $ myMainLayout


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

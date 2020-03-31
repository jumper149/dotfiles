import XMonad hiding ( Color -- imports modules: Main, Core, Config, Layout, ManageHook, Operations
                     )
import XMonad.Actions.CycleWS ( nextWS
                              , prevWS
                              )
import XMonad.Actions.SpawnOn ( manageSpawn
                              , spawnOn
                              )
import XMonad.Layout.NoBorders ( noBorders
                               )
import XMonad.Layout.Spacing ( Border (..)
                             , spacingRaw
                             , toggleWindowSpacingEnabled
                             , toggleScreenSpacingEnabled
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
import XMonad.Util.EZConfig ( additionalKeysP
                            , removeKeysP
                            )
import XMonad.Hooks.EwmhDesktops ( ewmh
                                 )

import qualified XMonad.StackSet as W

import Local.Color ( Colors (..)
                   , Color
                   , colors
                   )
import Local.LogHook ( myLogHook
                     )
import Local.ManageHook ( myManageHook
                        )
import Local.Workspace ( Workspace (..)
                       )
import Local.XMobar ( spawnXMobar
                    )


myBorderWidth :: Dimension
myBorderWidth = 4 :: Dimension

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


myKeys :: [(String , X ())]
myKeys = [ ("M-S-q"         , kill)
         , ("M-S-<Return>"  , windows W.swapMaster)
         , ("M-<Up>"        , windows W.focusUp)
         , ("M-<Down>"      , windows W.focusDown)
         , ("M-S-<Up>"      , windows W.swapUp)
         , ("M-S-<Down>"    , windows W.swapDown)
         , ("M-S-h"         , sendMessage Shrink)
         , ("M-S-l"         , sendMessage Expand)
         , ("M-<Backspace>" , withFocused $ windows . W.sink)
         , ("M-S-t"         , toggleWindowSpacingEnabled >> toggleScreenSpacingEnabled)
         , ("M-<Tab>"       , nextWS)
         , ("M-S-<Tab>"     , prevWS)
         , ("M-h"           , screenWorkspace 0 >>= flip whenJust (windows . W.view))
         , ("M-<Left>"      , screenWorkspace 0 >>= flip whenJust (windows . W.view))
         , ("M-l"           , screenWorkspace 1 >>= flip whenJust (windows . W.view))
         , ("M-<Right>"     , screenWorkspace 1 >>= flip whenJust (windows . W.view))

         , ("M-S-r"         , restart "xmonad" True)
         , ("M-S-e"         , spawn "${XMONAD_CONFIG_DIR}/bin/shutdown")
         , ("M-S-w"         , spawn "i3lock -c '000000' -f")

         , ("M-S-a"         , spawn "cyclexkbmap")

         , ("M-C-\\"        , spawn "brightness up")
         , ("M-C-/"         , spawn "brightness down")

         , ("M-C--"                    , spawn "volume down")
         , ("M-<XF86AudioLowerVolume>" , spawn "volume down")
         , ("M-C-S-="                  , spawn "volume up")
         , ("M-<XF86AudioRaiseVolume>" , spawn "volume up")
         , ("M-C-0"             , spawn "volume mute")
         , ("M-<XF86AudioMute>" , spawn "volume mute")
         , ("M-C-]"               , spawn "volume mic mute")
         , ("M-<XF86AudioMicMute" , spawn "volume mic mute")

         , ("M-C-p"             , spawn "mpc toggle")
         , ("M-<XF86AudioPlay>" , spawn "mpc toggle")
         , ("<XF86AudioPlay>"   , spawn "mpc toggle")
         , ("M-C-o"             , spawn "mpc stop")
         , ("M-<XF86AudioStop>" , spawn "mpc stop")
         , ("<XF86AudioStop>"   , spawn "mpc stop")
         , ("M-C-["             , spawn "mpc next")
         , ("M-<XF86AudioNext>" , spawn "mpc next")
         , ("<XF86AudioNext>"   , spawn "mpc next")
         , ("M-C-i"             , spawn "mpc prev")
         , ("M-<XF86AudioPrev>" , spawn "mpc prev")
         , ("<XF86AudioPrev>"   , spawn "mpc prev")
         , ("M-<Print>"     , spawn "scrot")
         , ("<Print>"       , spawn "scrot")
         , ("M-C-m"         , spawnOn (show WsOther) . inTerminal $ "offlineimap")

         , ("M-<Return>"    , spawn myTerminal)
         , ("M-d"           , spawn "rofi -show run")
         , ("M-r"           , spawn . inTerminal $ "ranger")

         , ("M-f"           , spawnOnAndGoTo WsBrowser "firefox")
         , ("M-n"           , spawnOnAndGoTo WsMedia $ inTerminal "ncmpcpp")
         , ("M-t"           , spawnOnAndGoTo WsSocial "telegram-desktop")
         , ("M-m"           , spawnOnAndGoTo WsSocial $ inTerminal "mutt")
         , ("M-w"           , spawnOnAndGoTo WsSocial $ inTerminal "weechat")
         , ("M-g"           , spawnOnAndGoTo WsGIMP "gimp")
         , ("M-p"           , spawnOnAndGoTo WsControl "pavucontrol")
         , ("M-x"           , spawnOnAndGoTo WsControl "arandr")
         , ("M-b"           , spawnOnAndGoTo WsOther "baobab")
         ]
  where inTerminal :: String -> String
        inTerminal prog = myTerminal ++ " --name '" ++ prog ++ "' -e '" ++ prog ++ "'"

        -- requires _NET_WM_PID to be set on creation; doesn't work on:
        --   urxvtc(offlineimap), qutebrowser, chromium
        spawnOnAndGoTo :: Workspace -> String -> X ()
        spawnOnAndGoTo ws prog = do spawnOn wsId prog
                                    windows . W.greedyView $ wsId
            where wsId = show ws

myRemovedKeys :: [String]
myRemovedKeys = [ "M-q"   -- quit
                , "M-S-q" -- restart
                , "M-w"   -- Xinerama 1
                , "M-S-w"
                , "M-e"   -- Xinerama 2
                , "M-S-e"
                , "M-r"   -- Xinerama 3
                , "M-S-r"
                , "M-h"   -- resize master area
                , "M-l"
                , "M-t"   -- tile floating window
                , "M-n"   -- refresh viewed sizes
                , "M-c"   -- close window
                , "M-m"   -- focus master window
                ]

myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False :: Bool

myModMask :: ButtonMask
myModMask = mod4Mask :: ButtonMask

myTerminal :: String
myTerminal = "kitty" :: String

myApplyKeys :: XConfig l -> XConfig l
myApplyKeys = (`additionalKeysP` myKeys) . (`removeKeysP` myRemovedKeys)


myStartupHook :: X ()
myStartupHook = windows . W.greedyView $ show WsHacking


main :: IO ()
main = do xmproc <- spawnXMobar
          let c = def { borderWidth        = myBorderWidth
                      , normalBorderColor  = myNormalBorderColor
                      , focusedBorderColor = myFocusedBorderColor
                      , workspaces         = myWorkspaces
                      , layoutHook         = myLayoutHook
                      , manageHook         = myManageHook <+> manageSpawn <+> manageHook def
                      , startupHook        = myStartupHook
                      , logHook            = myLogHook xmproc
                      , focusFollowsMouse  = myFocusFollowsMouse
                      , modMask            = myModMask
                      , terminal           = myTerminal
                      }
              fc = myApplyKeys . docks . ewmh $ c
          xmonad fc

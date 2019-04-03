import XMonad
import XMonad.Core
import XMonad.Actions.CycleWindows
import XMonad.Actions.CycleWS
import XMonad.Actions.SpawnOn
import XMonad.Actions.CopyWindow
import XMonad.Layout                  -- unnecassary
import XMonad.Layout.NoBorders
import XMonad.Layout.Spacing
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Decoration
import XMonad.Layout.Tabbed
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageHelpers     -- for doCenterFloat

import System.Posix.Unistd            -- for hostname

import qualified XMonad.StackSet as W


-- black
myColor0 = "#282a2e"
myColor8 = "#373b41"

-- red
myColor1 = "#a54242"
myColor9 = "#cc6666"

-- green
myColor2 = "#8c9440"
myColorA = "#b5bd68"

-- yellow
myColor3 = "#de935f"
myColorB = "#f0c674"

-- blue
myColor4 = "#5f819d"
myColorC = "#81a2be"

-- magenta
myColor5 = "#85678f"
myColorD = "#b294bb"

-- cyan
myColor6 = "#5e8d87"
myColorE = "#8abeb7"

-- white
myColor7 = "#707880"
myColorF = "#c5c8c6"


myBorderWidth        = 4
myNormalBorderColor  = myColor7
myFocusedBorderColor = myColor2

myWorkspaces         = [ "1 Browser"
                       , "2 Hacking"
                       , "3 Media"
                       , "4 Social"
                       , "5 Writing"
                       , "6 GIMP"
                       , "7 Gaming"
                       , "8 Control"
                       , "9 Other"
                       ]

myTabTheme           = def { activeColor         = myColor2
                           , inactiveColor       = myColor0
                           , urgentColor         = myColor3
                           , activeBorderColor   = myColor2
                           , inactiveBorderColor = myColor0
                           , urgentBorderColor   = myColor3
                           , activeTextColor     = myColor0
                           , inactiveTextColor   = myColor7
                           , urgentTextColor     = myColor0
                           , fontName            = "xft:Inconsolata:size=12:style=Bold:antialias=true"
                           }

myMainLayout         =   avoidStruts tiled
                     ||| avoidStruts (Mirror tiled)
                     ||| noBorders Full
  where tiled = spacingRaw False
                   (Border outer outer outer outer) True
                   (Border inner inner inner inner) True
                  --     n   increment ratio
                $ Tall   1   (3/100)   (1/2)
        outer = 20
        inner = 10

myBrowserLayout      =   avoidStruts (noBorders (tabbed shrinkText myTabTheme))
                     ||| noBorders Full

myWritingLayout      =   myMainLayout
                     ||| avoidStruts single
  where single = spacingRaw False
                   (Border topbot topbot sides sides) True
                   (Border 0      0      0     0    ) False
                 $ Full
        topbot = 100
        sides  = 450

myLayoutHook         = onWorkspace "1 Browser" myBrowserLayout
                     $ onWorkspace "5 Writing" myWritingLayout
                     $ myMainLayout

myManageHook         = composeAll
                         [ className =? "matplotlib"     --> doCenterFloat
                         , className =? "Gnuplot"        --> doCenterFloat
                         , className =? "gnuplot_qt"     --> doCenterFloat
                         , appName   =? "offlineimap"    --> doShift "8 Control" <+> doCenterFloat
                         , className =? "Pinentry-gtk-2" --> doF copyToAll
                         ]


myLogHook host h h2  = if host == "deskarch" then
                           do  dynamicLogWithPP $
                                 xmobarPP
                                   { ppOutput           = hPutStrLn h
                                   , ppOrder            = \(workspaces:layout:title:_) -> [workspaces]
                                   , ppWsSep            = ""
                                   , ppCurrent          = xmobarColor myColor0 myColor2 . clickable
                                   , ppVisible          = xmobarColor myColor0 myColor7 . clickable
                                   , ppUrgent           = xmobarColor myColor0 myColor3 . clickable
                                   , ppHidden           = xmobarColor myColorF ""       . clickable
                                   , ppHiddenNoWindows  = xmobarColor myColor7 ""       . clickable
                                   }
                               dynamicLogWithPP $
                                 xmobarPP
                                   { ppOutput           = hPutStrLn h2
                                   , ppOrder            = \(workspaces:layout:title:_) -> [title]
                                   , ppTitle            = xmobarColor myColorF myColor0 . wrap " " " " . shorten 128
                                   }
                       else
                           do  dynamicLogWithPP $
                                 xmobarPP
                                   { ppOutput           = hPutStrLn h
                                   , ppOrder            = \(workspaces:layout:title:_) -> [workspaces]
                                   , ppWsSep            = ""
                                   , ppCurrent          = xmobarColor myColor0 myColor2 . clickable . take 1
                                   , ppVisible          = xmobarColor myColor0 myColor7 . clickable . take 1
                                   , ppUrgent           = xmobarColor myColor0 myColor3 . clickable . take 1
                                   , ppHidden           = xmobarColor myColorF ""       . clickable . take 1
                                   , ppHiddenNoWindows  = xmobarColor myColor7 ""       . clickable . take 1
                                   }


myFocusFollowsMouse  = False
myModMask            = mod4Mask
myKeys               = [ ("M-S-q"         , kill)
                       , ("M-S-<Return>"  , windows W.swapMaster)
                       , ("M-<Up>"        , windows W.focusUp)
                       , ("M-<Down>"      , windows W.focusDown)
                       , ("M-S-<Up>"      , windows W.swapUp)
                       , ("M-S-<Down>"    , windows W.swapDown)
                       , ("M-S-h"         , sendMessage Shrink)
                       , ("M-S-l"         , sendMessage Expand)
                       , ("M-<Backspace>" , withFocused $ windows . W.sink)
                       , ("M-S-t"         , do
                                                toggleWindowSpacingEnabled
                                                toggleScreenSpacingEnabled)
                       , ("M-<Tab>"       , nextWS)
                       , ("M-S-<Tab>"     , prevWS)
                       , ("M-h"           , screenWorkspace 0 >>= flip whenJust (windows . W.view))
                       , ("M-<Left>"      , screenWorkspace 0 >>= flip whenJust (windows . W.view))
                       , ("M-l"           , screenWorkspace 1 >>= flip whenJust (windows . W.view))
                       , ("M-<Right>"     , screenWorkspace 1 >>= flip whenJust (windows . W.view))

                       , ("M-S-r"         , restart "xmonad" True)
                       , ("M-S-e"         , spawn "~/.xmonad/scripts/shutdown.sh")
                       , ("M-S-w"         , spawn "i3lock -c '000000' -f --script")

                       , ("M-C-\\"        , spawn "~/.scripts/brightness/up.sh")
                       , ("M-C-/"         , spawn "~/.scripts/brightness/down.sh")

                       , ("M-C-="         , spawn "~/.config/i3/scripts/volume_up.sh")
                       , ("M-C--"         , spawn "~/.config/i3/scripts/volume_down.sh")
                       , ("M-C-0"         , spawn "~/.config/i3/scripts/volume_mute.sh")
                       , ("M-C-]"         , spawn "~/.config/i3/scripts/volume_mute_mic.sh")

                       , ("M-C-p"         , spawn "mpc toggle")
                       , ("M-C-o"         , spawn "mpc stop")
                       , ("M-C-["         , spawn "mpc next")
                       , ("M-C-i"         , spawn "mpc prev")
                       , ("M-C-<Print>"   , spawn "scrot")
                       , ("M-C-k"         , spawn "~/.scripts/screenkey.sh")
                       , ("M-C-m"         , spawnOn "8 Control" $ inTerminal "offlineimap")

                       , ("M-<Return>"    , spawn myTerminal)
                       , ("M-d"           , spawn "rofi -show run")
                       , ("M-r"           , runInTerm "" "ranger")

                       , ("M-q"           , spawnOnAndGoTo "1 Browser" "qutebrowser")
                       , ("M-c"           , spawnOnAndGoTo "1 Browser" "chromium")
                       , ("M-n"           , spawnOnAndGoTo "3 Media" $ inTerminal "ncmpcpp")
                       , ("M-t"           , spawnOnAndGoTo "4 Social" "telegram-desktop")
                       , ("M-m"           , spawnOnAndGoTo "4 Social" $ inTerminal "mutt")
                       , ("M-i"           , spawnOnAndGoTo "4 Social" $ inTerminal "irssi")
                       , ("M-g"           , spawnOnAndGoTo "6 GIMP" "gimp")
                       , ("M-p"           , spawnOnAndGoTo "8 Control" "pavucontrol")
                       , ("M-x"           , spawnOnAndGoTo "8 Control" "arandr")
                       , ("M-b"           , spawnOnAndGoTo "9 Other" "baobab")
                       ]
myRemovedKeys          = [ "M-q"   -- quit
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


myTerminal           = "urxvtc"


myStartupHook        = do (windows . W.greedyView) "2 Hacking"


inTerminal :: String -> String
inTerminal prog      = myTerminal ++ " -name '" ++ prog ++ "' -e '" ++ prog ++ "'"

clickable :: WorkspaceId -> String
clickable ws         = "<action=xdotool key super+" ++ n ++ ">" ++ (wrap " " " " ws) ++ "</action>"
                         where n = take 1 ws

-- requires _NET_WM_PID to be set on creation; doesn't work on:
--   urxvtc(offlineimap), qutebrowser, chromium
spawnOnAndGoTo ws prog = do spawnOn ws prog
                            (windows . W.greedyView) ws


main = do
    host    <- fmap nodeName getSystemID
    xmproc  <- spawnPipe "xmobar"
    xm2proc <- if host == "deskarch" then
                  spawnPipe "xmobar --screen=1 ~/.xmobar/xmobar2rc"
               else
                  spawnPipe "echo" -- required for type?
    xmonad $  docks
              def { borderWidth        = myBorderWidth
                  , normalBorderColor  = myNormalBorderColor
                  , focusedBorderColor = myFocusedBorderColor
                  , workspaces         = myWorkspaces
                  , layoutHook         = myLayoutHook
                  , manageHook         = myManageHook <+> manageSpawn <+> manageHook def
                  , startupHook        = myStartupHook
                  , logHook            = myLogHook host xmproc xm2proc
                  , focusFollowsMouse  = myFocusFollowsMouse
                  , modMask            = myModMask
                  , terminal           = myTerminal
                  } `removeKeysP` myRemovedKeys
                    `additionalKeysP` myKeys

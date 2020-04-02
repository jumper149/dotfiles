module Local.Bindings.Keys ( applyKeys
                           ) where

import XMonad
import qualified XMonad.StackSet as S
import XMonad.Actions.CycleWS ( nextWS
                              , prevWS
                              )
import XMonad.Actions.SpawnOn ( spawnOn
                              )
import XMonad.Util.EZConfig ( additionalKeysP
                            , removeKeysP
                            )

import Local.Bindings.Bind ( Binding
                           , (|/-)
                           , (^>)
                           , mkUsable
                           )
import Local.Bindings.Util ( spawnOnAndGoTo
                           , inTerminalFromConf
                           , terminalFromConf
                           )
import Local.Layout.Util ( toggleGaps
                         , cycleLayout
                         )
import Local.Workspace ( Workspace (..)
                       )

myKeys :: [Binding]
myKeys = [ "M-S-q"                    |/- "kill focused window"
                                       ^> kill
         , "M-S-<Return>"             |/- "swap focused window with master"
                                       ^> windows S.swapMaster
         , "M-<Up>"                   |/- "focus previous window"
                                       ^> windows S.focusUp
         , "M-<Down>"                 |/- "focus next window"
                                       ^> windows S.focusDown
         , "M-S-<Up>"                 |/- "swap focused window with previous"
                                       ^> windows S.swapUp
         , "M-S-<Down>"               |/- "swap focused window with next"
                                       ^> windows S.swapDown
         , "M-S-h"                    |/- "shrink master pane"
                                       ^> sendMessage Shrink
         , "M-S-l"                    |/- "expand master pane"
                                       ^> sendMessage Expand
         , "M-<Backspace>"            |/- "put focused floating window back into layout"
                                       ^> withFocused $ windows . S.sink
         , "M-S-t"                    |/- "toggle gaps"
                                       ^> toggleGaps
         , "M-<Tab>"                  |/- "go to next workspace"
                                       ^> nextWS
         , "M-S-<Tab>"                |/- "go to previous workspace"
                                       ^> prevWS
         , "M-<Space>"                |/- "cycle layout on current workspace"
                                       ^> cycleLayout -- TODO: only necessary because https://github.com/xmonad/xmonad/pull/219 is not merged;
                                                      --       fix in 'Local.Overwrite.Layout';
                                                      --       maybe also don't clear the default-keybind "M-<Space>"
         , "M-h"                      |/- "go to next Xinerama screen"
                                       ^> screenWorkspace 0 >>= flip whenJust (windows . S.view)
         , "M-<Left>"                 |/- "| alias: M-h"
                                       ^> screenWorkspace 0 >>= flip whenJust (windows . S.view)
         , "M-l"                      |/- "go to previous Xinerama screen"
                                       ^> screenWorkspace 1 >>= flip whenJust (windows . S.view)
         , "M-<Right>"                |/- "| alias: M-l"
                                       ^> screenWorkspace 1 >>= flip whenJust (windows . S.view)

         , "M-S-r"                    |/- "restart xmonad"
                                       ^> restart "xmonad" True
         , "M-S-e"                    |/- "shutdown menu"
                                       ^> spawn "${XMONAD_CONFIG_DIR}/bin/shutdown"
         , "M-S-w"                    |/- "i3lock"
                                       ^> spawn "i3lock -c '000000' -f"

         , "M-S-a"                    |/- "cycle keyboard layout"
                                       ^> spawn "cyclexkbmap"

         , "M-C-/"                    |/- "decrease brightness"
                                        ^> spawn "brightness down"
         , "M-C-\\"                   |/- "increase brightness"
                                       ^> spawn "brightness up"

         , "M-C--"                    |/- "decrease volume"
                                       ^> spawn "volume down"
         , "M-<XF86AudioLowerVolume>" |/- "| alias: M-C--"
                                       ^> spawn "volume down"
         , "M-C-S-="                  |/- "increase volume"
                                       ^> spawn "volume up"
         , "M-<XF86AudioRaiseVolume>" |/- "| alias: M-C-S-="
                                       ^> spawn "volume up"
         , "M-C-0"                    |/- "mute volume"
                                       ^> spawn "volume mute"
         , "M-<XF86AudioMute>"        |/- "| alias: M-C-0"
                                       ^> spawn "volume mute"
         , "M-C-]"                    |/- "mute microphone"
                                       ^> spawn "volume mic mute"
         , "M-<XF86AudioMicMute"      |/- "| alias: M-C-]"
                                       ^> spawn "volume mic mute"

         , "M-C-p"                    |/- "MPD: play/pause" ^> spawn "mpc toggle"
         , "M-<XF86AudioPlay>"        |/- "| alias: M-C-p" ^> spawn "mpc toggle"
         , "<XF86AudioPlay>"          |/- "| alias: M-C-p" ^> spawn "mpc toggle"
         , "M-C-o"                    |/- "MPD: stop" ^> spawn "mpc stop"
         , "M-<XF86AudioStop>"        |/- "| alias: M-C-o" ^> spawn "mpc stop"
         , "<XF86AudioStop>"          |/- "| alias: M-C-o" ^> spawn "mpc stop"
         , "M-C-["                    |/- "MPD: next" ^> spawn "mpc next"
         , "M-<XF86AudioNext>"        |/- "| alias: M-C-[" ^> spawn "mpc next"
         , "<XF86AudioNext>"          |/- "| alias: M-C-[" ^> spawn "mpc next"
         , "M-C-i"                    |/- "MPD: previous" ^> spawn "mpc prev"
         , "M-<XF86AudioPrev>"        |/- "| alias: M-C-i" ^> spawn "mpc prev"
         , "<XF86AudioPrev>"          |/- "| alias: M-C-i" ^> spawn "mpc prev"

         , "M-<Print>"                |/- "take screenshot" ^> spawn "scrot"
         , "<Print>"                  |/- "| alias: M-<Print>" ^> spawn "scrot"

         , "M-C-m"                    |/- "" ^> spawnOn (show WsOther) =<< inTerminalFromConf "offlineimap"

         , "M-<Return>"               |/- "" ^> spawn =<< terminalFromConf
         , "M-d"                      |/- "" ^> spawn "rofi -show run"
         , "M-r"                      |/- "" ^> spawn =<< inTerminalFromConf "ranger"

         , "M-f"                      |/- "" ^> spawnOnAndGoTo WsBrowser "firefox"
         , "M-n"                      |/- "" ^> spawnOnAndGoTo WsMedia =<< inTerminalFromConf "ncmpcpp"
         , "M-t"                      |/- "" ^> spawnOnAndGoTo WsSocial "telegram-desktop"
         , "M-m"                      |/- "" ^> spawnOnAndGoTo WsSocial =<< inTerminalFromConf "mutt"
         , "M-w"                      |/- "" ^> spawnOnAndGoTo WsSocial =<< inTerminalFromConf "weechat"
         , "M-g"                      |/- "" ^> spawnOnAndGoTo WsGIMP "gimp"
         , "M-p"                      |/- "" ^> spawnOnAndGoTo WsControl "pavucontrol"
         , "M-x"                      |/- "" ^> spawnOnAndGoTo WsControl "arandr"
         , "M-b"                      |/- "" ^> spawnOnAndGoTo WsOther "baobab"
         ]

myRemovedKeys :: [String]
myRemovedKeys = [ "M-q"       -- quit
                , "M-S-q"     -- restart
                , "M-<Space>" -- cycle layouts
                , "M-w"       -- Xinerama 1
                , "M-S-w"
                , "M-e"       -- Xinerama 2
                , "M-S-e"
                , "M-r"       -- Xinerama 3
                , "M-S-r"
                , "M-h"       -- resize master area
                , "M-l"
                , "M-t"       -- tile floating window
                , "M-n"       -- refresh viewed sizes
                , "M-c"       -- close window
                , "M-m"       -- focus master window
                ]

applyKeys :: XConfig l -> XConfig l
applyKeys = (`additionalKeysP` fmap mkUsable myKeys) . (`removeKeysP` myRemovedKeys)

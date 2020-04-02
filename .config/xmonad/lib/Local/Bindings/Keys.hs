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

import Local.Bindings.Bind ( (|/-)
                           , (^>)
                           , Binder
                           , bind
                           , bindAlias
                           , runBinder
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

myKeys :: Binder ()
myKeys = do
    bind $ "M-S-q"
      |/- "kill focused window"
        ^> kill
    bind $ "M-S-<Return>"
      |/- "swap focused window with master"
        ^> windows S.swapMaster
    bind $ "M-<Up>"
      |/- "focus previous window"
        ^> windows S.focusUp
    bind $ "M-<Down>"
      |/- "focus next window"
        ^> windows S.focusDown
    bind $ "M-S-<Up>"
      |/- "swap focused window with previous"
        ^> windows S.swapUp
    bind $ "M-S-<Down>"
      |/- "swap focused window with next"
        ^> windows S.swapDown
    bind $ "M-S-h"
      |/- "shrink master pane"
        ^> sendMessage Shrink
    bind $ "M-S-l"
      |/- "expand master pane"
        ^> sendMessage Expand
    bind $ "M-<Backspace>"
      |/- "put focused floating window back into layout"
        ^> withFocused $ windows . S.sink
    bind $ "M-S-t"
      |/- "toggle gaps"
        ^> toggleGaps
    bind $ "M-<Tab>"
      |/- "go to next workspace"
        ^> nextWS
    bind $ "M-S-<Tab>"
      |/- "go to previous workspace"
        ^> prevWS
    bind $ "M-<Space>"
      |/- "cycle layout on current workspace"
        ^> cycleLayout -- TODO: only necessary because https://github.com/xmonad/xmonad/pull/219 is not merged;
                       --       fix in 'Local.Overwrite.Layout';
                       --       maybe also don't clear the default-keybind "M-<Space>"
    bindAlias ["M-<Left>"] $ "M-h"
      |/- "go to next Xinerama screen"
        ^> screenWorkspace 0 >>= flip whenJust (windows . S.view)
    bindAlias ["M-<Right>"] $ "M-l"
      |/- "go to previous Xinerama screen"
        ^> screenWorkspace 1 >>= flip whenJust (windows . S.view)

    bind $ "M-S-r"
      |/- "restart xmonad"
        ^> restart "xmonad" True
    bind $ "M-S-e"
      |/- "shutdown menu"
        ^> spawn "${XMONAD_CONFIG_DIR}/bin/shutdown"
    bind $ "M-S-w"
      |/- "i3lock"
        ^> spawn "i3lock -c '000000' -f"

    bind $ "M-S-a"
      |/- "cycle keyboard layout"
        ^> spawn "cyclexkbmap"

    bind $ "M-C-/"
      |/- "decrease brightness"
        ^> spawn "brightness down"
    bind $ "M-C-\\"
      |/- "increase brightness"
        ^> spawn "brightness up"

    bindAlias ["M-<XF86AudioLowerVolume>"] $ "M-C--"
      |/- "decrease volume"
        ^> spawn "volume down"
    bindAlias ["M-<XF86AudioRaiseVolume>"] $ "M-C-S-="
      |/- "increase volume"
        ^> spawn "volume up"
    bindAlias ["M-<XF86AudioMute>"] $ "M-C-0"
      |/- "mute volume"
        ^> spawn "volume mute"
    bindAlias ["M-<XF86AudioMicMute"] $ "M-C-]"
      |/- "mute microphone"
        ^> spawn "volume mic mute"

    bindAlias [ "<XF86AudioPlay>" , "M-<XF86AudioPlay>" ] $ "M-C-p"
      |/- "MPD: play/pause"
        ^> spawn "mpc toggle"
    bindAlias [ "<XF86AudioStop>" , "M-<XF86AudioStop>" ] $ "M-C-o"
      |/- "MPD: stop"
        ^> spawn "mpc stop"
    bindAlias [ "<XF86AudioNext>" , "M-<XF86AudioNext>" ] $ "M-C-["
      |/- "MPD: next"
        ^> spawn "mpc next"
    bindAlias [ "<XF86AudioPrev>" , "M-<XF86AudioPrev>" ] $ "M-C-i"
      |/- "MPD: previous"
        ^> spawn "mpc prev"

    bindAlias ["<Print>"] $ "M-<Print>"
      |/- "take screenshot"
        ^> spawn "scrot"

    bind $ "M-C-m"
      |/- "fetch mail"
        ^> spawnOn (show WsOther) =<< inTerminalFromConf "offlineimap"

    bind $ "M-<Return>"
      |/- "spawn terminal"
        ^> spawn =<< terminalFromConf
    bind $ "M-d"
      |/- "spawn launcher"
        ^> spawn "rofi -show run"
    bind $ "M-r"
      |/- "spawn ranger"
        ^> spawn =<< inTerminalFromConf "ranger"

    bind $ "M-f"
      |/- "spawn firefox"
        ^> spawnOnAndGoTo WsBrowser "firefox"
    bind $ "M-n"
      |/- "spawn ncmpcpp"
        ^> spawnOnAndGoTo WsMedia =<< inTerminalFromConf "ncmpcpp"
    bind $ "M-t"
      |/- "spawn telegram"
        ^> spawnOnAndGoTo WsSocial "telegram-desktop"
    bind $ "M-m"
      |/- "spawn mutt"
        ^> spawnOnAndGoTo WsSocial =<< inTerminalFromConf "mutt"
    bind $ "M-w"
      |/- "spawn weechat"
        ^> spawnOnAndGoTo WsSocial =<< inTerminalFromConf "weechat"
    bind $ "M-g"
      |/- "spawn gimp"
        ^> spawnOnAndGoTo WsGIMP "gimp"
    bind $ "M-p"
      |/- "spawn pavucontrol"
        ^> spawnOnAndGoTo WsControl "pavucontrol"
    bind $ "M-x"
      |/- "spawn arandr"
        ^> spawnOnAndGoTo WsControl "arandr"
    bind $ "M-b"
      |/- "spawn baobab"
        ^> spawnOnAndGoTo WsOther "baobab"

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
applyKeys = (`additionalKeysP` (fmap mkUsable $ runBinder myKeys)) . (`removeKeysP` myRemovedKeys)

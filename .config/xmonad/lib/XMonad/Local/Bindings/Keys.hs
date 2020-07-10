module XMonad.Local.Bindings.Keys ( myKeys
                                  ) where

import XMonad
import qualified XMonad.StackSet as S
import XMonad.Actions.CycleWS ( nextWS
                              , prevWS
                              )
import XMonad.Actions.SpawnOn ( spawnOn
                              )

import XMonad.Local.Bindings.Bind ( (|/-)
                                  , (^>)
                                  , (...)
                                  , Binder
                                  , bind
                                  , bindAlias
                                  , bindZip
                                  , getBindings
                                  )
import XMonad.Local.Bindings.Util ( Direction (..)
                                  , moveFloating
                                  , resizeFloating
                                  , spawnOnAndGoTo
                                  , inTerminalFromConf
                                  , terminalFromConf
                                  )
import XMonad.Local.Config.Workspace ( Workspace (..)
                                     , workspaceIds
                                     )
import XMonad.Local.Layout.Util ( toggleFull
                                , toggleGaps
                                , cycleLayout
                                )

myKeys :: KeyMask -> Binder ()
myKeys mask = do
    bind $ mask ... xK_F1
      |/- "view bindings"
        ^> do doc <- getBindings
              term <- terminalFromConf
              spawn $ term <> " -e sh -c \"echo '" <> doc <> "' | less\""
    bind $ mask .|. shiftMask ... xK_q
      |/- "kill focused window"
        ^> kill
    bind $ mask .|. shiftMask ... xK_Return
      |/- "swap focused window with master"
        ^> windows S.swapMaster
    bindAlias [ mask ... xK_Up
              ] $ mask ... xK_k
      |/- "focus previous window"
        ^> windows S.focusUp
    bindAlias [ mask ... xK_Down
              ] $ mask ... xK_j
      |/- "focus next window"
        ^> windows S.focusDown
    bindAlias [ mask .|. shiftMask ... xK_Up
              ] $ mask .|. shiftMask ... xK_k
      |/- "swap focused window with previous"
        ^> windows S.swapUp
    bindAlias [ mask .|. shiftMask ... xK_Down
              ] $ mask .|. shiftMask ... xK_j
      |/- "swap focused window with next"
        ^> windows S.swapDown
    bind $ mask .|. shiftMask ... xK_h
      |/- "shrink master pane"
        ^> sendMessage Shrink
    bind $ mask .|. shiftMask ... xK_l
      |/- "expand master pane"
        ^> sendMessage Expand
    bind $ mask ... xK_comma
      |/- "increment number of windows in master pane"
        ^> sendMessage $ IncMasterN 1
    bind $ mask ... xK_period
      |/- "decrement number of windows in master pane"
        ^> sendMessage $ IncMasterN (-1)
    bindAlias [ mask .|. controlMask ... xK_BackSpace
              ] $ mask ... xK_BackSpace
      |/- "move focused floating window back into layout"
        ^> withFocused $ windows . S.sink
    bind $ mask ... xK_equal
      |/- "toggle fullscreen"
        ^> toggleFull
    bind $ mask .|. shiftMask ... xK_t
      |/- "toggle gaps"
        ^> toggleGaps
    bind $ mask ... xK_space
      |/- "cycle layout on current workspace"
        ^> cycleLayout -- TODO: only necessary because https://github.com/xmonad/xmonad/pull/219 is not merged;
                       --       fix in 'Local.Overwrite.Layout';
                       --       maybe also don't clear the default-keybind "M-<Space>"
    bind $ mask .|. shiftMask ... xK_space
      |/- "reset layout on current workspace"
        ^> setLayout =<< asks (layoutHook . config)
    bindAlias [ mask .|. controlMask ... xK_Left
              ] $ mask .|. controlMask ... xK_h
      |/- "move floating window left"
        ^> withFocused $ moveFloating L
    bindAlias [ mask .|. controlMask ... xK_Down
              ] $ mask .|. controlMask ... xK_j
      |/- "move floating window down"
        ^> withFocused $ moveFloating D
    bindAlias [ mask .|. controlMask ... xK_Up
              ] $ mask .|. controlMask ... xK_k
      |/- "move floating window up"
        ^> withFocused $ moveFloating U
    bindAlias [ mask .|. controlMask ... xK_Right
              ] $ mask .|. controlMask ... xK_l
      |/- "move floating window right"
        ^> withFocused $ moveFloating R
    bindAlias [ mask .|. controlMask .|. shiftMask ... xK_Left
              ] $ mask .|. controlMask .|. shiftMask ... xK_h
      |/- "shrink floating window horizontally"
        ^> withFocused $ resizeFloating L
    bindAlias [ mask .|. controlMask .|. shiftMask ... xK_Down
              ] $ mask .|. controlMask .|. shiftMask ... xK_j
      |/- "expand floating window vertically"
        ^> withFocused $ resizeFloating D
    bindAlias [ mask .|. controlMask .|. shiftMask ... xK_Up
              ] $ mask .|. controlMask .|. shiftMask ... xK_k
      |/- "shrink floating window vertically"
        ^> withFocused $ resizeFloating U
    bindAlias [ mask .|. controlMask .|. shiftMask ... xK_Right
              ] $ mask .|. controlMask .|. shiftMask ... xK_l
      |/- "expand floating window horizontally"
        ^> withFocused $ resizeFloating R
    bind $ mask ... xK_Tab
      |/- "go to next workspace"
        ^> nextWS
    bind $ mask .|. shiftMask ... xK_Tab
      |/- "go to previous workspace"
        ^> prevWS
    bindZip ((mask ...) <$> [ xK_1 .. xK_9 ])
            (("go to workspace " <>) . pure <$> [ '1' .. '9' ])
            (windows . S.greedyView <$> workspaceIds)
    bindZip ((mask .|. shiftMask ...) <$> [ xK_1 .. xK_9 ])
            (("move focused window to workspace " <>) . pure <$> [ '1' .. '9' ])
            (windows . S.shift <$> workspaceIds)
    bindAlias [ mask ... xK_Left
              ] $ mask ... xK_h
      |/- "go to next Xinerama screen"
        ^> screenWorkspace 0 >>= flip whenJust (windows . S.view)
    bindAlias [ mask ... xK_Right
              ] $ mask ... xK_l
      |/- "go to previous Xinerama screen"
        ^> screenWorkspace 1 >>= flip whenJust (windows . S.view)

    bind $ mask .|. shiftMask ... xK_r
      |/- "restart xmonad"
        ^> restart "xmonad" True
    bind $ mask .|. shiftMask ... xK_e
      |/- "shutdown menu"
        ^> spawn "${XMONAD_CONFIG_DIR}/bin/shutdown"
    bind $ mask .|. shiftMask ... xK_w
      |/- "i3lock"
        ^> spawn "i3lock -c '000000' -f"

    bind $ mask .|. shiftMask ... xK_a
      |/- "cycle keyboard layout"
        ^> spawn "cyclexkbmap"

    bind $ mask .|. shiftMask ... xK_slash
      |/- "decrease brightness"
        ^> spawn "brightness down"
    bind $ mask .|. shiftMask ... xK_backslash
      |/- "increase brightness"
        ^> spawn "brightness up"

    bindAlias [ mask ... stringToKeysym "XF86AudioLowerVolume"
              ] $ mask .|. controlMask ... xK_minus
      |/- "decrease volume"
        ^> spawn "volume down"
    bindAlias [ mask ... stringToKeysym "XF86AudioRaiseVolume"
              ] $ mask .|. controlMask .|. shiftMask ... xK_equal
      |/- "increase volume"
        ^> spawn "volume up"
    bindAlias [ mask ... stringToKeysym "XF86AudioMute"
              ] $ mask .|. controlMask ... xK_0
      |/- "mute volume"
        ^> spawn "volume mute"
    bindAlias [ mask ... stringToKeysym "XF86AudioMicMute"
              ] $ mask .|. controlMask ... xK_bracketright
      |/- "mute microphone"
        ^> spawn "volume mic mute"

    bindAlias [ noModMask ... stringToKeysym "XF86AudioPlay"
              , mask ... stringToKeysym "XF86AudioPlay"
              ] $ mask .|. controlMask ... xK_p
      |/- "MPD: play/pause"
        ^> spawn "mpc toggle"
    bindAlias [ noModMask ... stringToKeysym "XF86AudioStop"
              , mask ... stringToKeysym "XF86AudioStop"
              ] $ mask .|. controlMask ... xK_o
      |/- "MPD: stop"
        ^> spawn "mpc stop"
    bindAlias [ noModMask ... stringToKeysym "XF86AudioNext"
              , mask ... stringToKeysym "XF86AudioNext"
              ] $ mask .|. controlMask ... xK_bracketleft
      |/- "MPD: next"
        ^> spawn "mpc next"
    bindAlias [ noModMask ... stringToKeysym "XF86AudioPrev"
              , mask ... stringToKeysym "XF86AudioPrev"
              ] $ mask .|. controlMask ... xK_i
      |/- "MPD: previous"
        ^> spawn "mpc prev"

    bindAlias [ noModMask ... stringToKeysym "Print"
              ] $ mask ... stringToKeysym "Print"
      |/- "take screenshot"
        ^> spawn "scrot"

    bind $ mask .|. controlMask ... xK_m
      |/- "fetch mail"
        ^> spawnOn (show WsOther) =<< inTerminalFromConf "offlineimap"

    bind $ mask ... xK_Return
      |/- "spawn terminal"
        ^> spawn =<< terminalFromConf
    bind $ mask ... xK_d
      |/- "spawn launcher"
        ^> spawn "rofi -show run"
    bind $ mask ... xK_r
      |/- "spawn ranger"
        ^> spawn =<< inTerminalFromConf "ranger"

    bind $ mask ... xK_f
      |/- "spawn firefox"
        ^> spawnOnAndGoTo WsBrowser "firefox"
    bind $ mask ... xK_c
      |/- "spawn chromium"
        ^> spawnOnAndGoTo WsBrowser "chromium"
    bind $ mask ... xK_q
      |/- "spawn qutebrowser"
        ^> spawnOnAndGoTo WsBrowser "qutebrowser"
    bind $ mask ... xK_n
      |/- "spawn ncmpcpp"
        ^> spawnOnAndGoTo WsMedia =<< inTerminalFromConf "ncmpcpp"
    bind $ mask ... xK_t
      |/- "spawn telegram"
        ^> spawnOnAndGoTo WsSocial "telegram-desktop"
    bind $ mask ... xK_m
      |/- "spawn mutt"
        ^> spawnOnAndGoTo WsSocial =<< inTerminalFromConf "mutt"
    bind $ mask ... xK_w
      |/- "spawn weechat"
        ^> spawnOnAndGoTo WsSocial =<< inTerminalFromConf "weechat"
    bind $ mask ... xK_g
      |/- "spawn gimp"
        ^> spawnOnAndGoTo WsGIMP "gimp"
    bind $ mask ... xK_p
      |/- "spawn pavucontrol"
        ^> spawnOnAndGoTo WsControl "pavucontrol"
    bind $ mask ... xK_x
      |/- "spawn arandr"
        ^> spawnOnAndGoTo WsControl "arandr"
    bind $ mask ... xK_b
      |/- "spawn baobab"
        ^> spawnOnAndGoTo WsOther "baobab"

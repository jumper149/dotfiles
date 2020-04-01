{-# LANGUAGE FlexibleContexts #-}

module Local.Keys ( applyKeys
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

import Local.Workspace
import Local.LayoutHook ( toggleGaps
                        , cycleLayout
                        )

myKeys :: [(String , X ())]
myKeys = [ ("M-S-q"         , kill)
         , ("M-S-<Return>"  , windows S.swapMaster)
         , ("M-<Up>"        , windows S.focusUp)
         , ("M-<Down>"      , windows S.focusDown)
         , ("M-S-<Up>"      , windows S.swapUp)
         , ("M-S-<Down>"    , windows S.swapDown)
         , ("M-S-h"         , sendMessage Shrink)
         , ("M-S-l"         , sendMessage Expand)
         , ("M-<Backspace>" , withFocused $ windows . S.sink)
         , ("M-S-t"         , toggleGaps)
         , ("M-<Tab>"       , nextWS)
         , ("M-S-<Tab>"     , prevWS)
         , ("M-<Space>"     , cycleLayout) -- TODO: only necessary because https://github.com/xmonad/xmonad/pull/219 is not merged; fix in 'Overwrite.Layout';
                                           --       maybe also don't clear the default-keybinds "M-<Space>"
         , ("M-h"           , screenWorkspace 0 >>= flip whenJust (windows . S.view))
         , ("M-<Left>"      , screenWorkspace 0 >>= flip whenJust (windows . S.view))
         , ("M-l"           , screenWorkspace 1 >>= flip whenJust (windows . S.view))
         , ("M-<Right>"     , screenWorkspace 1 >>= flip whenJust (windows . S.view))

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
         , ("M-C-m"         , spawnOn (show WsOther) =<< inTerminalFromConf "offlineimap")

         , ("M-<Return>"    , spawn =<< terminalFromConf)
         , ("M-d"           , spawn "rofi -show run")
         , ("M-r"           , spawn =<< inTerminalFromConf "ranger")

         , ("M-f"           , spawnOnAndGoTo WsBrowser "firefox")
         , ("M-n"           , spawnOnAndGoTo WsMedia =<< inTerminalFromConf "ncmpcpp")
         , ("M-t"           , spawnOnAndGoTo WsSocial "telegram-desktop")
         , ("M-m"           , spawnOnAndGoTo WsSocial =<< inTerminalFromConf "mutt")
         , ("M-w"           , spawnOnAndGoTo WsSocial =<< inTerminalFromConf "weechat")
         , ("M-g"           , spawnOnAndGoTo WsGIMP "gimp")
         , ("M-p"           , spawnOnAndGoTo WsControl "pavucontrol")
         , ("M-x"           , spawnOnAndGoTo WsControl "arandr")
         , ("M-b"           , spawnOnAndGoTo WsOther "baobab")
         ]

-- requires _NET_WM_PID to be set on creation; doesn't work on:
--   urxvtc(offlineimap), qutebrowser, chromium
spawnOnAndGoTo :: Workspace -> String -> X ()
spawnOnAndGoTo ws prog = do spawnOn wsId prog
                            windows . S.greedyView $ wsId
    where wsId = show ws

inTerminalFromConf :: (MonadIO m, MonadReader XConf m) => String -> m String
inTerminalFromConf prog = do terminalEmulator <- terminalFromConf
                             return $ terminalEmulator <> " --name '" <> prog <> "' -e '" <> prog <> "'"

terminalFromConf :: (MonadIO m, MonadReader XConf m) => m String
terminalFromConf = reader $ terminal . config

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
applyKeys = (`additionalKeysP` myKeys) . (`removeKeysP` myRemovedKeys)

import XMonad -- imports modules: Main, Core, Config, Layout, ManageHook, Operations
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
import XMonad.Util.Run ( runInTerm
                       , spawnPipe
                       , hPutStrLn
                       )
import XMonad.Hooks.DynamicLog ( PP (..)
                               , xmobarPP
                               , dynamicLogWithPP
                               )
import XMonad.Hooks.ManageHelpers ( doCenterFloat
                                  )

import GHC.IO.Handle ( Handle
                     )

import qualified XMonad.StackSet as W


-- black
myColor0 = "#282a2e" :: String
myColor8 = "#373b41" :: String

-- red
myColor1 = "#a54242" :: String
myColor9 = "#cc6666" :: String

-- green
myColor2 = "#8c9440" :: String
myColorA = "#b5bd68" :: String

-- yellow
myColor3 = "#de935f" :: String
myColorB = "#f0c674" :: String

-- blue
myColor4 = "#5f819d" :: String
myColorC = "#81a2be" :: String

-- magenta
myColor5 = "#85678f" :: String
myColorD = "#b294bb" :: String

-- cyan
myColor6 = "#5e8d87" :: String
myColorE = "#8abeb7" :: String

-- white
myColor7 = "#707880" :: String
myColorF = "#c5c8c6" :: String


myBorderWidth = 4 :: Dimension
myNormalBorderColor  = myColor7 :: String
myFocusedBorderColor = myColor2 :: String

myWorkspaces :: [WorkspaceId]
myWorkspaces = [ "1 Browser"
               , "2 Hacking"
               , "3 Media"
               , "4 Social"
               , "5 Writing"
               , "6 GIMP"
               , "7 Gaming"
               , "8 Control"
               , "9 Other"
               ]

myTabTheme :: Theme
myTabTheme = def { activeColor         = myColor2
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

myMainLayout =   avoidStruts tiled
             ||| avoidStruts (Mirror tiled)
             ||| noBorders Full
  where tiled = spacingRaw False
                   (Border outer outer outer outer) True
                   (Border inner inner inner inner) True
                  --     n   increment ratio
                $ Tall   1   (3/100)   (1/2)
        outer = 20
        inner = 10

myBrowserLayout =   avoidStruts (noBorders (tabbed shrinkText myTabTheme))
                ||| noBorders Full

myWritingLayout =   myMainLayout
                ||| avoidStruts single
  where single = spacingRaw False
                   (Border topbot topbot sides sides) True
                   (Border 0      0      0     0    ) False
                 $ Full
        topbot = 100
        sides  = 450

myLayoutHook = onWorkspace "1 Browser" myBrowserLayout
             $ onWorkspace "5 Writing" myWritingLayout
             $ myMainLayout

myManageHook :: ManageHook
myManageHook = composeAll
                 [ className =? "matplotlib"  --> doCenterFloat
                 , className =? "Gnuplot"     --> doCenterFloat
                 , className =? "gnuplot_qt"  --> doCenterFloat
                 , appName   =? "offlineimap" --> doShift "8 Control" <+> doCenterFloat
                 ]


myPP :: Handle -> PP
myPP h = xmobarPP { ppOutput           = hPutStrLn h
                  , ppOrder            = \(workspaces:layout:title:_) -> [workspaces]
                  , ppWsSep            = ""
                  , ppCurrent          = xmobarWsPrep "current"
                  , ppVisible          = xmobarWsPrep "visible"
                  , ppUrgent           = xmobarWsPrep "urgent"
                  , ppHidden           = xmobarWsPrep "hidden"
                  , ppHiddenNoWindows  = xmobarWsPrep "hiddenNoWindows"
                  } where

  xmobarWsPrep :: String -> WorkspaceId -> String
  xmobarWsPrep status = clickableIcon status . take 1

  clickableIcon :: String -> WorkspaceId -> String
  clickableIcon status ws = let n = take 1 ws
                            in "<action=xdotool key super+" ++ n ++ ">" ++
                               "<icon=workspaces/" ++ status ++ "/workspace_" ++ n ++ ".xpm/>" ++
                               "</action>"

myLogHook :: Handle -> X ()
myLogHook h = dynamicLogWithPP $ myPP h


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
         , ("M-S-e"         , spawn "~/.xmonad/scripts/shutdown.sh")
         , ("M-S-w"         , spawn "i3lock -c '000000' -f")

         , ("M-S-a"         , spawn "~/.scripts/keyboard_toggle.sh")

         , ("M-C-\\"        , spawn "~/.scripts/brightness/up.sh")
         , ("M-C-/"         , spawn "~/.scripts/brightness/down.sh")

         , ("M-C-S-="                  , spawn "~/.config/i3/scripts/volume_up.sh")
         , ("M-<XF86AudioRaiseVolume>" , spawn "~/.config/i3/scripts/volume_up.sh")
         , ("M-C--"                    , spawn "~/.config/i3/scripts/volume_down.sh")
         , ("M-<XF86AudioLowerVolume>" , spawn "~/.config/i3/scripts/volume_down.sh")
         , ("M-C-0"             , spawn "~/.config/i3/scripts/volume_mute.sh")
         , ("M-<XF86AudioMute>" , spawn "~/.config/i3/scripts/volume_mute.sh")
         , ("M-C-]"               , spawn "~/.config/i3/scripts/volume_mute_mic.sh")
         , ("M-<XF86AudioMicMute" , spawn "~/.config/i3/scripts/volume_mute_mic.sh")

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
         , ("M-C-k"         , spawn "~/.scripts/screenkey.sh")
         , ("M-C-y"         , spawn "~/.scripts/mpv-clipboard.sh")
         , ("M-C-m"         , spawnOn "8 Control" $ inTerminal "offlineimap")

         , ("M-<Return>"    , spawn myTerminal)
         , ("M-d"           , spawn "rofi -show run")
         , ("M-r"           , runInTerm "" "ranger")

         , ("M-f"           , spawnOnAndGoTo "1 Browser" "firefox")
         , ("M-n"           , spawnOnAndGoTo "3 Media" $ inTerminal "ncmpcpp")
         , ("M-t"           , spawnOnAndGoTo "4 Social" "telegram-desktop")
         , ("M-m"           , spawnOnAndGoTo "4 Social" $ inTerminal "mutt")
         , ("M-w"           , spawnOnAndGoTo "4 Social" $ inTerminal "weechat")
         , ("M-g"           , spawnOnAndGoTo "6 GIMP" "gimp")
         , ("M-p"           , spawnOnAndGoTo "8 Control" "pavucontrol")
         , ("M-x"           , spawnOnAndGoTo "8 Control" "arandr")
         , ("M-b"           , spawnOnAndGoTo "9 Other" "baobab")
         ]
  where inTerminal :: String -> String
        inTerminal prog = myTerminal ++ " -name '" ++ prog ++ "' -e '" ++ prog ++ "'"

        -- requires _NET_WM_PID to be set on creation; doesn't work on:
        --   urxvtc(offlineimap), qutebrowser, chromium
        spawnOnAndGoTo :: WorkspaceId -> String -> X ()
        spawnOnAndGoTo ws prog = do spawnOn ws prog
                                    (windows . W.greedyView) ws

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

myFocusFollowsMouse = False :: Bool
myModMask = mod4Mask :: ButtonMask
myTerminal = "urxvtc" :: String

myApplyKeys :: XConfig l -> XConfig l
myApplyKeys = addKs . remKs
  where addKs x = additionalKeysP x myKeys
        remKs x = removeKeysP x myRemovedKeys


myStartupHook :: X ()
myStartupHook = (windows . W.greedyView) "2 Hacking"


main :: IO ()
main = do xmproc <- spawnPipe "xmobar ~/.xmobar/xmobarrc"
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
              fc = myApplyKeys . docks $ c
          xmonad fc

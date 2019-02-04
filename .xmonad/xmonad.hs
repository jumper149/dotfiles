import XMonad
import XMonad.Core
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig
import XMonad.Util.Run
import XMonad.Hooks.DynamicLog
--import XMonad.Hooks.ManageDocks

import System.Posix.Unistd

import qualified XMonad.StackSet as W


-- black
myColor0= "#282a2e"
myColor8= "#373b41"

-- red
myColor1= "#a54242"
myColor9= "#cc6666"

-- green
myColor2= "#8c9440"
myColorA= "#b5bd68"

-- yellow
myColor3= "#de935f"
myColorB= "#f0c674"

-- blue
myColor4= "#5f819d"
myColorC= "#81a2be"

-- magenta
myColor5= "#85678f"
myColorD= "#b294bb"

-- cyan
myColor6= "#5e8d87"
myColorE= "#8abeb7"

-- white
myColor7= "#707880"
myColorF= "#c5c8c6"


myBorderWidth        = 4
myNormalBorderColor  = myColor7
myFocusedBorderColor = myColor2

myWorkspaces         = [ "1 Browser"
                       , "2 Hacking"
                       , "3 Media"
                       , "4 Social"
                       , "5 LaTeX"
                       , "6 GIMP"
                       , "7 Gaming"
                       , "8 Other"
                       , "9 Garbage"
                       ]

myLayoutHook         =          ((gaps [(U, barGap), (D, outerGap), (R, outerGap), (L, outerGap)]) spacingTiled)
                     ||| Mirror ((gaps [(U, outerGap), (D, outerGap), (R, outerGap), (L, barGap)]) spacingTiled)
                     ||| noBorders Full
  where
    outerGap     = 10
    barGap       = outerGap + 22
    spacingTiled = spacingRaw False
                      (Border outer outer outer outer) True
                      (Border inner inner inner inner) True
                     --     n   increment ratio
                   $ Tall   1   (3/100)   (1/2)
      where
        outer =    10
        inner =    10

myLogHook host h h2  = do
                           dynamicLogWithPP $ xmobarPP
                                                 { ppOutput           = hPutStrLn h
                                                 , ppOrder            = \(workspaces:layout:title:_) -> [workspaces]
                                                 , ppWsSep            = ""
                                                 , ppCurrent          = if host == "deskarch" then
                                                                           xmobarColor myColor0 myColor2 . wrap " " " "
                                                                        else
                                                                           xmobarColor myColor0 myColor2 . wrap " " " " . take 1
                                                 , ppVisible          = if host == "deskarch" then
                                                                           xmobarColor myColor0 myColor7 . wrap " " " "
                                                                        else
                                                                           xmobarColor myColor0 myColor7 . wrap " " " " . take 1
                                                 , ppHidden           = if host == "deskarch" then
                                                                           xmobarColor myColorF ""       . wrap " " " "
                                                                        else
                                                                           xmobarColor myColorF ""       . wrap " " " " . take 1
                                                 , ppHiddenNoWindows  = if host == "deskarch" then
                                                                           xmobarColor myColor7 ""       . wrap " " " "
                                                                        else
                                                                           xmobarColor myColor7 ""       . wrap " " " " . take 1
                                                 }
                           dynamicLogWithPP $ xmobarPP
                                                 { ppOutput           = hPutStrLn h2
                                                 , ppOrder            = \(workspaces:layout:title:_) -> [title]
                                                 , ppTitle            = xmobarColor myColorF myColor0 . wrap " " " " . shorten 128
                                                 }

myFocusFollowsMouse  = False
myModMask            = mod4Mask
myKeys               = [ ("M-S-q",        kill)
                       , ("M-S-<Return>", windows W.swapMaster)
                       , ("M-S-h",        sendMessage Shrink)
                       , ("M-S-l",        sendMessage Expand)
                       , ("M-h",          screenWorkspace 0 >>= flip whenJust (windows . W.view))
                       , ("M-l",          screenWorkspace 1 >>= flip whenJust (windows . W.view))
                       , ("M-S-r",        restart "xmonad" True)
                       , ("M-S-e",        spawn "$HOME/.xmonad/scripts/shutdown.sh")
                       , ("M-S-w",        spawn "i3lock -c '000000' -f --script")
                       , ("M-<Return>",   spawn myTerminal)
                       , ("M-d",          spawn "rofi -show run")
                       , ("M-r",          runInTerm "" "ranger")
                       , ("M-b",          spawn "baobab")
                       , ("M-q",          spawn "qutebrowser")
                       , ("M-c",          spawn "chromium")
                       , ("M-n",          runInTerm "" "ncmpcpp")
                       , ("M-p",          spawn "pavucontrol")
                       , ("M-x",          spawn "arandr")
                       , ("M-t",          spawn "telegram-desktop")
                       , ("M-m",          runInTerm "" "mutt")
                       , ("M-i",          runInTerm "" "irssi")
                       , ("M-g",          spawn "gimp")
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



main = do
    host    <- fmap nodeName getSystemID
    xmproc  <- spawnPipe "xmobar"
    xm2proc <- (if host == "deskarch" then
                  spawnPipe "xmobar --screen=1 ~/.xmobar/xmobar2rc"
               else
                  spawnPipe "echo") -- required for type?
    xmonad $  def { borderWidth        = myBorderWidth
                  , normalBorderColor  = myNormalBorderColor
                  , focusedBorderColor = myFocusedBorderColor
                  , workspaces         = myWorkspaces
                  , layoutHook         = myLayoutHook
                  , logHook            = myLogHook host xmproc xm2proc
                  , focusFollowsMouse  = myFocusFollowsMouse
                  , modMask            = myModMask
                  , terminal           = myTerminal
                  } `removeKeysP` myRemovedKeys
                    `additionalKeysP` myKeys

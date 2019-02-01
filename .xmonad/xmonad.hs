import XMonad
import XMonad.Layout.NoBorders
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Util.EZConfig

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

-- magenta"
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

myWorkspaces         = [ "9 Garbage"
                       , "1 Browser"
                       , "2 Hacking"
                       , "3 Media"
                       , "4 Social"
                       , "5 LaTeX"
                       , "6 GIMP"
                       , "7 Gaming"
                       , "8 Other"
                       , "0 Desktop"
                       ]

myLayoutHook         =   tiled
                     ||| Mirror tiled
                     ||| noBorders Full
  where
    tiled = gaps       [(U, outerGap), (D, outerGap), (R, outerGap), (L, outerGap)]
          $ spacingRaw False
                       (Border outer outer outer outer) True
                       (Border inner inner inner inner) True
            --     n   increment ratio
          $ Tall   1   (3/100)   (1/2)
      where
        outerGap = 10
        outer =    10
        inner =    10


myFocusFollowsMouse  = False
myModMask            = mod4Mask
myKeys               = [ ("M-S-q",        kill)
                       , ("M-S-<Return>", windows W.focusMaster)
                       , ("M-S-r",        restart "xmonad" True)
                       , ("M-S-e",        spawn "$HOME/.xmonad/scripts/shutdown.sh")
                       , ("M-<Return>",   spawn myTerminal)
                       , ("M-d",          spawn "rofi -show run")
                       , ("M-r",          spawn "urxvtc -e 'ranger'")
                       , ("M-b",          spawn "baobab")
                       , ("M-q",          spawn "qutebrowser")
                       , ("M-c",          spawn "chromium")
                       , ("M-p",          spawn "pavucontrol")
                       , ("M-x",          spawn "arandr")
                       , ("M-t",          spawn "telegram-desktop")
                       , ("M-m",          spawn "urxvtc -e 'mutt'")
                       , ("M-i",          spawn "urxvtc -e 'irssi'")
                       , ("M-g",          spawn "gimp")
                       ]
myRemovedKeys          = [ "M-q"   -- quit
                         , "M-S-q" -- restart
                         , "M-r"   -- Xinerama 3
                         , "M-S-r"
                         , "M-t"   -- tile floating window
                         , "M-n"   -- refresh viewed sizes
                         , "M-c"   -- close window
                         , "M-m"   -- focus master window
                         ]


myTerminal           = "urxvtc"


main = xmonad $ def
    {
      borderWidth        = myBorderWidth
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , workspaces         = myWorkspaces
    , layoutHook         = myLayoutHook
    , focusFollowsMouse  = myFocusFollowsMouse
    , modMask            = myModMask
    , terminal           = myTerminal
    }
    `removeKeysP` myRemovedKeys
    `additionalKeysP` myKeys

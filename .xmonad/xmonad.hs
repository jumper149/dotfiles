import XMonad
import XMonad.Util.EZConfig

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

myModMask     = mod4Mask -- Win key or Super_L
myWorkspaces  = [ "0 Desktop"
                , "1 Browser"
                , "2 Hacking"
                , "3 Media"
                , "4 Social"
                , "5 LaTeX"
                , "6 GIMP"
                , "7 Gaming"
                , "8 Other"
                , "9 Garbage"
                ]
myKeys        = [ ("M-S-q", kill)
                , ("M-S-r", restart "xmonad" True)
                , ("M-d"  , spawn "rofi -show run")
                ]
myTerminal    = "urxvt"
myBorderWidth = 4

main = do
  xmonad $ def
    { modMask            = myModMask
    , workspaces         = myWorkspaces
    , terminal           = myTerminal
    , normalBorderColor  = myColor7
    , focusedBorderColor = myColor2
    , borderWidth        = myBorderWidth
    }
    `additionalKeysP`
    myKeys

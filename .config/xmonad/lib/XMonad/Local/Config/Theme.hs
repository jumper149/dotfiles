module XMonad.Local.Config.Theme ( Theme (..)
                                 , myTheme
                                 ) where

import XMonad hiding ( Color
                     , borderWidth
                     )

import XMonad.Local.Config.Color ( Colors (..)
                                 , Color
                                 , myColors
                                 )

data Theme = Theme { borderWidth         :: Dimension
                   , activeColor         :: Color
                   , inactiveColor       :: Color
                   , urgentColor         :: Color
                   , activeBorderColor   :: Color
                   , inactiveBorderColor :: Color
                   , urgentBorderColor   :: Color
                   , activeTextColor     :: Color
                   , inactiveTextColor   :: Color
                   , urgentTextColor     :: Color
                   }

myTheme :: Theme
myTheme = Theme { borderWidth         = 4
                , activeColor         = color2 myColors
                , inactiveColor       = color0 myColors
                , urgentColor         = color3 myColors
                , activeBorderColor   = color2 myColors
                , inactiveBorderColor = color7 myColors
                , urgentBorderColor   = color3 myColors
                , activeTextColor     = color0 myColors
                , inactiveTextColor   = color7 myColors
                , urgentTextColor     = color0 myColors
                }

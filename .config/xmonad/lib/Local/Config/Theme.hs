module Local.Config.Theme ( BorderTheme (..)
                          , myBorderTheme
                          ) where

import XMonad hiding ( Color
                     )

import Local.Config.Color ( Colors (..)
                          , Color
                          , myColors
                          )

data BorderTheme = BorderTheme { borderWidth'        :: Dimension
                               , activeBorderColor   :: Color
                               , inactiveBorderColor :: Color
                               , urgentBorderColor   :: Color
                               }

myBorderTheme :: BorderTheme
myBorderTheme = BorderTheme { borderWidth'        = 4
                            , activeBorderColor   = color2 myColors
                            , inactiveBorderColor = color7 myColors
                            , urgentBorderColor   = color3 myColors
                            }

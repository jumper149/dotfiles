module Local.Config.Color ( Colors (..)
                          , Color
                          , myColors
                          ) where

type Color = String

data Colors = Colors { color0 :: Color
                     , color1 :: Color
                     , color2 :: Color
                     , color3 :: Color
                     , color4 :: Color
                     , color5 :: Color
                     , color6 :: Color
                     , color7 :: Color
                     , color8 :: Color
                     , color9 :: Color
                     , colorA :: Color
                     , colorB :: Color
                     , colorC :: Color
                     , colorD :: Color
                     , colorE :: Color
                     , colorF :: Color
                     }
  deriving (Eq, Read, Show)

myColors :: Colors
myColors = Colors { color0 = "#282a2e" -- black
                  , color8 = "#373b41"

                  , color1 = "#a54242" -- red
                  , color9 = "#cc6666"

                  , color2 = "#8c9440" -- green
                  , colorA = "#b5bd68"

                  , color3 = "#de935f" -- yellow
                  , colorB = "#f0c674"

                  , color4 = "#5f819d" -- blue
                  , colorC = "#81a2be"

                  , color5 = "#85678f" -- magenta
                  , colorD = "#b294bb"

                  , color6 = "#5e8d87" -- cyan
                  , colorE = "#8abeb7"

                  , color7 = "#707880" -- white
                  , colorF = "#c5c8c6"
                  }

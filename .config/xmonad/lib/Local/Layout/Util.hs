module Local.Layout.Util ( cycleLayout
                         , toggleGaps
                         , wsLayout
                         , spacedTall
                         , tabTheme
                         ) where

import XMonad hiding ( ChangeLayout ( NextLayout
                                    )
                     )
import XMonad.Layout.Decoration ( Theme (..)
                                )
import XMonad.Layout.LayoutModifier ( ModifiedLayout
                                    )
import XMonad.Layout.PerWorkspace ( PerWorkspace
                                  , onWorkspace
                                  )
import XMonad.Layout.Spacing ( SpacingModifier (..)
                             , Border (..)
                             , Spacing
                             , spacingRaw
                             )

import Data.Foldable ( traverse_
                     )
import Data.Ratio ( (%)
                  )

import Local.Overwrite.Layout ( ChangeLayout (..)
                              )

import Local.Color ( Colors (..)
                   , colors
                   )
import Local.Workspace ( Workspace
                       )

wsLayout :: (LayoutClass l a, LayoutClass r a) => Workspace -> l a -> r a -> PerWorkspace l r a
wsLayout ws l = onWorkspace (show ws) l

spacedTall :: ModifiedLayout Spacing Tall a
spacedTall = space $ Tall 1 (3%100)   (1%2)
                     --   n increment ratio

space :: l a -> ModifiedLayout Spacing l a
space = spacingRaw False
          (Border outer outer outer outer) True
          (Border inner inner inner inner) True
    where outer = 20
          inner = 10

tabTheme :: Theme
tabTheme = def { activeColor         = color2 colors
               , inactiveColor       = color0 colors
               , urgentColor         = color3 colors
               , activeBorderColor   = color2 colors
               , inactiveBorderColor = color0 colors
               , urgentBorderColor   = color3 colors
               , activeTextColor     = color0 colors
               , inactiveTextColor   = color7 colors
               , urgentTextColor     = color0 colors
               , fontName            = "xft:Inconsolata:size=12:style=Bold:antialias=true"
               }

-- | Toggle gaps on the current workspace.
toggleGaps :: X ()
toggleGaps = do traverse_ sendMessage messages
    where messages = [ ModifyWindowBorderEnabled not
                     , ModifyScreenBorderEnabled not
                     ]

cycleLayout :: X ()
cycleLayout = sendMessage NextLayout

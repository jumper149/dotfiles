module Local.Layout.Util ( cycleLayout
                         , toggleGaps
                         , wsLayout
                         , space
                         , spaceTabbed
                         , myMastered
                         , myTall
                         , myTabbed
                         , mySpacedTabbed
                         ) where

import XMonad hiding ( ChangeLayout ( NextLayout
                                    )
                     )
import XMonad.Layout.Decoration ( Theme (..)
                                , Decoration
                                , DefaultShrinker
                                )
import XMonad.Layout.LayoutModifier ( ModifiedLayout
                                    )
import XMonad.Layout.Master ( AddMaster
                            , multimastered
                            )
import XMonad.Layout.PerWorkspace ( PerWorkspace
                                  , onWorkspace
                                  )
import XMonad.Layout.Simplest ( Simplest
                              )
import XMonad.Layout.Spacing ( SpacingModifier (..)
                             , Border (..)
                             , Spacing
                             , spacingRaw
                             )
import XMonad.Layout.Tabbed ( TabbedDecoration
                            , tabbed
                            , shrinkText
                            )

import Data.Foldable ( traverse_
                     )
import Data.Ratio ( (%)
                  )

import Local.Layout.Overwrite ( ChangeLayout (..)
                              )

import qualified Local.Config.Theme as T
import Local.Config.Workspace ( Workspace
                              )

wsLayout :: (LayoutClass l a, LayoutClass r a) => Workspace -> l a -> r a -> PerWorkspace l r a
wsLayout ws l = onWorkspace (show ws) l

space :: Integer -- ^ outer space
      -> Integer -- ^ inner space
      -> l a
      -> ModifiedLayout Spacing l a
space outer inner = spacingRaw False
                      (Border outer outer outer outer) True
                      (Border inner inner inner inner) True

spaceTabbed :: Integer -- ^ outer space
            -> Integer -- ^ inner space
            -> l a
            -> ModifiedLayout Spacing l a
spaceTabbed outer inner = spacingRaw False
                            (Border (outer+inner) outer outer outer) True
                            (Border 0             inner inner inner) True

myMastered :: (Eq a, Read a, LayoutClass l a) => l a -> ModifiedLayout AddMaster l a
myMastered = multimastered 1 (3%100)   (1%2)
             --            n increment ratio

myTall :: Tall a
myTall = Tall 1 (3%100)   (1%2)
         --   n increment ratio

mySpacedTabbed :: (Eq a, Read a) => ModifiedLayout (Decoration TabbedDecoration DefaultShrinker) Simplest a
mySpacedTabbed = tabbed shrinkText t
    where t = tabTheme { inactiveBorderColor = T.inactiveBorderColor T.myTheme -- TODO: change with xmonad-contrib 0.16
                       }

myTabbed :: (Eq a, Read a) => ModifiedLayout (Decoration TabbedDecoration DefaultShrinker) Simplest a
myTabbed = tabbed shrinkText tabTheme

tabTheme :: Theme
tabTheme = def { activeColor         = T.activeColor         T.myTheme
               , inactiveColor       = T.inactiveColor       T.myTheme
               , urgentColor         = T.urgentColor         T.myTheme
               , activeBorderColor   = T.activeBorderColor   T.myTheme
               , inactiveBorderColor = T.inactiveColor       T.myTheme -- TODO: implement with xmonad-contrib 0.16; use T.inactiveBorderColor
               , urgentBorderColor   = T.urgentBorderColor   T.myTheme
               , activeTextColor     = T.activeTextColor     T.myTheme
               , inactiveTextColor   = T.inactiveTextColor   T.myTheme
               , urgentTextColor     = T.urgentTextColor     T.myTheme
--               , activeBorderWidth   = 0 -- TODO: implement with xmonad-contrib 0.16
--               , inactiveBorderWidth = 0
--               , urgentBorderWidth   = 0
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

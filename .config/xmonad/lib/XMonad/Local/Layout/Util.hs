module XMonad.Local.Layout.Util ( cycleLayout
                                , toggleFull
                                , toggleGaps
                                , wsLayout
                                , space
                                , spaceTabbed
                                , myToggled
                                , myMastered
                                , myTall
                                , myTabbed
                                , mySpacedAlwaysTabbed
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
import XMonad.Layout.MultiToggle ( MultiToggle
                                 , HCons
                                 , EOT
                                 , Toggle (..)
                                 , mkToggle
                                 , single
                                 )
import XMonad.Layout.MultiToggle.Instances ( StdTransformers (..)
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
                            , tabbedAlways
                            , shrinkText
                            )

import Data.Foldable ( traverse_
                     )
import Data.Ratio ( (%)
                  )

import XMonad.Local.Layout.Overwrite ( ChangeLayout (..)
                                     )

import qualified XMonad.Local.Config.Theme as T
import XMonad.Local.Config.Workspace ( Workspace
                                     )

wsLayout :: (LayoutClass l a, LayoutClass r a) => Workspace -> l a -> r a -> PerWorkspace l r a
wsLayout ws = onWorkspace $ show ws

myToggled :: LayoutClass l a => l a -> MultiToggle (HCons StdTransformers EOT) l a
myToggled = mkToggle (single NBFULL)

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

mySpacedAlwaysTabbed :: (Eq a, Read a) => ModifiedLayout (Decoration TabbedDecoration DefaultShrinker) Simplest a
mySpacedAlwaysTabbed = tabbedAlways shrinkText t
    where t = tabTheme { inactiveBorderWidth = 1
                       }

mySpacedTabbed :: (Eq a, Read a) => ModifiedLayout (Decoration TabbedDecoration DefaultShrinker) Simplest a
mySpacedTabbed = tabbed shrinkText t
    where t = tabTheme { inactiveBorderWidth = 1
                       }

myTabbed :: (Eq a, Read a) => ModifiedLayout (Decoration TabbedDecoration DefaultShrinker) Simplest a
myTabbed = tabbed shrinkText tabTheme

tabTheme :: Theme
tabTheme = Theme { activeColor         = T.activeColor         T.myTheme
                 , inactiveColor       = T.inactiveColor       T.myTheme
                 , urgentColor         = T.urgentColor         T.myTheme
                 , activeBorderColor   = T.activeBorderColor   T.myTheme
                 , inactiveBorderColor = T.inactiveBorderColor T.myTheme
                 , urgentBorderColor   = T.urgentBorderColor   T.myTheme
                 , activeTextColor     = T.activeTextColor     T.myTheme
                 , inactiveTextColor   = T.inactiveTextColor   T.myTheme
                 , urgentTextColor     = T.urgentTextColor     T.myTheme
                 , decoWidth           = 100 -- TODO: unsure, what effect this has
                 , decoHeight          = 23
                 , activeBorderWidth   = 0
                 , inactiveBorderWidth = 0
                 , urgentBorderWidth   = 0
                 , fontName            = "xft:Iosevka:size=11:style=Bold"
                 , windowTitleAddons   = []
                 , windowTitleIcons    = []
                 }

toggleFull :: X ()
toggleFull = sendMessage $ Toggle NBFULL

-- | Toggle gaps on the current workspace.
toggleGaps :: X ()
toggleGaps = traverse_ sendMessage messages
    where messages = [ ModifyWindowBorderEnabled not
                     , ModifyScreenBorderEnabled not
                     ]

cycleLayout :: X ()
cycleLayout = sendMessage NextLayout

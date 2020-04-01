{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

module Local.Layout ( MyChoose
                    , (||||)
                    , cycleLayout
                    , toggleGaps
                    , spacedTall
                    , tabTheme
                    ) where

import XMonad hiding ( Choose
                     , (|||)
                     , ChangeLayout ( NextLayout
                                    )
                     )
import XMonad.StackSet as S
import XMonad.Layout.Decoration ( Theme (..)
                                )
import XMonad.Layout.LayoutModifier ( ModifiedLayout
                                    )
import XMonad.Layout.Spacing ( SpacingModifier (..)
                             , Border (..)
                             , Spacing
                             , spacingRaw
                             )

import Data.Foldable ( traverse_
                     )
import Data.Maybe ( fromMaybe
                  )
import Data.Ratio ( (%)
                  )

import Local.Overwrite.Layout ( Choose (..)
                              , (|||)
                              , ChangeLayout (..)
                              )

import Local.Color

spacedTall :: ModifiedLayout Spacing Tall a
spacedTall = spacingRaw False
               (Border outer outer outer outer) True
               (Border inner inner inner inner) True
                --     n   increment ratio
               (Tall   1   (3%100)   (1%2))
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

-- | Toggle gaps on all workspaces.
toggleGaps :: X ()
toggleGaps = do traverse_ sendMessage messages
    where messages = [ ModifyWindowBorderEnabled not
                     , ModifyScreenBorderEnabled not
                     ]

cycleLayout :: X ()
cycleLayout = sendMessage NextLayout

newtype MyChoose l r a = MyChoose (Choose l r a)
  deriving (Read, Show)

(||||) :: l a -> r a -> MyChoose l r a
(||||) l r = MyChoose $ l ||| r
infixr 5 ||||

instance (LayoutClass l a, LayoutClass r a) => LayoutClass (MyChoose l r) a where

    runLayout (S.Workspace i (MyChoose c) a) r = do (ls , mbC) <- runLayout (S.Workspace i c a) r
                                                    return (ls , MyChoose <$> mbC)

    description (MyChoose c) = description c

    handleMessage (MyChoose (Choose d l r)) sm =
        let sendBoth = do ml <- handleMessage l sm
                          mr <- handleMessage r sm
                          let l' = fromMaybe l $ ml
                              r' = fromMaybe r $ mr
                          return . Just . MyChoose $ Choose d l' r'
        in case fromMessage sm of
             Just (ModifyWindowBorderEnabled _) -> sendBoth
             Just (ModifyScreenBorderEnabled _) -> sendBoth
             _ -> do fmap MyChoose <$> handleMessage (Choose d l r) sm

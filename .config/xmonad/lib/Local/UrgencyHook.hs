{-# LANGUAGE FlexibleContexts #-}

module Local.UrgencyHook ( applyUrgencyHook
                         ) where

import XMonad
import XMonad.Hooks.UrgencyHook

import Local.Color ( Colors (..)
                   , colors
                   )

myUrgencyHook :: BorderUrgencyHook
myUrgencyHook = BorderUrgencyHook { urgencyBorderColor = color3 colors }

myUrgencyConfig :: UrgencyConfig
myUrgencyConfig = UrgencyConfig { suppressWhen = Focused
                                , remindWhen = Dont}

applyUrgencyHook :: LayoutClass l Window => XConfig l -> XConfig l
applyUrgencyHook = withUrgencyHookC myUrgencyHook myUrgencyConfig

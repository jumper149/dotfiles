{-# LANGUAGE FlexibleContexts #-}

module Local.Urgency.Hook ( applyUrgencyHook
                          ) where

import XMonad
import XMonad.Hooks.UrgencyHook

import Local.Config.Color ( Colors (..)
                          , myColors
                          )

myUrgencyHook :: BorderUrgencyHook
myUrgencyHook = BorderUrgencyHook { urgencyBorderColor = color3 myColors }

myUrgencyConfig :: UrgencyConfig
myUrgencyConfig = UrgencyConfig { suppressWhen = Focused
                                , remindWhen = Dont}

applyUrgencyHook :: LayoutClass l Window => XConfig l -> XConfig l
applyUrgencyHook = withUrgencyHookC myUrgencyHook myUrgencyConfig

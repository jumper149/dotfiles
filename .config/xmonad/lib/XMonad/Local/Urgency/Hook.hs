{-# LANGUAGE FlexibleContexts #-}

module XMonad.Local.Urgency.Hook ( applyUrgencyHook
                                 ) where

import XMonad
import XMonad.Hooks.UrgencyHook

import qualified XMonad.Local.Config.Theme as T

myUrgencyHook :: BorderUrgencyHook
myUrgencyHook = BorderUrgencyHook { urgencyBorderColor = T.urgentBorderColor T.myTheme }

myUrgencyConfig :: UrgencyConfig
myUrgencyConfig = UrgencyConfig { suppressWhen = Focused
                                , remindWhen = Dont}

applyUrgencyHook :: LayoutClass l Window => XConfig l -> XConfig l
applyUrgencyHook = withUrgencyHookC myUrgencyHook myUrgencyConfig

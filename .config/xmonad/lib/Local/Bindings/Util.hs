{-# LANGUAGE FlexibleContexts #-}

module Local.Bindings.Util ( spawnOnAndGoTo
                           , inTerminalFromConf
                           , terminalFromConf
                           ) where

import XMonad
import qualified XMonad.StackSet as S
import XMonad.Actions.SpawnOn ( spawnOn
                              )

import Local.Workspace ( Workspace (..)
                       )

-- requires _NET_WM_PID to be set on creation; doesn't work on:
--   urxvtc(offlineimap), qutebrowser, chromium
spawnOnAndGoTo :: Workspace -> String -> X ()
spawnOnAndGoTo ws prog = do spawnOn wsId prog
                            windows . S.greedyView $ wsId
    where wsId = show ws

inTerminalFromConf :: (MonadIO m, MonadReader XConf m) => String -> m String
inTerminalFromConf prog = do terminalEmulator <- terminalFromConf
                             return $ terminalEmulator <> " --name '" <> prog <> "' -e '" <> prog <> "'"

terminalFromConf :: (MonadIO m, MonadReader XConf m) => m String
terminalFromConf = reader $ terminal . config

{-# LANGUAGE FlexibleContexts #-}

module XMonad.Local.Bindings.Util ( Direction (..)
                                  , moveFloating
                                  , resizeFloating
                                  , spawnOnAndGoTo
                                  , inTerminalFromConf
                                  , terminalFromConf
                                  ) where

import XMonad
import qualified XMonad.StackSet as S
import XMonad.Actions.FloatKeys ( keysMoveWindow
                                , keysResizeWindow
                                )
import XMonad.Actions.SpawnOn ( spawnOn
                              )

import XMonad.Local.Config.Workspace ( Workspace (..)
                                     )

data Direction = L
               | D
               | U
               | R

moveFloating :: Direction -> Window -> X ()
moveFloating d = keysMoveWindow (direction d)

resizeFloating :: Direction -> Window -> X ()
resizeFloating d = keysResizeWindow (direction d) (0 , 0)

direction :: Direction -> D
direction d = (dx , dy)
  where (dx , dy) = case d of
                      L -> (-pixel , 0)
                      D -> (0 , pixel)
                      U -> (0 , -pixel)
                      R -> (pixel , 0)
        pixel = 20

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

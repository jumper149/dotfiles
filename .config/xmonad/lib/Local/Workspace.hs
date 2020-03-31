module Local.Workspace ( Workspace (..)
                       , workspaceIds
                       ) where

import XMonad

data Workspace = WsBrowser
               | WsHacking
               | WsMedia
               | WsSocial
               | WsWriting
               | WsGIMP
               | WsGaming
               | WsControl
               | WsOther
               deriving (Eq, Ord, Read, Show, Enum, Bounded)

workspaceIds :: [WorkspaceId]
workspaceIds = show <$> wss
    where wss = [ minBound .. maxBound ] :: [Workspace]

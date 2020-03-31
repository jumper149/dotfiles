module Local.Workspace ( Workspace (..)
                       ) where

data Workspace = WsBrowser
               | WsHacking
               | WsMedia
               | WsSocial
               | WsWriting
               | WsGIMP
               | WsGaming
               | WsControl
               | WsOther
               deriving (Eq, Read, Show, Enum, Bounded)

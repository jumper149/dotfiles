module Local.Startup.Hook ( myStartupHook
                          ) where

import XMonad
import qualified XMonad.StackSet as S

import Local.Workspace ( Workspace (..)
                       )

myStartupHook :: X ()
myStartupHook = do fixSupportedAtoms
                   windows . S.greedyView $ show WsHacking

-- | Detect urgency of some programs like kitty (not covered in 'XMonad.Hooks.EwmhDesktops.ewmh'):
-- https://github.com/kovidgoyal/kitty/issues/1016#issuecomment-480472827
fixSupportedAtoms :: X ()
fixSupportedAtoms = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    c <- getAtom "ATOM"
    supp <- mapM getAtom [ "_NET_WM_STATE"
                         , "_NET_WM_STATE_DEMANDS_ATTENTION"
                         ]
    io $ changeProperty32 dpy r a c propModeAppend (fmap fromIntegral supp)

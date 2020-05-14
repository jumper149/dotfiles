{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

module XMonad.Local.Layout.Overwrite ( Choose (..)
                                     , LR (..)
                                     , (|||)
                                     , ChangeLayout (..)
                                     ) where

import XMonad hiding ( Choose
                     , (|||)
                     , ChangeLayout (..)
                     , hide
                     )
import qualified XMonad.StackSet as W

import Control.Arrow ( second
                     )
import Control.Monad
import Data.Maybe ( fromMaybe
                  )

------------------------------------------------------------------------
-- LayoutClass selection manager
-- Layouts that transition between other layouts

-- | Messages to change the current layout.
data ChangeLayout = FirstLayout | NextLayout deriving (Eq, Show, Typeable)

instance Message ChangeLayout

-- | The layout choice combinator
(|||) :: l a -> r a -> Choose l r a
(|||) = Choose L
infixr 5 |||

-- | A layout that allows users to switch between various layout options.
data Choose l r a = Choose LR (l a) (r a) deriving (Read, Show)

-- | Are we on the left or right sub-layout?
data LR = L | R deriving (Read, Show, Eq)

data NextNoWrap = NextNoWrap deriving (Eq, Show, Typeable)
instance Message NextNoWrap

-- | A small wrapper around handleMessage, as it is tedious to write
-- SomeMessage repeatedly.
handle :: (LayoutClass l a, Message m) => l a -> m -> X (Maybe (l a))
handle l m = handleMessage l (SomeMessage m)

-- | A smart constructor that takes some potential modifications, returns a
-- new structure if any fields have changed, and performs any necessary cleanup
-- on newly non-visible layouts.
choose :: (LayoutClass l a, LayoutClass r a)
       => Choose l r a-> LR -> Maybe (l a) -> Maybe (r a) -> X (Maybe (Choose l r a))
choose (Choose d _ _) d' Nothing Nothing | d == d' = return Nothing
choose (Choose d l r) d' ml      mr = f lr
 where
    (l', r') = (fromMaybe l ml, fromMaybe r mr)
    lr       = case (d, d') of
                    (L, R) -> (hide l'  , return r')
                    (R, L) -> (return l', hide r'  )
                    (_, _) -> (return l', return r')
    f (x,y)  = fmap Just $ liftM2 (Choose d') x y
    hide x   = fmap (fromMaybe x) $ handle x Hide

instance (LayoutClass l a, LayoutClass r a) => LayoutClass (Choose l r) a where
    runLayout (W.Workspace i (Choose L l r) ms) =
        fmap (second . fmap $ flip (Choose L) r) . runLayout (W.Workspace i l ms)
    runLayout (W.Workspace i (Choose R l r) ms) =
        fmap (second . fmap $ Choose R l) . runLayout (W.Workspace i r ms)

    description (Choose L l _) = description l
    description (Choose R _ r) = description r

    handleMessage lr m | Just NextLayout <- fromMessage m = do
        mlr' <- handle lr NextNoWrap
        maybe (handle lr FirstLayout) (return . Just) mlr'

    handleMessage c@(Choose d l r) m | Just NextNoWrap <- fromMessage m =
        case d of
            L -> do
                ml <- handle l NextNoWrap
                case ml of
                    Just _  -> choose c L ml Nothing
                    Nothing -> choose c R Nothing =<< handle r FirstLayout

            R -> choose c R Nothing =<< handle r NextNoWrap

    handleMessage c@(Choose _ l _) m | Just FirstLayout <- fromMessage m =
        flip (choose c L) Nothing =<< handle l FirstLayout

    handleMessage c@(Choose d l r) m | Just ReleaseResources <- fromMessage m =
        join $ liftM2 (choose c d) (handle l ReleaseResources) (handle r ReleaseResources)

    handleMessage c@(Choose d l r) m = do
        ml' <- case d of
                L -> handleMessage l m
                R -> return Nothing
        mr' <- case d of
                L -> return Nothing
                R -> handleMessage r m
        choose c d ml' mr'


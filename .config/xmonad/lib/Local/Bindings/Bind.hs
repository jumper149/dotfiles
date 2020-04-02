{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Local.Bindings.Bind ( Binding
                           , (|/-)
                           , Binder
                           , bind
                           , (^>)
                           , mkUsable
                           ) where

import XMonad
import Control.Monad.Writer

newtype Binder a = Binder (Writer [Binding] a)
    deriving (Functor, Applicative, Monad)

bind :: Binder a -> [Binding]
bind (Binder w) = execWriter w

data Binding = Binding { combination :: String
                       , explanation :: String
                       , action      :: X ()
                       }

(|/-) :: String -- ^ combination
      -> String -- ^ description
      -> X ()   -- ^ action
      -> Binding
(|/-) c d a = Binding { combination = c
                      , explanation = d
                      , action = a
                      }
infix 5 |/-

(^>) :: (X () -> Binding)
     -> X ()
     -> Binder ()
(^>) f x = Binder $ tell [f x]
infixr 0 ^>

mkUsable :: Binding -> (String,X ())
mkUsable binding = (combination binding , action binding)

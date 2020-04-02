{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Local.Bindings.Bind ( Binding
                           , (|/-)
                           , (^>)
                           , Binder
                           , bind
                           , bindAlias
                           , runBinder
                           , mkUsable
                           ) where

import XMonad

import Control.Monad.Writer
import Data.Foldable ( traverse_
                     )

newtype Binder a = Binder (Writer [Binding] a)
    deriving (Functor, Applicative, Monad)

bind :: Binding -> Binder ()
bind binding = do Binder $ tell [binding]

runBinder :: Binder a -> [Binding]
runBinder (Binder w) = execWriter w

bindAlias :: [String] -- ^ alias combination
      -> Binding
      -> Binder ()
bindAlias newCombinations binding = traverse_ (bind . newBinding) newCombinations
    where newBinding c = Binding { combination = c
                                 , explanation = "(alias: " <> combination binding <> ") | " <> explanation binding
                                 , action = action binding
                                 }

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
     -> Binding
(^>) f x = f x
infixr 0 ^>

mkUsable :: Binding -> (String,X ())
mkUsable binding = (combination binding , action binding)

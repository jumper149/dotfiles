module Local.Bindings.Bind ( Binding
                           , (|/-)
                           , (^>)
                           , mkUsable
                           ) where

import XMonad

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
infixl 5 |/-

(^>) :: (X () -> Binding)
     -> X ()
     -> Binding
(^>) f x = f x
infixr 0 ^>

mkUsable :: Binding -> (String,X ())
mkUsable binding = (combination binding , action binding)

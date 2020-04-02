{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Local.Bindings.Bind ( Binding
                           , (|/-)
                           , (^>)
                           , KeyCombination
                           , (...)
                           , Binder
                           , bind
                           , bindAlias
                           , bindZip
                           , KeyMap
                           , mapBindings'
                           , DocBindings
                           , mapBindings
                           , storeBindings
                           , getBindings
                           ) where

import XMonad
import qualified XMonad.Util.ExtensibleState as XS

import Control.Arrow ( (&&&)
                     )
import Control.Monad.Writer
import Data.Foldable ( traverse_
                     )
import qualified Data.Map as M

newtype Binder a = Binder (Writer [Binding] a)
    deriving (Functor, Applicative, Monad)

runBinder :: Binder a -> [Binding]
runBinder (Binder w) = execWriter w

bind :: Binding -> Binder ()
bind binding = Binder $ tell [binding]

bindAlias :: [KeyCombination] -- ^ alias combination
          -> Binding
          -> Binder ()
bindAlias newCombinations binding = do bind binding
                                       traverse_ (bind . newBinding) newCombinations
    where newBinding c = Binding { combination = c
                                 , explanation = paddedExplanation <> aliasExplanation
                                 , action = action binding
                                 }
          paddedExplanation = take 50 $ explanation binding <> repeat ' '
          aliasExplanation = "(alias: " <> keycombinationToString (combination binding) <> ")"

bindZip :: [KeyCombination]
        -> [String]
        -> [X ()]
        -> Binder ()
bindZip ks es as = traverse_ bind $ uncurry (uncurry (|/-)) <$> zip (zip ks es) as

mapBindings' :: (XConfig Layout -> Binder a)
             -> XConfig Layout -> KeyMap
mapBindings' = fst . mapBindings

newtype DocBindings = DocBindings String
    deriving (Eq, Semigroup, Monoid)

instance ExtensionClass DocBindings where
    initialValue = DocBindings "no Bindings stored\n"

storeBindings :: X DocBindings -> XConfig a -> XConfig a
storeBindings explainableBindings xConfig = xConfig { startupHook = store <+> startupHook xConfig
                                                    }
    where store = do newDoc <- explainableBindings
                     oldDoc <- XS.get :: X DocBindings
                     if oldDoc == initialValue
                        then XS.put newDoc
                        else XS.modify (<> newDoc)

getBindings :: X String
getBindings = do DocBindings doc <- XS.get
                 return doc

mapBindings :: (XConfig Layout -> Binder a)
            -> ((XConfig Layout -> KeyMap) , X DocBindings)
mapBindings binder = let bindMap xConfig = runBinder $ binder xConfig
                         bindings = M.fromList . fmap ((modifier &&& key) . combination &&& action) . bindMap
                         doc = DocBindings . explainBinds . bindMap <$> reader config
                      in (bindings , doc)

explainBinds :: Foldable f => f Binding -> String
explainBinds = foldr ((<>) . explain) ""
    where explain binding = let paddedKeys = take 25 $ keycombinationToString (combination binding) <> repeat ' '
                             in paddedKeys <> explanation binding <> "\n"

data Binding = Binding { combination :: KeyCombination
                       , explanation :: String
                       , action      :: X ()
                       }

(|/-) :: KeyCombination -- ^ combination
      -> String         -- ^ description
      -> X ()           -- ^ action
      -> Binding
(|/-) c d a = Binding { combination = c
                      , explanation = d
                      , action = a
                      }
infix 3 |/-

(^>) :: (X () -> Binding)
     -> X ()
     -> Binding
(^>) f x = f x
infixr 0 ^>

data KeyCombination = KeyCombination { modifier :: ButtonMask
                                     , key      :: KeySym
                                     }
                                     deriving (Eq, Ord)

(...) :: ButtonMask
      -> KeySym
      -> KeyCombination
(...) m k = KeyCombination { modifier = m
                           , key = k
                           }
infix 4 ...

keycombinationToString :: KeyCombination -> String
keycombinationToString c = show (modifier c) <> "-" <> keysymToString (key c)

type KeyCombinationId = (ButtonMask,KeySym)

type KeyMap = M.Map KeyCombinationId (X ())

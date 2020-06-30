{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module XMonad.Local.Bindings.Bind ( Binding
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
                                 , explanation = AliasExplanation (combination binding) (unexplanation $ explanation binding)
                                 , action = action binding
                                 }

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
            -> (XConfig Layout -> KeyMap , X DocBindings)
mapBindings binder = let bindMap xConfig = runBinder $ binder xConfig
                         bindings = M.fromList . fmap ((modifier &&& key) . combination &&& action) . bindMap
                         doc = DocBindings . describeBinds . bindMap <$> reader config
                      in (bindings , doc)

data Binding = Binding { combination :: KeyCombination
                       , explanation :: Explanation
                       , action      :: X ()
                       }

(|/-) :: KeyCombination -- ^ combination
      -> String         -- ^ explanation
      -> X ()           -- ^ action
      -> Binding
(|/-) c e a = Binding { combination = c
                      , explanation = Explanation e
                      , action = a
                      }
infix 3 |/-

(^>) :: (X () -> Binding)
     -> X ()
     -> Binding
(^>) f = f
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

maxKeycombinationStringLength :: Int
maxKeycombinationStringLength = 20

keycombinationToString :: KeyCombination -> String
keycombinationToString c = take maxKeycombinationStringLength $ modString <> keyString
    where modString = buttonmaskToString $ modifier c
          keyString = keysymToString $ key c

buttonmaskToString :: ButtonMask -> String
buttonmaskToString m = maybe "" (<> "-") $ M.lookup m modMap
    where modMap = M.fromList [ (mod1Mask , "M1")
                              , (mod1Mask .|. shiftMask , "M1-S")
                              , (mod1Mask .|. controlMask , "M1-C")
                              , (mod1Mask .|. controlMask .|. shiftMask , "M1-C-S")
                              , (mod2Mask , "M2")
                              , (mod2Mask .|. shiftMask , "M2-S")
                              , (mod2Mask .|. controlMask , "M2-C")
                              , (mod2Mask .|. controlMask .|. shiftMask , "M2-C-S")
                              , (mod3Mask , "M3")
                              , (mod3Mask .|. shiftMask , "M3-S")
                              , (mod3Mask .|. controlMask , "M3-C")
                              , (mod3Mask .|. controlMask .|. shiftMask , "M3-C-S")
                              , (mod4Mask , "M4")
                              , (mod4Mask .|. shiftMask , "M4-S")
                              , (mod4Mask .|. controlMask , "M4-C")
                              , (mod4Mask .|. controlMask .|. shiftMask , "M4-C-S")
                              , (mod5Mask , "M5")
                              , (mod5Mask .|. shiftMask , "M5-S")
                              , (mod5Mask .|. controlMask , "M5-C")
                              , (mod5Mask .|. controlMask .|. shiftMask , "M5-C-S")
                              ]

type KeyCombinationId = (ButtonMask,KeySym)

data Explanation = Explanation String
                 | AliasExplanation KeyCombination String

unexplanation :: Explanation -> String
unexplanation (Explanation e) = e
unexplanation (AliasExplanation _ e) = e

explain :: Explanation -> String
explain expl = case expl of
                 Explanation e -> take paddingAmount padding <> e <> "\n"
                 AliasExplanation kc e -> let alias = "(alias: " <> keycombinationToString kc <> ")"
                                           in take paddingAmount (alias <> padding) <> e <> "\n"
    where paddingAmount = maxKeycombinationStringLength + length "(alias: )"
          padding = repeat ' '

type KeyMap = M.Map KeyCombinationId (X ())

describe :: Binding -> String
describe binding = keyString <> explain (explanation binding)
    where keyString = take maxKeycombinationStringLength $ keycombinationToString (combination binding) <> repeat ' '

describeBinds :: Foldable f => f Binding -> String
describeBinds = foldr ((<>) . describe) ""

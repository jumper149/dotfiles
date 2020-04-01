{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

module Local.Layout.Choose ( MyChoose
                           , (||||)
                           ) where

import XMonad hiding ( Choose
                     , (|||)
                     , ChangeLayout ( NextLayout
                                    )
                     )
import qualified XMonad.StackSet as S
import XMonad.Layout.Spacing ( SpacingModifier (..)
                             )

import Data.Maybe ( fromMaybe
                  )

import Local.Overwrite.Layout ( Choose (..)
                              , (|||)
                              )

newtype MyChoose l r a = MyChoose (Choose l r a)
  deriving (Read, Show)

(||||) :: l a -> r a -> MyChoose l r a
(||||) l r = MyChoose $ l ||| r
infixr 5 ||||

instance (LayoutClass l a, LayoutClass r a) => LayoutClass (MyChoose l r) a where

    runLayout (S.Workspace i (MyChoose c) a) r = do (ls , mbC) <- runLayout (S.Workspace i c a) r
                                                    return (ls , MyChoose <$> mbC)

    description (MyChoose c) = description c

    handleMessage (MyChoose (Choose d l r)) sm =
        let sendBoth = do ml <- handleMessage l sm
                          mr <- handleMessage r sm
                          let l' = fromMaybe l $ ml
                              r' = fromMaybe r $ mr
                          return . Just . MyChoose $ Choose d l' r'
        in case fromMessage sm of
             Just (ModifyWindowBorderEnabled _) -> sendBoth
             Just (ModifyScreenBorderEnabled _) -> sendBoth
             _ -> do fmap MyChoose <$> handleMessage (Choose d l r) sm

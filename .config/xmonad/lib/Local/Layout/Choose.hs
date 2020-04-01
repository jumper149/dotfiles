{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

module Local.Layout.Choose ( ChooseSpacingBoth
                           , (-|||-)
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

newtype ChooseSpacingBoth l r a = ChooseSpacingBoth (Choose l r a)
  deriving (Read, Show)

(-|||-) :: l a -> r a -> ChooseSpacingBoth l r a
(-|||-) l r = ChooseSpacingBoth $ l ||| r
infixr 5 -|||-

instance (LayoutClass l a, LayoutClass r a) => LayoutClass (ChooseSpacingBoth l r) a where

    runLayout (S.Workspace i (ChooseSpacingBoth c) a) r = do (ls , mbC) <- runLayout (S.Workspace i c a) r
                                                             return (ls , ChooseSpacingBoth <$> mbC)

    description (ChooseSpacingBoth c) = description c

    handleMessage (ChooseSpacingBoth (Choose d l r)) sm =
        let sendBoth = do ml <- handleMessage l sm
                          mr <- handleMessage r sm
                          let l' = fromMaybe l $ ml
                              r' = fromMaybe r $ mr
                          return . Just . ChooseSpacingBoth $ Choose d l' r'
        in case fromMessage sm of
             Just (ModifyWindowBorderEnabled _) -> sendBoth
             Just (ModifyScreenBorderEnabled _) -> sendBoth
             _ -> do fmap ChooseSpacingBoth <$> handleMessage (Choose d l r) sm

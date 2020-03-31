module Local.ManageHook ( myManageHook
                        ) where

import XMonad
import XMonad.Actions.SpawnOn ( manageSpawn
                              )
import XMonad.Hooks.ManageHelpers ( doCenterFloat
                                  )

myManageHook :: ManageHook
myManageHook = manageSpawn <+> manageFloating

manageFloating :: ManageHook
manageFloating = composeAll [ className =? "matplotlib" --> doCenterFloat
                            , className =? "Gnuplot"    --> doCenterFloat
                            , className =? "gnuplot_qt" --> doCenterFloat
                            ]

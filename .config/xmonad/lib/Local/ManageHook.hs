module Local.ManageHook ( myManageHook
                        ) where

import XMonad
import XMonad.Hooks.ManageHelpers ( doCenterFloat
                                  )

myManageHook :: ManageHook
myManageHook = composeAll
                 [ className =? "matplotlib" --> doCenterFloat
                 , className =? "Gnuplot"    --> doCenterFloat
                 , className =? "gnuplot_qt" --> doCenterFloat
                 ]

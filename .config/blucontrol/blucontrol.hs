{-# LANGUAGE TypeApplications #-}

import Blucontrol
import Blucontrol.Control.Count
import Blucontrol.Control.Wait
import Blucontrol.Gamma.Linear
import Blucontrol.Recolor.X
import Blucontrol.RGB.Temperature

main :: IO ()
main = blucontrol configControl
  where configControl = ConfigControl { runControl = runControlCountT def !> runControlWaitT configWait
                                      , runGamma = runGammaLinearT @Temperature rgbMap
                                      , runRecolor = runRecolorXTIO def
                                      }
        rgbMap = 13:.00 ==> 7000
            :| [ 17:.00 ==> 5000
               , 00:.00 ==> 3500
               , 05:.30 ==> 3000
               , 08:.30 ==> 5500
               ]
        configWait = ConfigWait { interval = 10 * 1000000
                                }

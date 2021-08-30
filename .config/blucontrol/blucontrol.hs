{-# LANGUAGE TypeApplications #-}

import Control.Monad (void)

import Blucontrol
import Blucontrol.Monad.ApplyValue.X
import Blucontrol.Monad.Control.Count
import Blucontrol.Monad.Control.Wait
import Blucontrol.Monad.PrepareValue.Linear
import Blucontrol.Value.RGB.Temperature

main :: IO ()
main = void $ blucontrol configControl
  where configControl = ConfigControl { runControl = runControlCountT def !> runControlWaitT configWait
                                      , runPrepareValue = runPrepareValueLinearT @Temperature rgbMap
                                      , runApplyValue = runApplyValueXTIO def
                                      }
        rgbMap = 13:.00 ==> 7000
            :| [ 17:.00 ==> 5000
               , 00:.00 ==> 3500
               , 05:.30 ==> 3000
               , 08:.30 ==> 5500
               ]
        configWait = ConfigWait { interval = 10 * 1000000
                                }

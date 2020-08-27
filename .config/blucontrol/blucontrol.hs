import Blucontrol
import Blucontrol.Control.Count
import Blucontrol.Control.Wait
import Blucontrol.Gamma.Linear
import Blucontrol.Recolor.X

main :: IO ()
main = blucontrol configControl
  where configControl = ConfigControl { runControl = runControlCountT def !> runControlWaitT configWait
                                      , runGamma = runGammaLinearT rgbMap
                                      , runRecolor = runRecolorXTIO def
                                      }
        rgbMap = 13:.00 ==> temperature 7000
            :| [ 17:.00 ==> temperature 5000
               , 00:.00 ==> temperature 3500
               , 05:.30 ==> temperature 3000
               , 08:.30 ==> temperature 5500
               ]
        configWait = ConfigWait { interval = 10 * 1000000
                                }

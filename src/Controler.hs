module Controler(run) where

import Config
import View
import Controler.Internal


run :: Config -> IO ()
run cfg =
    if      get isHelp    then showUsage
    else if get isVersion then showVersion
    else do
        waitAndNotify (get timeValue) (get timeType)
        if get isPlaySound then playSound $ get soundPath else mempty
    where get f = f cfg
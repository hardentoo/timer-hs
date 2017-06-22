module Controler(run) where

import Config
import View
import Control.Concurrent(threadDelay)

type Seconds = Int

run :: Config -> IO ()
run cfg =
    if      get isHelp    then showUsage
    else if get isVersion then showVersion
    else do
        waitAndNotify (get timeValue) (get timeType)
        if get isPlaySound then playSound (get soundPath) else mempty
    where get f = f cfg

waitAndNotify :: Seconds -> TimeType -> IO ()
waitAndNotify n tt = do
    threadDelay $ 1000000 * n
    let p   = if tt == Second then n else (n `div` 60)
        msg = show p ++ " " ++ (timeTypeToName tt n) ++ " passed"
    showMessage msg
    showNotification msg

timeTypeToName :: TimeType -> Seconds -> String
timeTypeToName tt n = case tt of
    Minute -> if n == 60 then "minute" else "minutes"
    Second -> if n == 1  then "second" else "seconds"
module Controler.Internal
    ( waitAndNotify
    , timeTypeToName
    ) where

import Control.Concurrent(threadDelay)
import Config(TimeType(..))
import View

type Seconds = Int


waitAndNotify :: Seconds -> TimeType -> IO ()
waitAndNotify n tt = do
    threadDelay $ 1000000 * n
    let p   = if tt == Second then n else n `div` 60
        msg = show p ++ " " ++ timeTypeToName tt n ++ " passed"
    showMessage msg >> showNotification msg

timeTypeToName :: TimeType -> Seconds -> String
timeTypeToName tt n = case tt of
    Minute -> if n == 60 then "minute" else "minutes"
    Second -> if n == 1  then "second" else "seconds"
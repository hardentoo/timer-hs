module Usage
    ( usage
    , version
    ) where

import qualified Paths_timer_hs as P (version)
import qualified Data.Version as V (showVersion)


usage :: IO ()
usage = putStrLn "Usage of timer-hs: \n\n\
        \  timer-hs [time]\n\n\
        \  -m, --minutes   Set time value to minutes [default]\n\
        \  -s, --seconds   Set time value to seconds\n\
        \  -n, --no-sound  Don't play a sound when timer is done\n\
        \  -h, --help      Print help information\n\
        \  -v, --version   Print version information\n"

-- \  -f, --file      Sound file to play\n
-- \      --verbose   Print verbose application status\n

version :: IO ()
version = putStrLn $ "timer-hs  "++ V.showVersion P.version
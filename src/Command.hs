module Command
    ( notify
    , playSound
    , Message
    ) where

import System.Process

type Message = String


notify :: Message -> IO ()
notify msg = callProcess "notify-send" ["TIMER", msg]

playSound :: FilePath -> IO ()
playSound fp = createProcess(shell $ "cvlc --no-video "++ fp ++" vlc://quit")
  { std_err = NoStream
  , std_out = NoStream
  }
  >> mempty
module Command
    ( notify
    , playSound
    , Message
    ) where

import System.Process
-- TODO
-- fix playSound() to work with a relative path too

type Message = String

notify :: Message -> IO ()
notify msg = callProcess "notify-send" ["TIMER", msg]


playSound :: FilePath -> IO ()
playSound fp = createProcess(proc "cvlc"
      [ "--no-video"
      , fp
      , "vlc://quit"
      ])
  { std_err = NoStream
  , std_out = NoStream
  }
  >> mempty
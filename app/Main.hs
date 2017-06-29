module Main where

import System.Environment(getArgs)
import Control.Monad.Reader(runReaderT)
import Controler
import Config


main :: IO ()
main = getArgs >>= runReaderT run . configFrom

configFake :: Config
configFake = Config
    { timeValue   = 2
    , timeType    = Second
    , isHelp      = False
    , isVersion   = False
    , isPlaySound = True
    , soundPath   = "~/.local/bin/timer_sound/sound1.ogg"
    }
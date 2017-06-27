module Config
    ( TimeType(..)
    , Config(..)
    , configFrom
    ) where

import Config.Internal
-- TODO
-- configFrom() should support '--file' flag


data Config = Config { timeValue   :: Int
                     , timeType    :: TimeType
                     , isHelp      :: Bool
                     , isVersion   :: Bool
                     , isPlaySound :: Bool
                     , soundPath   :: FilePath
                     } deriving (Show, Eq)

configFrom :: [String] -> Config
configFrom [] = Config 0 Second True False False ""
configFrom xs = let
    tt = if has ["-s", "--seconds"] then Second else Minute
    in Config
        { timeValue   = getTimeValue xs tt
        , timeType    = tt
        , isHelp      = has       ["-h", "--help"]
        , isVersion   = has       ["-v", "--version"]
        , isPlaySound = not $ has ["-n", "--no-sound"]
        , soundPath   = "~/.local/bin/timer_sound/sound1.ogg"
        }
    where has = flip isFlagSet xs
module Config
    ( TimeType(..)
    , Config(..)
    , configFrom
    , configFake -- rm later
    ) where

import Data.List(isPrefixOf)
import Data.Char(isDigit)
import Data.Maybe(fromMaybe)
import Control.Monad(mfilter, guard)
-- TODO
-- configFrom() should support '--file' flag

type Flags = [String]

data TimeType = Second | Minute deriving (Show, Eq)

data Config = Config { timeValue   :: Int
                     , timeType    :: TimeType
                     , isHelp      :: Bool
                     , isVersion   :: Bool
                     , isPlaySound :: Bool
                     , soundPath   :: FilePath
                     } deriving (Show)

configFrom :: [String] -> Config
configFrom xs = let
        _timeType = if has ["-s", "--seconds"] then Second else Minute
    in Config
        { timeValue   = getTimeValue xs _timeType
        , timeType    = _timeType
        , isHelp      = has       ["-h", "--help"]
        , isVersion   = has       ["-v", "--version"]
        , isPlaySound = not $ has ["-n", "--no-sound"]
        , soundPath   = "~/.local/bin/timer_sound/sound1.ogg"
        }
    where has = flip isFlagSet xs

getTimeValue :: [String] -> TimeType -> Int
getTimeValue xs tt = let
    n = toInt 0 . getItem 0 . filter (not . isPrefixOf "-") $ xs
    in if tt == Minute then n * 60 else n

getItem :: Int -> [a] -> Maybe a
getItem n xs = do
    let len = length xs
    guard(n < 0 || len == 0 || len -1 < n)
    pure $ xs !! n

toInt :: Int -> Maybe String -> Int
toInt fallback (Just []) = fallback
toInt fallback m = fromMaybe fallback $ read <$> mfilter (all isDigit) m

isFlagSet :: Flags -> [String] -> Bool
isFlagSet = any . flip elem

configFake :: Config
configFake = Config
    { timeValue   = 2
    , timeType    = Second
    , isHelp      = False
    , isVersion   = False
    , isPlaySound = True
    , soundPath   = "~/.local/bin/timer_sound/sound1.ogg"
    }
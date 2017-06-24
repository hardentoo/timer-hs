module Config
    ( TimeType(..)
    , Config(..)
    , configFrom
    , configFake -- rm later
    ) where

import Data.List(isPrefixOf)
import Data.Char(isDigit)
import Data.Maybe(fromMaybe)
import Control.Monad(mfilter)
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
    where has ys = isFlagSet ys xs

getTimeValue :: [String] -> TimeType -> Int
getTimeValue xs tt = let
    n = toInt 0 . getItem 0 . filter (\x -> not $ isPrefixOf "-" x) $ xs
    in if tt == Minute then n * 60 else n

getItem :: Int -> [a] -> Maybe a
getItem n xs
    | n < 0 || length xs == 0 = Nothing
    | (length xs) -1 < n      = Nothing
    | otherwise               = Just $ xs !! n

toInt :: Int -> Maybe String -> Int
toInt fallback (Just []) = fallback
toInt fallback m = fromMaybe fallback $ read <$> mfilter (all isDigit) m

isFlagSet :: Flags -> [String] -> Bool
isFlagSet xs = any $ \x -> elem x xs

configFake :: Config
configFake = Config
    { timeValue   = 2
    , timeType    = Second
    , isHelp      = False
    , isVersion   = False
    , isPlaySound = True
    , soundPath   = "~/.local/bin/timer_sound/sound1.ogg"
    }
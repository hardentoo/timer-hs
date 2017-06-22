module Config
    ( TimeType(..)
    , Config(..)
    , configFrom
    , configFake -- rm later
    ) where

import Data.List(isPrefixOf)
import Data.Char(isDigit)
import Data.Maybe(fromMaybe)
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
        _timeType    = if has    ["-s", "--seconds"] then Second else Minute
        _isHelp      = has       ["-h", "--help"]
        _isVersion   = has       ["-v", "--version"]
        _isPlaySound = not $ has ["-n", "--no-sound"]
    in Config
        { timeValue   = getTimeValue xs _timeType
        , timeType    = _timeType
        , isHelp      = _isHelp
        , isVersion   = _isVersion
        , isPlaySound = _isPlaySound
        , soundPath   = "/home/tux/.local/bin/timer_sound/sound1.ogg"
        }
    where has ys = isFlagSet ys xs

getTimeValue :: [String] -> TimeType -> Int
getTimeValue xs tt = let
    n = charToInt 0 . getItem 0 . filter (\x -> not $ isPrefixOf "-" x) $ xs
    in if tt == Minute then n * 60 else n

getItem :: Int -> [a] -> Maybe a
getItem n xs
    | n < 0 || length xs == 0 = Nothing
    | (length xs) -1  < n     = Nothing
    | otherwise               = Just $ xs !! n

charToInt :: Int -> Maybe String -> Int
charToInt fallback m = fromMaybe fallback $ do
    s <- m
    if all isDigit s then Just $ read s else Nothing

isFlagSet :: Flags -> [String] -> Bool
isFlagSet xs = any $ \x -> elem x xs

configFake :: Config
configFake = Config
    { timeValue = 2
    , timeType = Second
    , isHelp = False
    , isVersion = False
    , isPlaySound = True
    , soundPath = "/home/tux/.local/bin/timer_sound/sound1.ogg"
    }
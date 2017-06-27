module Config.Internal
    ( TimeType(..)
    , getTimeValue
    , getItem
    , toInt
    , isFlagSet
    ) where

import Data.List(isPrefixOf)
import Data.Char(isDigit)
import Data.Maybe(fromMaybe)
import Control.Monad(mfilter, guard)

type Flags = [String]

data TimeType = Second | Minute deriving (Show, Eq)


getTimeValue :: [String] -> TimeType -> Int
getTimeValue xs tt = let
    n = toInt 0 . getItem 0 . filter (not . isPrefixOf "-") $ xs
    in if tt == Minute then n * 60 else n

getItem :: Int -> [a] -> Maybe a
getItem n xs = do
    let len = length xs
    guard(n >= 0 && len > 0 && n <= len -1)
    pure $ xs !! n

toInt :: Int -> Maybe String -> Int
toInt fallback (Just []) = fallback
toInt fallback m = fromMaybe fallback $ read <$> mfilter (all isDigit) m

isFlagSet :: Flags -> [String] -> Bool
isFlagSet = any . flip elem
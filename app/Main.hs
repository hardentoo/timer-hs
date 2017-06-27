module Main where

import System.Environment (getArgs)
import Controler
import Config

main :: IO ()
main = getArgs >>= run . configFrom
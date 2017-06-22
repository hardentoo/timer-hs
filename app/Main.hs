module Main where

import System.Environment (getArgs)
import Controler
import Config
import View

main :: IO ()
main = getArgs >>= \args ->
    if null args then showUsage else run $ configFrom args

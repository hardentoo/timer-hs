module View
    ( showUsage
    , showVersion
    , showNotification
    , showMessage
    , playSound
    ) where

import Usage
import qualified Command as CMD


showUsage :: IO ()
showUsage = usage

showVersion :: IO ()
showVersion = version

showNotification :: CMD.Message -> IO ()
showNotification = CMD.notify

showMessage :: String -> IO ()
showMessage = putStrLn

playSound :: FilePath -> IO ()
playSound = CMD.playSound
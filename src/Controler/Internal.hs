{-# LANGUAGE FlexibleContexts #-}
module Controler.Internal
    ( timeTypeToName
    , waitAndNotify
    ) where

import Control.Monad.Reader
import Control.Concurrent(threadDelay)
import View(showMessage, showNotification)
import Config


timeTypeToName :: (Functor m, MonadReader Config m) => m String
timeTypeToName = do
    tt <- reader timeType
    n  <- reader timeValue
    pure $ case tt of
        Minute -> if n == 60 then "minute" else "minutes"
        Second -> if n == 1  then "second" else "seconds"

waitAndNotify :: (MonadReader Config m, MonadIO m) => m ()
waitAndNotify = do
    n    <- reader timeValue
    tt   <- reader timeType
    name <- timeTypeToName
    liftIO $ threadDelay $ 1000000 * n
    let p   = if tt == Second then n else n `div` 60
        msg = show p ++ " " ++ name ++ " passed"
    liftIO $ showMessage msg >> showNotification msg
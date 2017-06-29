{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module Controler.Internal
    ( MonadControler(..)
    , runMonadControler
    , timeTypeToName
    , waitAndNotify
    ) where

import Control.Monad.Reader
import Control.Concurrent(threadDelay)
import View(showMessage, showNotification)
import Config

newtype MonadControler a = MonadControler {
      toReaderT :: ReaderT Config IO a
    } deriving (Functor, Applicative, Monad, MonadReader Config, MonadIO)


runMonadControler :: MonadControler a -> Config -> IO a
runMonadControler m cfg = runReaderT (toReaderT m) cfg

timeTypeToName :: (MonadReader Config m) => m String
timeTypeToName = do
    tt <- reader timeType
    n  <- reader timeValue
    pure $ case tt of
        Minute -> if n == 60 then "minute" else "minutes"
        Second -> if n == 1  then "second" else "seconds"

waitAndNotify :: MonadControler ()
waitAndNotify = do
    n    <- reader timeValue
    tt   <- reader timeType
    name <- timeTypeToName
    liftIO $ threadDelay $ 1000000 * n
    let p   = if tt == Second then n else n `div` 60
        msg = show p ++ " " ++ name ++ " passed"
    liftIO $ showMessage msg >> showNotification msg
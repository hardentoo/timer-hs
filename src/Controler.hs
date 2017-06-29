{-# LANGUAGE FlexibleContexts #-}
module Controler
    ( run
    , MonadControler(..)
    , runMonadControler
    ) where

import Control.Monad.Reader
import Controler.Internal
import Config
import View


run :: MonadControler ()
run = do
    help    <- reader isHelp
    version <- reader isVersion
    if      help    then liftIO $ showUsage
    else if version then liftIO $ showVersion
    else do
        waitAndNotify
        _isPlaySound <- reader isPlaySound
        _soundPath   <- reader soundPath
        if _isPlaySound then liftIO $ playSound _soundPath else pure mempty
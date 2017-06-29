module ControlerSpec(main, spec) where

import Test.Hspec
import Control.Monad.Reader(runReaderT)
import Control.Monad.Identity
import Config(Config(..), TimeType(..))
import Controler
import Controler.Internal


main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "timeTypeToName" $ do
        it "second" $ do
            runIdentity (timeTypeToName' Second 1) `shouldBe` "second"
        it "seconds" $ do
            runIdentity (timeTypeToName' Second 2) `shouldBe` "seconds"
        it "minute" $ do
            runIdentity (timeTypeToName' Minute 60) `shouldBe` "minute"
        it "minutes" $ do
            runIdentity (timeTypeToName' Minute 180) `shouldBe` "minutes"
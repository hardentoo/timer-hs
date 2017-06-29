module ControlerSpec
    ( main
    , spec
    ) where

import Test.Hspec
import Control.Monad.Reader(runReaderT)
import Config(Config(..), TimeType(..))
import Controler
import Controler.Internal


main :: IO ()
main = hspec spec

runT :: TimeType -> Int -> [String]
runT tt n = runReaderT timeTypeToName $ Config n tt False False False ""

spec :: Spec
spec = do
    describe "timeTypeToName" $ do
        it "second" $ do
            runT Second 1 `shouldBe` ["second"]
        it "seconds" $ do
            runT Second 2 `shouldBe` ["seconds"]
        it "minute" $ do
            runT Minute 60 `shouldBe` ["minute"]
        it "minutes" $ do
            runT Minute 180 `shouldBe` ["minutes"]
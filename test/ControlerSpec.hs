module ControlerSpec
    ( main
    , spec
    ) where

import Test.Hspec
import Config(TimeType(..))
import Controler
import Controler.Internal


main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "timeTypeToName" $ do
        it "second" $ do
            timeTypeToName Second 1 `shouldBe` "second"
        it "seconds" $ do
            timeTypeToName Second 2 `shouldBe` "seconds"
        it "minute" $ do
            timeTypeToName Minute 60 `shouldBe` "minute"
        it "minutes" $ do
            timeTypeToName Minute 180 `shouldBe` "minutes"
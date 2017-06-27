module ConfigSpec
    ( main
    , spec
    ) where

-- import Test.QuickCheck (property)
import Test.Hspec
import Config
import Config.Internal


main :: IO ()
main = hspec spec

spec :: Spec
spec = do
    describe "config" $ do
        it "ok  | -m 3" $ do
            let file = "~/.local/bin/timer_sound/sound1.ogg"
                cfg  = Config 180 Minute False False True file
            configFrom ["-m", "3"] `shouldBe` cfg
        it "empty | show usage" $ do
            configFrom [] `shouldBe` Config 0 Second True False False ""

    describe "getItem" $ do
        it "ok" $ do
            getItem 0 ["a"] `shouldBe` Just "a"
        it "negative index" $ do
            getItem (-1) ["a"] `shouldBe` Nothing
        it "index too big" $ do
            getItem 1 ["a"] `shouldBe` Nothing

    describe "toInt" $ do
        it "ok" $ do
            toInt 0 (Just "3") `shouldBe` 3
        it "not-a-number" $ do
            toInt 0 (Just "a3") `shouldBe` 0
    
    describe "isFlagSet" $ do
        it "ok" $ do
            isFlagSet ["--version", "b", "-v"] ["-x", "-v"] `shouldBe` True
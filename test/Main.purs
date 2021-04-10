module Test.Main where

import Prelude

import Effect (Effect)
import Effect.Aff (launchAff_)
import Effect.Class (liftEffect)
import Test.Spec.Runner (runSpec)
import Test.Spec.Reporter.Console (consoleReporter)
import Test.Spec (it, describe, Spec)
import Test.Spec.Assertions (shouldNotEqual)
import Data.Either (Either)

import Simmer.Random (library)
import Interpret as I

main :: Effect Unit
main = launchAff_ $ runSpec [consoleReporter] do
    suite

suite :: Spec Unit
suite = describe "std library Random tests" do
    randomSimple

eval :: String -> Effect (Either String I.Value)
eval = I.eval' [ library ]

randomSimple :: Spec Unit
randomSimple = describe "Simple random stuff" do
    -- Technically non-deterministic, but very unlikely to fail. Not sure how to test random stuff.
    it "Test random function" do
       result1 <- liftEffect $ eval "random!"
       result2 <- liftEffect $ eval "random!"
       result1 `shouldNotEqual` result2

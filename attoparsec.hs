{-# LANGUAGE OverloadedStrings #-}
module Main where
import Data.Attoparsec.Text


testString = "hello there"
p1 = string "hello"


main = do
  print $ parse p1 testString

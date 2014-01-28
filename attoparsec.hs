{-# LANGUAGE OverloadedStrings #-}
module Main where
import Prelude hiding (takeWhile)
import Data.Char
import Data.Text (Text)
import qualified Data.Text as T
import Data.Attoparsec.Text
import Control.Applicative

testString = "hello world one two three red banana mars"


p1 :: Parser Text
p1 = string "hello"


data Chunk = Tag Text | Noise Text
  deriving (Show)


p2 :: Parser [Chunk]
p2 = (choice $ tags ++ [noise]) `sepBy1` many1 space

tags = map f [string "hello", string "world", string "hello world", string "one two", string "red"]
    where f = (\parser -> Tag <$> parser )
noise = Noise <$> takeWhile1 (not. isSpace)

main = do
  parseTest p1 testString
  let res = parseOnly p2 testString
  print res
  print $ [x | x@(Tag {}) <- either (const []) id res]

{-# LANGUAGE OverloadedStrings #-}
module Main where
import Prelude hiding (takeWhile)
import Data.Char
import Data.Text (Text)
import qualified Data.Text as T
import Data.Attoparsec.Text
import Control.Applicative
import Control.Monad

testString = "hello world one two three red banana mars"


p1 :: Parser Text
p1 = string "hello"


data Chunk = Tag Text | Noise Text
  deriving (Show)


p2 :: Parser [Chunk]

-- choice and msum seem to work the same way
p2 = (choice $ tags ++ [noise]) `sepBy1` many1 space

{-

msum        :: MonadPlus m => [m a] -> m a
msum        =  foldr mplus mzero

choice :: Alternative f => [f a] -> f a
choice = foldr (<|>) empty

class Applicative f => Alternative f where
(<|>) :: f a -> f a -> f a

-}


tags = map f ["hello", "world", "hello world", "one two", "red"]
    where f = fmap Tag . string
noise = Noise <$> takeWhile1 (not. isSpace)

main = do
  parseTest p1 testString
  let res = parseOnly p2 testString
  print res
  print $ [x | x@(Tag {}) <- either (const []) id res]

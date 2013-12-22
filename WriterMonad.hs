module Main where
import Control.Monad.Writer


writer1 :: Writer [String] String
writer1 = do
  tell ["hello"]
  return "world"

main = do 
  print $ runWriter writer1

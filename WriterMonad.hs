module Main where
import Control.Monad.Writer


writer1 :: Writer [String] String
writer1 = do
  tell ["hello"]
  return "world"

writerT :: WriterT [String] IO String
writerT = do
  tell ["hello"]
  liftIO $ putStrLn "Enter a string"
  input <- liftIO $ getLine
  return input


main = do 
  print $ runWriter writer1
  r <- runWriterT writerT
  print r

module Main where
import Control.Monad

lookupM :: (MonadPlus m, Eq a) => a -> [(a, b)] -> m b
lookupM _ [] = mzero
lookupM k ((x,y):xys)
  | x == k    = return y `mplus` lookupM k xys
  | otherwise = lookupM k xys

main = do 
  print ((Just "test" >>= return Nothing) :: Maybe String)
  print ((Nothing >>= return Just "test") :: Maybe String)
  print $ Nothing `mplus` Just 1
  print $ Just 1 `mplus` Nothing
  putStrLn "lookupM:"
  print $ (lookupM "b" [("a", 1234), ("b", 2345), ("c", 999), ("b", 777)] :: Maybe Int)
  print $ (lookupM "b" [("a", 1234), ("b", 2345), ("c", 999), ("b", 777)] :: [Int])


  


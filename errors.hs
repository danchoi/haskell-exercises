module Main where

divBy :: (Monad m, Integral a) => a -> [a] -> m [a]
divBy _ [] = return []
divBy _ (0:_) = fail "div by zero error"
divBy n (d:ds) = do
    xs <- n `divBy` ds 
    return ((n `div` d) : xs)
  
divByMaybe :: (Integral a) => a -> [a] -> Maybe [a]
divByMaybe = divBy

main = do 
  print $ (50 `divByMaybe` [5, 10, 25]) 
  print $ ((50 `divBy` [5, 10, 25]) :: Maybe [Int])
  print $ ((50 `divBy` [5, 0, 25]) :: Maybe [Int])
  print $ ((50 `divBy` [5, 10, 25]) :: [[Integer]])
  print $ ((50 `divBy` [5, 10, 25]) :: Either String [Integer])
  print $ ((50 `divBy` [5, 10, 25]) :: ((->) String [Int])) "test" -- reader monad


{-
Results

Just [10,5,2]
Just [10,5,2]
Nothing
[[10,5,2]]
Right [10,5,2]
[10,5,2]

-}

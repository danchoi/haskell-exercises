module Main where

-- foldl :: (a -> b -> a) -> a -> [b] -> a
-- foldr :: (a -> b -> b) -> b -> [a] -> b

-- filter implemented with foldr

foldrfilter :: (a -> Bool) -> [a] -> [a]
foldrfilter p xs = foldr step [] xs
  where step x ys | p x       = x:ys
                  | otherwise = ys


main = do
  let xs = [1,2,3]
  print (foldrfilter (>=2) xs == filter (>= 2) xs)
                   




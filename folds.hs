module Main where

-- foldl :: (a -> b -> a) -> a -> [b] -> a
-- foldr :: (a -> b -> b) -> b -> [a] -> b

-- filter implemented with foldr

foldrFilter :: (a -> Bool) -> [a] -> [a]
foldrFilter p xs = foldr step [] xs
  where step x ys | p x       = x:ys
                  | otherwise = ys

-- sum as a foldl
foldlSum :: Num a => [a] -> a
foldlSum xs = foldl step 0 xs
  where step acc x = acc + x

foldlSum2 xs = foldl (+) 0 xs

foldrMap :: (a -> b) -> [a] -> [b]
foldrMap f as = foldr step [] as
  where step a bs  = (f a) : bs
  

main = do
  let xs = [1,2,3]

  print (foldrFilter (>=2) xs == foldrFilter (>= 2) xs)
  
  print (foldlSum xs == sum xs)
  print (foldlSum2 xs == sum xs)

  print (foldrMap (*2) xs == map (*2) xs)



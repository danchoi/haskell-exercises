module Main where
import Data.Ratio
import Data.List (all)
import Control.Monad

newtype Prob a = Prob { getProb :: [(a, Rational)] } deriving (Show)

instance Functor Prob where
  fmap f (Prob xs) = Prob $ map (\(x, p) -> (f x, p)) xs

flatten :: Prob (Prob a) -> Prob a
flatten (Prob xs) = Prob $ concat $ map multAll xs
  where multAll (Prob innerxs, p) = map (\(x, r) -> (x, p*r)) innerxs

instance Monad Prob where
  return x = Prob [(x, 1%1)]
  m >>= f = flatten (fmap f m)
  fail _ = Prob []

data Coin = Heads | Tails deriving (Show, Eq)

coin :: Prob Coin
coin = Prob [(Heads, 1%2), (Tails, 1%2)]
loadedCoin :: Prob Coin
loadedCoin = Prob [(Heads, 1%10), (Tails, 9%10)]


flip2 :: Prob Bool
flip2 = do
  a <- coin
  b <- coin
  return $ all (==Tails) [a,b]

flip3 :: Prob Bool
flip3 = do
  a <- coin
  b <- coin
  c <- loadedCoin
  return $ all (==Tails) [a,b,c]

flip1 :: Prob Bool
flip1 = do
  a <- coin
  return $ (==Tails) a

main = do

  -- putStrLn . show $ fmap negate (Prob [(3, 1%2), (5, 1%4), (9, 1%4)])
  putStrLn . show $ getProb flip3
  putStrLn . show $ getProb flip2
  putStrLn . show $ getProb flip1
  putStrLn . show . getProb $ do
    coin
    b <- coin
    c <- loadedCoin
    return [c, b]
  print $ do
    [1,2]
    b <- [3,4]
    c <- [5,6]
    return (b, c)

  putStrLn . show $ do 
    [1,2]
    [3,4]
  print $ [1,2] >>= \_ ->  [3,4]


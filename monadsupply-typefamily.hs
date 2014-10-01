{-# LANGUAGE TypeFamilies, GeneralizedNewtypeDeriving #-}
module Main where
import Control.Monad.State
import Control.Applicative
import System.Random hiding (next)

newtype Supply s a = S (State [s] a) deriving (Monad, Applicative, Functor)
runSupply :: Supply s a -> [s] -> (a, [s])
runSupply (S m) xs = runState m xs

next' :: Supply s (Maybe s)
next' = S $ do st <- get
               case st of
                [] -> return Nothing
                (x:xs) -> do put xs
                             return (Just x)

randomsIO :: Random a => IO [a]
randomsIO = 
  getStdRandom $ \g -> 
    let (a, b) = split g
    in (randoms a, b)

class (Monad m) => MonadSupply m where 
  type Elem m
  next :: m (Maybe (Elem m))

instance MonadSupply (Supply s) where
  type Elem (Supply s) = s
  next = next'

main = do 
  print 1
  print $ runSupply next [1,2,3]
  print $ runSupply (liftM2 (,) next next) [1,2,3] -- ((Just 1,Just 2), [3])
  (fst . runSupply next) `fmap` (randomsIO :: IO [Int]) >>= print -- e.g. Just (-42471132057894539)



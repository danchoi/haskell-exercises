{-# LANGUAGE DeriveDataTypeable #-}
module Main where
import Prelude hiding (catch)
import Control.Exception
import Data.Typeable

data MyException = MyException deriving (Show, Typeable)
instance Exception MyException

main = do
  throw MyException `catch` \e -> print (e :: MyException)

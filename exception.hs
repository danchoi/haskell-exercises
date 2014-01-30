{-# LANGUAGE DeriveDataTypeable #-}
module Main where
import Prelude hiding (catch)
import Control.Exception
import Data.Typeable

data MyException = MyException deriving (Show, Typeable)
instance Exception MyException

main = do
  throw MyException `catch` \e -> print (e :: MyException)
  throw (ErrorCall "ErrorCall: hello from error call") `catch` \e -> print (e :: SomeException)

  -- note: Catching SomeException is not good practice

  res <- try (readFile "nonexistent") :: IO (Either IOException String)
  print res

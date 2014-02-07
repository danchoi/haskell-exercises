module Main where
import Test.QuickCheck
import qualified Data.Text as T


prop_convert xs = xs == ((T.unpack . T.pack $ xs) :: String)


main = do 
  quickCheck prop_convert
  quickCheckResult prop_convert
  verboseCheck prop_convert

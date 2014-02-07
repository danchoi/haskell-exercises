module Main where
import Test.QuickCheck
import qualified Data.Text as T


prop_convert xs = xs == ((T.unpack . T.pack $ xs) :: String)

data Color = Red | White | Blue deriving (Show, Ord, Eq, Read)

instance Arbitrary Color where
  arbitrary = do 
    n <- choose (0,3) :: Gen Int
    return $ case n of 
      0 -> Red
      1 -> White
      2 -> Blue

main = do 
  quickCheck prop_convert
  quickCheckResult prop_convert

  -- verboseCheck prop_convert -- too noisy

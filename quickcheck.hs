module Main where
import Test.QuickCheck
import qualified Data.Text as T


prop_convert xs = xs == ((T.unpack . T.pack $ xs) :: String)

data Color = Red | White | Blue deriving (Show, Ord, Eq, Read)

newtype ColorString = ColorString String deriving (Show, Ord, Eq, Read)

instance Arbitrary Color where
  arbitrary = do 
    n <- choose (0,2) :: Gen Int
    return $ case n of 
      0 -> Red
      1 -> White
      2 -> Blue

instance Arbitrary ColorString where
  arbitrary = do 
    n <- choose (0,2) :: Gen Int
    return $ case n of 
      0 -> ColorString "Red"
      1 -> ColorString "White"
      2 -> ColorString "Blue"
      _ -> error "No colorstring to generate"

colorToColorString = ColorString . show 

stringToColor :: ColorString -> Color
stringToColor (ColorString x) = read x
stringToColor _  = error "Unknown Color"

-- this is silly
prop_color x = colorToColorString x == (colorToColorString . stringToColor . colorToColorString $ x)
prop_colorstring x = stringToColor x == (stringToColor . colorToColorString . stringToColor $ x)


main = do 
  quickCheck prop_convert
  quickCheckResult prop_convert
  quickCheckResult prop_color

  -- verboseCheck prop_convert -- too noisy

module Main where
import Text.Regex.Posix


s1 = "To the last syllable of recorded time time"

main = do
  print $ (s1 =~ "time" :: Bool)
  print $ (s1 =~ "time" :: Int)
  print $ (s1 =~ "time" :: String)
  print $ (s1 =~ "time" :: [MatchArray])
  print $ (s1 =~ "time" :: [MatchText String])
  let n :: AllTextMatches [] String
      n = s1 =~ "time"
  print $ getAllTextMatches n


{-

see
http://hackage.haskell.org/package/regex-base-0.93.2/docs/Text-Regex-Base-RegexLike.html#t:RegexContext


-}


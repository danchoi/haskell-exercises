module Main where
import Text.Regex.Posix


s1 = "To the last syllable of recorded time time"

main = do
  print $ (s1 =~ "time" :: Bool)
  print $ (s1 =~ "time" :: Int) 
  print $ (s1 =~ "time" :: String)
  print $ (s1 =~ "time" :: [MatchArray])
  print $ (s1 =~ "time" :: [MatchText String])
  print $ getAllTextMatches $ (s1 =~ "(time|recorded)" :: AllTextMatches [] String)
  print $ getAllTextMatches $ (s1 =~ "time" :: AllTextMatches [] String)


{-
True
2
"time"
[array (0,0) [(0,(33,4))],array (0,0) [(0,(38,4))]]
[array (0,0) [(0,("time",(33,4)))],array (0,0) [(0,("time",(38,4)))]]
["recorded","time","time"]
["time","time"]

see
http://hackage.haskell.org/package/regex-base-0.93.2/docs/Text-Regex-Base-RegexLike.html#t:RegexContext

http://lukeplant.me.uk/blog/posts/haskell-api-docs-suck-a-lot/

-}


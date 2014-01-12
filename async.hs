module Main where
import Control.Concurrent.Async
import Network.Curl

getURL :: URLString -> IO (CurlCode, String)
getURL url = do
  (code, resp) <- curlGetString url [CurlFollowLocation True] 
  return (code, resp)

url1 = "http://reddit.com"
url2 = "http://news.ycombinator.com"

main = do
  putStrLn "test sync"
  r1 <- getURL url1
  putStrLn $ "sync " ++ (show . fst $ r1)
  r2 <- getURL url2
  putStrLn $ "sync " ++ (show . fst $ r2)
  
  putStrLn "test async"
  withAsync (getURL url1) $ \a1 -> do
    withAsync (getURL url2) $ \a2 -> do
      res1 <- wait a1
      res2 <- wait a2
      putStrLn $ show . fst $ res1
      putStrLn $ show . fst $ res2 


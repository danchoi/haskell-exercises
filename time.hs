module Main where
import Data.Time
import Data.Time.Clock.POSIX

main = do

  -- Data.Time.Clock.POSIX utcTimeToPOSIXSeconds :: UTCTime -> POSIXTime
  -- getCurrentTime   -- IO UTCTime
  r <- utcTimeToPOSIXSeconds `fmap` getCurrentTime 
  print r 
  let r' = posixSecondsToUTCTime r
  print r'
  let x = 1364799600
  print $ posixSecondsToUTCTime x
  let y = 853056000
  print $ posixSecondsToUTCTime y

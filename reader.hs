module Main where
import Control.Monad.Reader

reader1 :: Reader String Int
reader1 = do
    e <- ask
    return $ length e

main = do 
    putStrLn "Enter a string, I'll return the length: "
    s <- getLine 
    print $ runReader reader1 s


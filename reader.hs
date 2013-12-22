module Main where
import Control.Monad.Reader

reader1 :: Reader String Int
reader1 = do
    e <- ask
    return $ length e

readerT :: ReaderT Int IO Int
readerT = do
    e <- ask
    liftIO $ putStrLn $ "Enter a string, Will return the length + " ++ show e ++ " (in ReaderT): "
    s <- liftIO $ getLine
    return $ e + (length s)

main = do 
    putStrLn "Enter a string, I'll return the length: "
    s <- getLine 
    print $ runReader reader1 s
    putStrLn "Enter a number"
    x <- fmap read getLine 
    r <- runReaderT readerT x
    print r



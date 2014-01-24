{-# LANGUAGE PackageImports, GeneralizedNewtypeDeriving #-}
module Main where
import "mtl" Control.Monad.Error
import "mtl" Control.Monad.State
import qualified Data.ByteString.Char8 as B
import Data.Char (isDigit)

data ParseError = NumericOverflow | EndOfInput | Chatty String deriving (Eq, Ord, Show)

instance Error ParseError where
  noMsg = Chatty "failed: "
  strMsg = Chatty

-- class (Monad m) => MonadError e m | m -> e where

newtype Parser a = P {
  runP :: ErrorT ParseError (State B.ByteString) a 
} deriving (Monad, MonadError ParseError)

liftP :: State B.ByteString a -> Parser a
liftP m = P (lift m)

satisfy :: (Char -> Bool) -> Parser Char
satisfy p = do
    s <- liftP get
    case B.uncons s of 
      Nothing -> throwError EndOfInput
      Just (c, s') 
        | p c -> liftP (put s') >> return c
        | otherwise -> throwError (Chatty "satisfy failed")
        
-- Control.Monad.Error runErrorT :: ErrorT e a -> m (Either e a)
-- Control.Monad.State.Strict runState :: State s a -> s -> (a, s)

runParser :: Parser a -> B.ByteString -> Either ParseError (a, B.ByteString)
runParser p bs = 
    case runState (runErrorT (runP p)) bs of
      (Left err, _) -> Left err
      (Right r, bs) -> Right (r, bs)
  

-- INCOMPLETE
main = do
  let p = satisfy isDigit
  print $ runParser p (B.pack "x") 
  print $ runParser p (B.pack "23") 


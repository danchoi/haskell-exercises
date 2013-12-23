{-# LANGUAGE OverloadedStrings #-}
module Main where
import qualified Text.Blaze.Html5 as H
import Text.Blaze.Html5
import qualified Text.Blaze.Html.Renderer.Utf8 as TB (renderHtml)
import Control.Monad.Reader
import Data.Text (Text)
import qualified Data.Text.IO as T
import qualified Data.ByteString.Lazy.Char8 as B

data User = User {
    username :: Text
  , userId :: Int
  } deriving (Show)

page :: Reader User Html
page = do
  user <- ask
  return $ H.docTypeHtml $ do
    H.head $ title "Reader Monad Blaze Example"
    H.body $ do
      h1 $ "Hello world"
      dl $ do
        dt $ "Username" 
        dd $ H.toHtml $ username user
        dt $ "UserId" 
        dd $ H.toHtml $ userId user

main = do
  let res = runReader page (User "dan" 1)
  B.putStrLn $ TB.renderHtml res 


{-# LANGUAGE OverloadedStrings #-}
module Main where
import qualified Text.Blaze.Html5 as H
import Text.Blaze (ToMarkup(..))
import Text.Blaze.Html5
import qualified Text.Blaze.Html.Renderer.Utf8 as TB (renderHtml)
import Data.Text (Text)
import qualified Data.Text.IO as T
import qualified Data.ByteString.Lazy.Char8 as B

data User = User {
    username :: Text
  , userId :: Int
  } deriving (Show)


userBox :: User -> Html
userBox user = do
      dl $ do
        dt $ "Username" 
        dd $ H.toHtml $ username user
        dt $ "UserId" 
        dd $ H.toHtml $ userId user

page :: User -> Html
page user = do
  H.docTypeHtml $ do
    H.head $ title "Reader Monad Blaze Example"
    H.body $ do
      h1 $ "Hello world"
      userBox user

main = do
  let res = page (User "dan" 1)
  B.putStrLn $ TB.renderHtml res 


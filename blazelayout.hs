{-# LANGUAGE OverloadedStrings #-}
module Main where
import qualified Text.Blaze.Html5 as H
import Text.Blaze (ToMarkup(..))
import Text.Blaze.Html5
import qualified Text.Blaze.Html.Renderer.Utf8 as TB (renderHtml)
import Data.Text (Text)
import qualified Data.Text.IO as T
import qualified Data.ByteString.Lazy.Char8 as B

-- This command line app just inserts STDIN into the layout

page :: String -> Html
page c  = do
  H.docTypeHtml $ do
    H.head $ title "Reader Monad Blaze Example"
    H.body $ do
      h1 $ "Hello world"
      H.preEscapedToHtml c

main = do
  c <- getContents
  B.putStrLn $ TB.renderHtml (page c)


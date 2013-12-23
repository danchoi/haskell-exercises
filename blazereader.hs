{-# LANGUAGE OverloadedStrings #-}
module Main where
import qualified Text.Blaze.Html5 as H
import Text.Blaze (ToMarkup(..))
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


-- http://www.stephendiehl.com/posts/haskell_web.html

instance ToMarkup User where
  toMarkup = toHtml . show


userBox :: Reader User Html
userBox = do
  user <- ask
  return $ do
      dl $ do
        dt $ "Username" 
        dd $ H.toHtml $ username user
        dt $ "UserId" 
        dd $ H.toHtml $ userId user
      H.p $ toMarkup user
  

page :: Reader User Html
page = do
  user <- ask
  return $ H.docTypeHtml $ do
    H.head $ title "Reader Monad Blaze Example"
    H.body $ do
      h1 $ "Hello world"
      runReader userBox user

{-

Nesting runReader is a bit awkward; see commentary at
http://ocharles.org.uk/blog/posts/2012-12-22-24-days-of-hackage-blaze.html:

There are sadly a few drawbacks to blaze-html - notably it is not a “true”
monad (it violates the monad laws), nor is it a monad transformer. It would be
fantastic if it was a transformer, as we’d then be free to use a Reader monad
as our base monad, which might provide a nice abstraction to passing around
common variables in templates (e.g., the currently logged in user). That’s not
to say these things are impossible - you can always layer Reader on top of
Html, but it just becomes a tad harder to work with.

-}


main = do
  let res = runReader page (User "dan" 1)
  B.putStrLn $ TB.renderHtml res 


{-# LANGUAGE RecursiveDo, OverloadedStrings #-}
module Lib where

import Reflex.Dom
import qualified Data.Text as T
import Data.Text.Encoding
import Data.Monoid

main :: IO ()
main = mainWidget $ do
  header
  rec t <- textInput $ def & setValue .~ fmap (const "") newMessage
      b <- button "Send"
      let newMessage = fmap ((:[]) . encodeUtf8) $ tag (current $ value t) $ leftmost [b, keypress Enter t]
  ws <- webSocket "ws://localhost:3000/" $ def & webSocketConfig_send .~ newMessage
  receivedMessages <- foldDyn (\m ms -> ms ++ [m]) [] $ _webSocket_recv ws
  el "p" $ text "Responses from the yesod server:"
  _ <- el "ul" $ simpleList receivedMessages $ \m -> el "li" $ dynText $ fmap decodeUtf8 m
  footer

linkNewTab :: MonadWidget t m => T.Text -> T.Text -> m ()
linkNewTab href s = elAttr "a" ("href" =: href <> "target" =: "_blank") $ text s

header :: MonadWidget t m => m ()
header = do
  el "p" $ do
    text "Start the yesod webserver and use this page to"
    text " send a message to the yesod server hosted on localhost:3000"

footer :: MonadWidget t m => m ()
footer = do
  el "hr" $ return ()
  el "p" $ do
    text "The code for this example can be found in the "
    linkNewTab "https://github.com/dfordivam/reflex-yesod-websockets" "reflex-yesod-websockets"
    text " repo."


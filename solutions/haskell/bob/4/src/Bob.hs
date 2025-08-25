{-# LANGUAGE OverloadedStrings #-}

module Bob (responseFor) where

import qualified Data.Char as T
import Data.Text (Text)
import qualified Data.Text as T

isYelling :: Text -> Bool
isYelling xs =
  let letters = T.filter T.isAlpha xs
   in not (T.null letters) && T.all T.isUpper letters

isQuestion :: Text -> Bool
isQuestion xs = T.last (T.strip xs) == '?'

isSilence :: Text -> Bool
isSilence xs = T.null xs || T.all T.isSpace xs

responseFor :: Text -> Text
responseFor xs
  | isSilence xs = "Fine. Be that way!"
  | isQuestion xs && isYelling xs = "Calm down, I know what I'm doing!"
  | isQuestion xs = "Sure."
  | isYelling xs = "Whoa, chill out!"
  | otherwise = "Whatever."

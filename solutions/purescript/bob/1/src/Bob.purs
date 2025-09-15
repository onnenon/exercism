module Bob
  ( hey
  ) where

import Prelude
import Data.Maybe (fromJust)
import Data.String as T
import Data.String.CodeUnits (charAt, length, toCharArray)
import Data.Array (any)
import Data.Char (toCharCode)
import Partial.Unsafe (unsafePartial)

isLetter :: Char -> Boolean
isLetter c =
  let
    code = toCharCode c
  in
    (code >= 65 && code <= 90) || (code >= 97 && code <= 122)

isSilence :: String -> Boolean
isSilence s = T.null $ T.trim s

lastChar :: String -> Char
lastChar s = unsafePartial $ fromJust $ charAt (length s - 1) s

hasLetter :: String -> Boolean
hasLetter s = any isLetter (toCharArray s)

isYelling :: String -> Boolean
isYelling s = hasLetter s && s == T.toUpper s

isQuestion :: String -> Boolean
isQuestion s = (lastChar $ T.trim s) == '?'

hey :: String -> String
hey p
  | isSilence p = "Fine. Be that way!"
  | isYelling p && isQuestion p = "Calm down, I know what I'm doing!"
  | isYelling p = "Whoa, chill out!"
  | isQuestion p = "Sure."
  | otherwise = "Whatever."

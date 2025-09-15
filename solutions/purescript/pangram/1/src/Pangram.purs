module Pangram
  ( isPangram
  ) where

import Prelude
import Data.Array (filter, nub)
import Data.Foldable (all, elem)
import Data.String.CodeUnits (toCharArray)
import Data.String.Common (toLower)

isPangram :: String -> Boolean
isPangram str =
  let
    alphabet = toCharArray "abcdefghijklmnopqrstuvwxyz"

    lowercaseStr = toLower str

    letters = nub $ filter (\c -> c >= 'a' && c <= 'z') $ toCharArray lowercaseStr
  in
    all (\c -> c `elem` letters) alphabet

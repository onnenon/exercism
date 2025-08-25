module Pangram (isPangram) where

import Data.Char (isAsciiLower, toLower)
import Data.List (nub)

isPangram :: String -> Bool
isPangram text = length uniqueAsciiLetters == 26
  where
    uniqueAsciiLetters = nub $ filter isAsciiLower $ toLower <$> text

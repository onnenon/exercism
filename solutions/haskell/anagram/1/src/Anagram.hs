module Anagram (anagramsFor) where

import Data.Char (toLower)
import Data.List (sort)

anagramsFor :: String -> [String] -> [String]
anagramsFor word = filter isAnagram
  where
    norm = sort . map toLower
    wNorm = norm word
    notSameWord c = map toLower word /= map toLower c
    isAnagram c = wNorm == norm c && notSameWord c

module Anagram (anagramsFor) where

import Data.Char (toLower)
import Data.List (sort)

anagramsFor :: String -> [String] -> [String]
anagramsFor word = filter isAnagram
  where
    lowercase = map toLower
    normalized = sort . lowercase
    notSameWord candidate = lowercase word /= lowercase candidate
    isAnagram candidate = normalized word == normalized candidate && notSameWord candidate

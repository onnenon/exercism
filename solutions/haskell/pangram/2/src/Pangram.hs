module Pangram (isPangram) where

import Data.Char (toLower)

isPangram :: String -> Bool
isPangram text = all (`elem` map toLower text) ['a' .. 'z']

-- isPangram text = length uniqueAsciiLetters == 26
--   where
--     uniqueAsciiLetters = nub $ filter isAsciiLower $ toLower <$> text

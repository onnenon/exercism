module Acronym (abbreviate) where

import qualified Data.Char as C

abbreviate :: String -> String
abbreviate =
  map (C.toUpper . headAlpha)
    . words
    . map dashToSpace
    . fixCamels
  where
    dashToSpace '-' = ' '
    dashToSpace c = c
    headAlpha = head . filter C.isAlpha

fixCamels :: String -> String
fixCamels [] = []
fixCamels (x : xs) = x : go x xs
  where
    go _ [] = []
    go prev (y : ys)
      | C.isLower prev && C.isUpper y = ' ' : y : go y ys
      | otherwise = y : go y ys
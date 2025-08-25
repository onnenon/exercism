module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance (x : xs) (y : ys) = f <$> distance xs ys
  where
    f = if x == y then (+ 0) else (+ 1)
distance [] [] = Just 0
distance _ [] = Nothing
distance [] _ = Nothing

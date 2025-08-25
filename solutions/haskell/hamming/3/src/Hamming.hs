module Hamming (distance) where

distance :: String -> String -> Maybe Int
distance xs yz
  | length xs /= length yz = Nothing
  | otherwise = Just $ length $ filter id $ zipWith (/=) xs yz

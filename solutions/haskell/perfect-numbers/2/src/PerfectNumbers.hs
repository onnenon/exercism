module PerfectNumbers (classify, Classification (..)) where

data Classification = Deficient | Perfect | Abundant deriving (Eq, Show)

classify :: Int -> Maybe Classification
classify n
  | n <= 0 = Nothing
  | s < n = Just Deficient
  | s == n = Just Perfect
  | s > n = Just Abundant
  | otherwise = Nothing
  where
    s = aliquotSum n

aliquotSum :: Int -> Int
aliquotSum n = sum divisors
  where
    divisors = [d | d <- [1 .. n - 1], n `mod` d == 0]

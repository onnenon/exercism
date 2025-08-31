module SumOfMultiples (sumOfMultiples) where

sumOfMultiples :: [Integer] -> Integer -> Integer
sumOfMultiples factors limit =
  sum [n | n <- [1 .. limit - 1], any (isFactor n) factors]
  where
    isFactor n f = f /= 0 && n `mod` f == 0
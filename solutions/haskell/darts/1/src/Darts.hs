module Darts (score) where

score :: Float -> Float -> Int
score x y
  | distanceFromOrigin > 10 = 0
  | distanceFromOrigin > 5 = 1
  | distanceFromOrigin > 1 = 5
  | otherwise = 10
  where
    distanceFromOrigin = sqrt (x * x + y * y)
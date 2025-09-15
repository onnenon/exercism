module CollatzConjecture
  ( collatz
  ) where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Int (even)

collatz :: Int -> Maybe Int
collatz x = case x of
  _
    | x <= 0 -> Nothing
  _
    | otherwise -> Just (countSteps x 0)
  where
  countSteps :: Int -> Int -> Int
  countSteps 1 steps = steps

  countSteps n steps
    | even n = countSteps (n / 2) (steps + 1)
    | otherwise = countSteps (3 * n + 1) (steps + 1)

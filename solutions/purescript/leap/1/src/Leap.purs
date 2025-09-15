module Leap
  ( isLeapYear
  ) where

import Prelude (mod, (==), otherwise)

isLeapYear :: Int -> Boolean
isLeapYear year
  | mod year 400 == 0 = true
  | mod year 100 == 0 = false
  | mod year 4 == 0 = true
  | otherwise = false

module CollatzConjecture (collatz) where

collatz :: Integer -> Maybe Integer
-- = error "You need to implement this function."collatz n = error "You need to implement this function."

collatz 1 = Just 0
collatz 0 = Nothing
collatz n
  | n < 0 = Nothing
  | even n = (+ 1) <$> (collatz (div n 2))
  | otherwise = (+ 1) <$> (collatz (3 * n + 1))

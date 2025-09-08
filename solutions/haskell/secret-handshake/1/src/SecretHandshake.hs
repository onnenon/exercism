module SecretHandshake (handshake) where

import Data.Bits (testBit)

handshake :: Int -> [String]
handshake n = if shouldReverse then reverse actions else actions
 where
  shouldReverse = testBit n 4
  actions = filter (not . null) [action1, action2, action3, action4]
  action1 = if testBit n 0 then "wink" else ""
  action2 = if testBit n 1 then "double blink" else ""
  action3 = if testBit n 2 then "close your eyes" else ""
  action4 = if testBit n 3 then "jump" else ""

-- >>> handshake 26
-- ["wink","jump"]

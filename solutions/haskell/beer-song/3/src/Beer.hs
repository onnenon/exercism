module Beer (song) where

import Data.List (intercalate)
import Text.Printf (printf)

reciteVerse :: Int -> String
reciteVerse n = case n of
  0 ->
    "No more bottles of beer on the wall, no more bottles of beer.\n\
    \Go to the store and buy some more, 99 bottles of beer on the wall.\n"
  1 ->
    "1 bottle of beer on the wall, 1 bottle of beer.\n\
    \Take it down and pass it around, no more bottles of beer on the wall."
  2 ->
    "2 bottles of beer on the wall, 2 bottles of beer.\n\
    \Take one down and pass it around, 1 bottle of beer on the wall."
  _ ->
    printf
      "%d bottles of beer on the wall, %d bottles of beer.\n\
      \Take one down and pass it around, %d bottles of beer on the wall."
      n
      n
      (n - 1)

song :: String
song = intercalate "\n\n" $ map reciteVerse [99, 98 .. 0]

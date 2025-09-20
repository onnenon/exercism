module TwelveDays (recite) where

import Data.List (intercalate)

ordinals :: [String]
ordinals =
  [ "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth"
  ]

gifts :: [String]
gifts =
  [ "a Partridge in a Pear Tree.",
    "two Turtle Doves",
    "three French Hens",
    "four Calling Birds",
    "five Gold Rings",
    "six Geese-a-Laying",
    "seven Swans-a-Swimming",
    "eight Maids-a-Milking",
    "nine Ladies Dancing",
    "ten Lords-a-Leaping",
    "eleven Pipers Piping",
    "twelve Drummers Drumming"
  ]

recite :: Int -> Int -> [String]
recite start stop = map reciteDay [start .. stop]

reciteDay :: Int -> String
reciteDay day = prefix ++ giftList
  where
    prefix = "On the " ++ (ordinals !! (day - 1)) ++ " day of Christmas my true love gave to me: "
    dayGifts = take day gifts
    giftList = case dayGifts of
      [] -> ""
      [gift] -> gift
      (firstGift : otherGifts) -> intercalate ", " (reverse otherGifts) ++ ", and " ++ firstGift

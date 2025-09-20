module TwelveDays (recite) where

dayGifts :: [(String, String)]
dayGifts =
  [ ("", ""),
    ("first", "a Partridge in a Pear Tree."),
    ("second", "two Turtle Doves"),
    ("third", "three French Hens"),
    ("fourth", "four Calling Birds"),
    ("fifth", "five Gold Rings"),
    ("sixth", "six Geese-a-Laying"),
    ("seventh", "seven Swans-a-Swimming"),
    ("eighth", "eight Maids-a-Milking"),
    ("ninth", "nine Ladies Dancing"),
    ("tenth", "ten Lords-a-Leaping"),
    ("eleventh", "eleven Pipers Piping"),
    ("twelfth", "twelve Drummers Drumming")
  ]

startPhrase :: Int -> String
startPhrase day = "On the " <> d <> " day of Christmas my true love gave to me: " <> g
  where
    (d, g) = dayGifts !! day

dayPhrase :: Int -> String
dayPhrase day
  | day == 1 = "and " <> (getPhrase day)
  | otherwise = getPhrase day
  where
    getPhrase d = snd $ dayGifts !! d

recite :: Int -> Int -> [String]
recite start stop = [reciteDay d | d <- [start .. stop]]

reciteDay :: Int -> String
reciteDay day = reciteDay' (day - 1) (startPhrase day)
  where
    reciteDay' 0 acc = acc
    reciteDay' d acc = reciteDay' (d - 1) (acc <> ", " <> dayPhrase d)

module BettysBikeShop exposing (penceToPounds, poundsToString)

import String


penceToPounds : Int -> Float
penceToPounds p =
    toFloat p / 100


poundsToString : Float -> String
poundsToString pounds =
    "£" ++ String.fromFloat pounds

open Base

type planet =
  | Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Neptune
  | Uranus

let conversion_rate = function
  | Mercury -> 0.2408467
  | Venus -> 0.61519726
  | Earth -> 1.0
  | Mars -> 1.8808158
  | Jupiter -> 11.862615
  | Saturn -> 29.447498
  | Uranus -> 84.016846
  | Neptune -> 164.79132

let age_on planet age_seconds =
  let earth_years age = Float.of_int age /. 31_557_600.0 in
  earth_years age_seconds /. conversion_rate planet

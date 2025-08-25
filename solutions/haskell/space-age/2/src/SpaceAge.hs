module SpaceAge (Planet (..), ageOn) where

earthYearSeconds :: Float
earthYearSeconds = 31557600

planetOrbitalPeriod :: Planet -> Float
planetOrbitalPeriod Mercury = 0.2408467
planetOrbitalPeriod Venus = 0.61519726
planetOrbitalPeriod Earth = 1.0
planetOrbitalPeriod Mars = 1.8808158
planetOrbitalPeriod Jupiter = 11.862615
planetOrbitalPeriod Saturn = 29.447498
planetOrbitalPeriod Uranus = 84.016846
planetOrbitalPeriod Neptune = 164.79132

secondsToYears :: Float -> Float
secondsToYears seconds = seconds / earthYearSeconds

data Planet
  = Mercury
  | Venus
  | Earth
  | Mars
  | Jupiter
  | Saturn
  | Uranus
  | Neptune

ageOn :: Planet -> Float -> Float
ageOn planet seconds = earthYears / planetOrbitalPeriod planet
  where
    earthYears = secondsToYears seconds

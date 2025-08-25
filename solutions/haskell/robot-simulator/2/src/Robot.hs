{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

module Robot
  ( Bearing (East, North, South, West),
    bearing,
    coordinates,
    mkRobot,
    move,
  )
where

data Bearing
  = North
  | East
  | South
  | West
  deriving (Eq, Show)

data Robot = Robot
  { bearing :: Bearing,
    coordinates :: (Integer, Integer)
  }
  deriving (Show)

mkRobot :: Bearing -> (Integer, Integer) -> Robot
mkRobot = Robot

move :: Robot -> String -> Robot
move robot [] = robot
move robot (x : xs) = case x of
  'L' -> move (turnLeft robot) xs
  'R' -> move (turnRight robot) xs
  'A' -> move (advance robot) xs
  _ -> robot

turnLeft :: Robot -> Robot
turnLeft robot@(Robot b _) = case b of
  North -> robot {bearing = West}
  East -> robot {bearing = North}
  South -> robot {bearing = East}
  West -> robot {bearing = South}

turnRight :: Robot -> Robot
turnRight robot@(Robot b _) = case b of
  North -> robot {bearing = East}
  East -> robot {bearing = South}
  South -> robot {bearing = West}
  West -> robot {bearing = North}

advance :: Robot -> Robot
advance robot@(Robot b (x, y)) = case b of
  North -> robot {coordinates = (x, y + 1)}
  East -> robot {coordinates = (x + 1, y)}
  South -> robot {coordinates = (x, y - 1)}
  West -> robot {coordinates = (x - 1, y)}

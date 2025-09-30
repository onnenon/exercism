module DND
  ( Character (..),
    ability,
    modifier,
    character,
  )
where

import Data.List (sort)
import Test.QuickCheck (Gen, choose, vectorOf)

data Character = Character
  { strength :: Int,
    dexterity :: Int,
    constitution :: Int,
    intelligence :: Int,
    wisdom :: Int,
    charisma :: Int,
    hitpoints :: Int
  }
  deriving (Show, Eq)

modifier :: Int -> Int
modifier = flip div 2 . subtract 10

ability :: Gen Int
ability = sum . drop 1 . sort <$> vectorOf 4 (choose (1, 6))

character :: Gen Character
character = do
  str <- ability
  dex <- ability
  con <- ability
  int <- ability
  wis <- ability
  cha <- ability
  let hp = 10 + modifier con
  return
    Character
      { strength = str,
        dexterity = dex,
        intelligence = int,
        wisdom = wis,
        charisma = cha,
        constitution = con,
        hitpoints = hp
      }
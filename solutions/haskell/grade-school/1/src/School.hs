module School (School, add, empty, grade, sorted) where

import Data.List (sort, sortBy)
import Data.Maybe (fromMaybe)
import Data.Ord (comparing)

data School = School [(Int, [String])]

add :: Int -> String -> School -> School
add gradeNum student (School roster) = School (sortGrade $ insertStudent gradeNum student roster)
  where
    insertStudent g s [] = [(g, [s])]
    insertStudent g s ((gradeVal, students) : rest)
      | g == gradeVal = (gradeVal, s : students) : rest
      | otherwise = (gradeVal, students) : insertStudent g s rest

empty :: School
empty = School []

grade :: Int -> School -> [String]
grade gradeNum (School roster) = fromMaybe [] (lookup gradeNum roster)

sorted :: School -> [(Int, [String])]
sorted (School roster) = sortGrade roster

sortGrade :: [(Int, [String])] -> [(Int, [String])]
sortGrade g = sortBy (comparing fst) $ map (\(k, v) -> (k, sort v)) g
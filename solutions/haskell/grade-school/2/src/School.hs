module School (School, add, empty, grade, sorted) where

import qualified Data.IntMap as M
import qualified Data.List as L

data School = School (M.IntMap [String])

add :: Int -> String -> School -> School
add gradeNum student (School roster) = School $ M.insertWith insertStudent gradeNum [student] roster
  where
    insertStudent [newStudent] existingStudents = L.insert newStudent existingStudents
    insertStudent _ existingStudents = existingStudents

empty :: School
empty = School M.empty

grade :: Int -> School -> [String]
grade gradeNum (School roster) = M.findWithDefault [] gradeNum roster

sorted :: School -> [(Int, [String])]
sorted (School roster) = M.toAscList roster

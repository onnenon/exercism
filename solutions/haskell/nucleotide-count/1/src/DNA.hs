module DNA (nucleotideCounts, Nucleotide (..)) where

import Data.Map (Map)
import qualified Data.Map as M

data Nucleotide = A | C | G | T deriving (Eq, Ord, Show)

charToNucleotide :: Char -> Either String Nucleotide
charToNucleotide 'A' = Right A
charToNucleotide 'C' = Right C
charToNucleotide 'G' = Right G
charToNucleotide 'T' = Right T
charToNucleotide c = Left $ "Invalid nucleotide: " ++ [c]

nucleotideCounts :: String -> Either String (Map Nucleotide Int)
nucleotideCounts xs = do
  ns <- traverse charToNucleotide xs
  return $ foldl update nucleotideMap ns
  where
    nucleotideMap = M.fromList [(A, 0), (C, 0), (G, 0), (T, 0)]
    update m n = M.adjust (+ 1) n m
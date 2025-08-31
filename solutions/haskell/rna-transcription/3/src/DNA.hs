module DNA (toRNA) where

toRNA :: String -> Either Char String
toRNA = traverse toComplement
  where
    toComplement c = maybe (Left c) Right (lookup c nucleotideMap)
    nucleotideMap = [('G', 'C'), ('C', 'G'), ('T', 'A'), ('A', 'U')]
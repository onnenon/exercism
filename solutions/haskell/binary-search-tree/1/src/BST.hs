module BST
  ( BST,
    bstLeft,
    bstRight,
    bstValue,
    empty,
    fromList,
    insert,
    singleton,
    toList,
  )
where

data BST a = Empty | Node a (BST a) (BST a) deriving (Eq, Show)

bstLeft :: BST a -> Maybe (BST a)
bstLeft Empty = Nothing
bstLeft (Node _ left _) = Just left

bstRight :: BST a -> Maybe (BST a)
bstRight Empty = Nothing
bstRight (Node _ _ right) = Just right

bstValue :: BST a -> Maybe a
bstValue Empty = Nothing
bstValue (Node v _ _) = Just v

empty :: BST a
empty = Empty

fromList :: (Ord a) => [a] -> BST a
fromList [] = Empty
fromList xs = foldl (flip insert) Empty xs

insert :: (Ord a) => a -> BST a -> BST a
insert v Empty = Node v Empty Empty
insert v (Node nodeV l r)
  | v <= nodeV = (Node nodeV (insert v l) r)
  | otherwise = (Node nodeV l (insert v r))

singleton :: a -> BST a
singleton x = Node x Empty Empty

toList :: BST a -> [a]
toList Empty = []
toList (Node v l r) = toList l ++ [v] ++ toList r

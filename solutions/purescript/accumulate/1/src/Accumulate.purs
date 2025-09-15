module Accumulate
  ( accumulate
  ) where

import Data.List (List(..), reverse)

doAccumulate :: forall a b. (a -> b) -> List b -> List a -> List b
doAccumulate _ acc Nil = acc

doAccumulate f acc (Cons x xs) = doAccumulate f (Cons (f x) acc) xs

accumulate :: forall a b. (a -> b) -> List a -> List b
accumulate f l = reverse (doAccumulate f Nil l)

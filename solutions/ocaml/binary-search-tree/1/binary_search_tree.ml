open Base

type bst = Empty | Node of int * bst * bst

let empty = Empty

let value = function
  | Empty -> Error "Empty tree has no value"
  | Node (v, _, _) -> Ok v

let left = function
  | Empty -> Error "Empty tree has no left child"
  | Node (_, l, _) -> Ok l

let right = function
  | Empty -> Error "Empty tree has no right child"
  | Node (_, _, r) -> Ok r

let insert v t =
  let rec inserter = function
    | Empty -> Node (v, Empty, Empty)
    | Node (node_val, left_tree, right_tree) ->
        if v <= node_val then Node (node_val, inserter left_tree, right_tree)
        else Node (node_val, left_tree, inserter right_tree)
  in
  inserter t

let to_list t =
  let rec traverse = function
    | Empty -> []
    | Node (v, l, r) -> traverse l @ [ v ] @ traverse r
  in
  traverse t

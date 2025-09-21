import gleam/list

pub type Tree {
  Nil
  Node(data: Int, left: Tree, right: Tree)
}

fn traverse(tree: Tree) -> List(Int) {
  case tree {
    Nil -> []
    Node(data, left, right) -> {
      list.flatten([traverse(left), [data], traverse(right)])
    }
  }
}

fn insert(v: Int, tree: Tree) -> Tree {
  case tree {
    Nil -> Node(v, Nil, Nil)
    Node(data, left, right) if v <= data -> Node(data, insert(v, left), right)
    Node(data, left, right) -> Node(data, left, insert(v, right))
  }
}

pub fn to_tree(data: List(Int)) -> Tree {
  list.fold(data, Nil, fn(t, v) { insert(v, t) })
}

pub fn sorted_data(data: List(Int)) -> List(Int) {
  data
  |> to_tree
  |> traverse
}

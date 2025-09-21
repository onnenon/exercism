defmodule BinarySearchTree do
  @type bst_node :: %{data: any, left: bst_node | nil, right: bst_node | nil}

  @doc """
  Create a new Binary Search Tree with root's value as the given 'data'
  """
  @spec new(any) :: bst_node
  def new(data) do
    %{data: data, left: nil, right: nil}
  end

  @doc """
  Creates and inserts a node with its value as 'data' into the tree.
  """
  @spec insert(bst_node, any) :: bst_node
  def insert(nil, data), do: new(data)

  def insert(%{data: node_data, left: left_tree, right: right_tree}, data) do
    cond do
      data <= node_data -> %{data: node_data, left: insert(left_tree, data), right: right_tree}
      true -> %{data: node_data, left: left_tree, right: insert(right_tree, data)}
    end
  end

  @doc """
  Traverses the Binary Search Tree in order and returns a list of each node's data.
  """
  @spec in_order(bst_node) :: [any]
  def in_order(nil), do: []

  def in_order(%{data: d, left: l, right: r}) do
    in_order(l) ++ [d] ++ in_order(r)
  end
end

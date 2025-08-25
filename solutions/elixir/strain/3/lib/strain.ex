defmodule Strain do
  @doc """
  Given a `list` of items and a function `fun`, return the list of items where
  `fun` returns true.
  """
  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep([], _), do: []
  def keep([h | t], fun), do: if(fun.(h), do: [h | keep(t, fun)], else: keep(t, fun))

  @doc """
    Given a `list` of items and a function `fun`, return the list of items where
    `fun` returns false.
  """
  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard([], _), do: []
  def discard([h | t], fun), do: if(fun.(h), do: discard(t, fun), else: [h | discard(t, fun)])
end

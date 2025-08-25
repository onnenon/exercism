defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      a === b -> :equal
      sublist?(a, b) -> :sublist
      sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  defp sublist?([], _), do: true
  defp sublist?(_, []), do: false

  defp sublist?(sub, list = [_ | t]) do
    if Enum.take(list, length(sub)) === sub do
      true
    else
      sublist?(sub, t)
    end
  end
end

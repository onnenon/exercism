defmodule Series do
  defp series_product(series) do
    series
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&*/2)
  end

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product("", x) when x > 0, do: raise(ArgumentError, "Invalid arguments")

  def largest_product(number_string, size) when size > 0 do
    if String.length(number_string) < size, do: raise(ArgumentError, "Invalid arguments")

    number_string
    |> String.graphemes()
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&series_product/1)
    |> Enum.max()
  end

  def largest_product(_, _), do: raise(ArgumentError, "Invalid arguments")
end

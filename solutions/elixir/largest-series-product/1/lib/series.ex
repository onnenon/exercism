defmodule Series do
  def series_product(series) do
    series
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&*/2)
  end

  @doc """
  Finds the largest product of a given number of consecutive numbers in a given string of numbers.
  """
  @spec largest_product(String.t(), non_neg_integer) :: non_neg_integer
  def largest_product(number_string, size) do
    number_string
    |> String.graphemes()
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.map(&series_product/1)
    |> Enum.max()
  end
end

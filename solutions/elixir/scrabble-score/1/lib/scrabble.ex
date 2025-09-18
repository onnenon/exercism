defmodule Scrabble do
  @one_point ["A", "E", "I", "O", "U", "L", "N", "R", "S", "T"]
  @two_points ["D", "G"]
  @three_points ["B", "C", "M", "P"]
  @four_points ["F", "H", "V", "W", "Y"]
  @five_points ["K"]
  @eight_points ["J", "X"]
  @ten_points ["Q", "Z"]

  defp letter_points(letter) when letter in @one_point, do: 1
  defp letter_points(letter) when letter in @two_points, do: 2
  defp letter_points(letter) when letter in @three_points, do: 3
  defp letter_points(letter) when letter in @four_points, do: 4
  defp letter_points(letter) when letter in @five_points, do: 5
  defp letter_points(letter) when letter in @eight_points, do: 8
  defp letter_points(letter) when letter in @ten_points, do: 10
  defp letter_points(_), do: 0

  @doc """
  Calculate the scrabble score for the word.
  """
  @spec score(String.t()) :: non_neg_integer
  def score(word) do
    word
    |> String.upcase()
    |> String.graphemes()
    |> Enum.map(&letter_points/1)
    |> Enum.sum()
  end
end

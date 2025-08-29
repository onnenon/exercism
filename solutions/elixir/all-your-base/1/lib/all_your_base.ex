defmodule AllYourBase do
  @doc """
  Given a number in input base, represented as a sequence of digits, converts it to output base,
  or returns an error tuple if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: {:ok, list} | {:error, String.t()}
  def convert(digits, input_base, output_base) do
    cond do
      input_base < 2 ->
        {:error, "input base must be >= 2"}

      output_base < 2 ->
        {:error, "output base must be >= 2"}

      Enum.any?(digits, &(&1 < 0 or &1 >= input_base)) ->
        {:error, "all digits must be >= 0 and < input base"}

      digits == [] ->
        {:ok, [0]}

      true ->
        number = Enum.reduce(digits, 0, fn d, acc -> acc * input_base + d end)
        {:ok, to_base(number, output_base)}
    end
  end

  defp to_base(0, _base), do: [0]

  defp to_base(number, base) do
    to_base_(number, base, [])
  end

  defp to_base_(0, _base, acc), do: acc

  defp to_base_(number, base, acc) do
    to_base_(div(number, base), base, [rem(number, base) | acc])
  end
end

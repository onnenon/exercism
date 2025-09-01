defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    thousands = ["", "M", "MM", "MMM"]
    hundreds = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
    tens = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
    ones = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]

    [th, h, t, o] = number |> Integer.digits() |> pad_leading(4, 0)

    Enum.join([
      Enum.at(thousands, th),
      Enum.at(hundreds, h),
      Enum.at(tens, t),
      Enum.at(ones, o)
    ])
  end

  defp pad_leading(list, len, val) do
    List.duplicate(val, len - length(list)) ++ list
  end
end

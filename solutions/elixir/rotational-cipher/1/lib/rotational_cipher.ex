defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(String.t(), integer) :: String.t()
  def rotate(text, shift) do
    text
    |> String.to_charlist()
    |> Enum.map(&shift_(&1, shift))
    |> List.to_string()
  end

  defp shift_(c, shift) when c in ?a..?z, do: rem(c - ?a + shift, 26) + ?a
  defp shift_(c, shift) when c in ?A..?Z, do: rem(c - ?A + shift, 26) + ?A
  defp shift_(c, _shift), do: c
end

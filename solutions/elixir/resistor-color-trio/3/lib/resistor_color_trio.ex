defmodule ResistorColorTrio do
  @color_value %{
    black: 0,
    brown: 1,
    red: 2,
    orange: 3,
    yellow: 4,
    green: 5,
    blue: 6,
    violet: 7,
    grey: 8,
    white: 9
  }

  defp unit(value) when value >= 1_000_000_000, do: {div(value, 1_000_000_000), :gigaohms}
  defp unit(value) when value >= 1_000_000, do: {div(value, 1_000_000), :megaohms}
  defp unit(value) when value >= 1_000, do: {div(value, 1_000), :kiloohms}
  defp unit(value), do: {value, :ohms}

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {integer, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([ring1, ring2, ring3 | _]) do
    value =
      ((@color_value[ring1] * 10 + @color_value[ring2]) * 10 ** @color_value[ring3])
      |> round

    unit(value)
  end
end

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

  def get_unit(n) do
    cond do
      n == 1 -> :ohms
      n == 1_000 -> :kiloohms
      n == 1_000_000 -> :megaohms
      n == 1_000_000_000 -> :gigaohms
    end
  end

  @doc """
  Calculate the resistance value in ohms from resistor colors
  """
  @spec label(colors :: [atom]) :: {number, :ohms | :kiloohms | :megaohms | :gigaohms}
  def label([first, second, zeros | _]) do
    {@color_value[first] * 10 + @color_value[second],
     get_unit(:math.pow(10, @color_value[zeros]))}
  end
end

defmodule ResistorColorDuo do
  @doc """
  Calculate a resistance value from two colors
  """
  @spec value(colors :: [atom]) :: integer
  def value([first, second | _]) do
    (value_(first) <> value_(second)) |> String.to_integer()
  end

  defp value_(color) do
    case color do
      :black -> "0"
      :brown -> "1"
      :red -> "2"
      :orange -> "3"
      :yellow -> "4"
      :green -> "5"
      :blue -> "6"
      :violet -> "7"
      :grey -> "8"
      :white -> "9"
    end
  end
end

defmodule Bob do
  defp yelling?(input) do
    letters =
      input
      |> String.graphemes()
      |> Enum.filter(&String.match?(&1, ~r/^\p{L}$/u))

    letters != [] and Enum.all?(letters, &(&1 == String.upcase(&1)))
  end

  defp question?(input) do
    input |> String.trim() |> String.ends_with?("?")
  end

  defp silence?(input) do
    String.trim(input) == ""
  end

  @spec hey(String.t()) :: String.t()
  def hey(input) do
    cond do
      silence?(input) -> "Fine. Be that way!"
      question?(input) and yelling?(input) -> "Calm down, I know what I'm doing!"
      question?(input) -> "Sure."
      yelling?(input) -> "Whoa, chill out!"
      true -> "Whatever."
    end
  end
end

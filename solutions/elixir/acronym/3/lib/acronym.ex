defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
    |> String.split(~r/[ _-]/, trim: true)
    |> Enum.map(&String.first/1)
    |> to_string
    |> String.upcase()
  end
end

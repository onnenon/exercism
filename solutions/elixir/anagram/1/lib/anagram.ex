defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
    |> Enum.filter(&is_anagram?(String.downcase(base), String.downcase(&1)))
  end

  defp is_anagram?(base, candidate) when base == candidate, do: false

  defp is_anagram?(base, candidate) do
    normalized_base = normalize(base)
    normalized_candidate = normalize(candidate)
    normalized_base == normalized_candidate
  end

  defp normalize(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
end

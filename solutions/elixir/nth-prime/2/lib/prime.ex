defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.iterate(2, &(&1 + 1))
    |> Stream.filter(&is_prime/1)
    |> Enum.at(count - 1)
  end

  defp is_prime(2), do: true
  defp is_prime(3), do: true
  defp is_prime(n) when n < 2 or rem(n, 2) == 0, do: false

  defp is_prime(n) do
    max = :math.sqrt(n) |> trunc()

    3..max
    |> Enum.any?(fn x -> rem(n, x) == 0 end)
    |> Kernel.not()
  end
end

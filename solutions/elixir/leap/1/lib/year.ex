defmodule Year do
  @doc """
  Returns whether 'year' is a leap year.

  A leap year occurs:

  on every year that is evenly divisible by 4
    except every year that is evenly divisible by 100
      unless the year is also evenly divisible by 400
  """
  @spec leap_year?(non_neg_integer) :: boolean
  def leap_year?(year) do
    case year do
      x when rem(x, 400) == 0 -> true
      x when rem(x, 100) == 0 -> false
      x when rem(x, 4) == 0 -> true
      _ -> false
    end
  end
end

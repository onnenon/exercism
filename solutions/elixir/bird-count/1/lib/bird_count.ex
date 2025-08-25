defmodule BirdCount do
  def today(list), do: List.first(list)

  def increment_day_count([first | rest]), do: [first + 1 | rest]

  def increment_day_count([]), do: [1]

  def has_day_without_birds?(list), do: Enum.any?(list, fn x -> x == 0 end)

  def total(list), do: Enum.sum(list)

  def busy_days(list), do: Enum.count(list, fn x -> x > 4 end)
end

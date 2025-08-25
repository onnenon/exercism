defmodule BirdCount do
  def today([]), do: nil
  def today([h | _]), do: h

  def increment_day_count([]), do: [1]

  def increment_day_count([h | t]), do: [h + 1 | t]


  def has_day_without_birds?(list), do: Enum.any?(list, fn x -> x == 0 end)

  def total(list), do: Enum.sum(list)

  def busy_days(list), do: Enum.count(list, fn x -> x > 4 end)
end

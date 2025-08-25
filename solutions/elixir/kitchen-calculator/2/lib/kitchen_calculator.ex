defmodule KitchenCalculator do
  def get_volume({_, volume}), do: volume
  
  def to_milliliter({:cup, volume}), do: {:milliliter, volume * 240}
  def to_milliliter({:fluid_ounce, volume}), do: {:milliliter, volume * 30}
  def to_milliliter({:teaspoon, volume}), do: {:milliliter, volume * 5}
  def to_milliliter({:tablespoon, volume}), do: {:milliliter, volume * 15}
  def to_milliliter(pair), do: pair
  
  def from_milliliter({_, volume}, :cup), do: {:cup, volume / 240}
  def from_milliliter({_, volume}, :fluid_ounce), do: {:fluid_ounce, volume / 30}
  def from_milliliter({_, volume}, :teaspoon), do: {:teaspoon, volume / 5}
  def from_milliliter({_, volume}, :tablespoon), do: {:tablespoon, volume / 15}
  def from_milliliter(pair, :milliliter), do: pair

  def convert(pair, to_unit), do: pair |> to_milliliter() |> from_milliliter(to_unit)
end

defmodule KitchenCalculator do
  def get_volume({_, volume}) do
    volume
  end
  
  def to_milliliter({:cup, volume}), do: {:milliliter, volume * 240}

  def to_milliliter({:fluid_ounce, volume}), do: {:milliliter, volume * 30}

  def to_milliliter({:teaspoon, volume}), do: {:milliliter, volume * 5}

  def to_milliliter({:tablespoon, volume}), do: {:milliliter, volume * 15}

  def to_milliliter(x), do: x
  
  def from_milliliter({_, volume}, :cup), do: {:cup, volume / 240}

  def from_milliliter({_, volume}, :fluid_ounce), do: {:fluid_ounce, volume / 30}

  def from_milliliter({_, volume}, :teaspoon), do: {:teaspoon, volume / 5}

  def from_milliliter({_, volume}, :tablespoon), do: {:tablespoon, volume / 15}

  def from_milliliter(x, :milliliter), do: x

  def convert({:milliliter, volume}, to_unit) do
    from_milliliter({:milliliter, volume}, to_unit)
  end

 def convert(x, to_unit) do
    to_milliliter(x) |> from_milliliter(to_unit)
  end
end

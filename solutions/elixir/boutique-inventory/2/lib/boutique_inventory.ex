defmodule BoutiqueInventory do
  @type item :: %{name: String.t(), price: integer(), quantity_by_size: map()}
  @type inventory :: list(item())

  @spec sort_by_price(inventory()) :: inventory()
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, :price)
  end

  @spec with_missing_price(inventory()) :: inventory()
  def with_missing_price(inventory) do
    Enum.filter(inventory, &(&1.price === nil))
  end

  def update_names(inventory, old_word, new_word) do
    update_name = fn item ->
      Map.update(item, :name, "", fn name -> String.replace(name, old_word, new_word) end)
    end

    Enum.map(inventory, update_name)
  end

  @spec increase_quantity(item(), integer()) :: item()
  def increase_quantity(item, count) do
    update_sizes = fn sizes ->
      sizes
      |> Enum.map(fn {size, quantity} -> {size, quantity + count} end)
      |> Enum.into(%{})
    end

    Map.update(item, :quantity_by_size, %{}, update_sizes)
  end

  @spec total_quantity(item()) :: integer()
  def total_quantity(item) do
    Enum.reduce(item.quantity_by_size, 0, fn {_, v}, acc -> v + acc end)
  end
end

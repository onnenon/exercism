defmodule BoutiqueSuggestions do
  @default_max_price 100
  def get_combinations(tops, bottoms, options \\ []) do
    for top <- tops, bottom <- bottoms, top.base_color != bottom.base_color do
      {top, bottom}
    end
    |> filter_max_price(options[:maximum_price] || @default_max_price)
  end

  defp filter_max_price(outfits, max_price) do
    Enum.reject(outfits, fn {top, bottom} -> top.price + bottom.price > max_price end)
  end
end

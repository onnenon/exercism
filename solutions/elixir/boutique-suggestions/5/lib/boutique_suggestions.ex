defmodule BoutiqueSuggestions do
  @default_max_price 100
  def get_combinations(tops, bottoms, options \\ []) do
    max_price = options[:maximum_price] || @default_max_price

    for top <- tops,
        bottom <- bottoms,
        top.base_color != bottom.base_color,
        top.price + bottom.price <= max_price do
      {top, bottom}
    end
  end
end

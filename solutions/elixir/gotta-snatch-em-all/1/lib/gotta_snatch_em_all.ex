defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection) do
    if MapSet.member?(collection, card) do
      {true, collection}
    else
      {false, MapSet.put(collection, card)}
    end
  end

  defp have_card?(card, collection), do: MapSet.member?(collection, card)

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    have? = &have_card?(&1, collection)

    cond do
      have?.(your_card) and not have?.(their_card) ->
        updated_collection =
          collection
          |> MapSet.delete(your_card)
          |> MapSet.put(their_card)

        {true, updated_collection}

      not have?.(your_card) ->
        {false, MapSet.put(collection, their_card)}

      have?.(their_card) ->
        {false, MapSet.new([their_card])}
    end
  end

  @spec remove_duplicates([card()]) :: [card()]
  def remove_duplicates(cards) do
    cards |> MapSet.new() |> MapSet.to_list()
  end

  @spec extra_cards(collection(), collection()) :: non_neg_integer()
  def extra_cards(your_collection, their_collection) do
    MapSet.difference(your_collection, their_collection) |> MapSet.size()
  end

  @spec boring_cards([collection()]) :: [card()]
  def boring_cards([]), do: []

  def boring_cards(collections) do
    collections
    |> Enum.reduce(fn col, acc -> MapSet.intersection(acc, col) end)
    |> MapSet.to_list()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0

  def total_cards(collections) do
    collections
    |> Enum.reduce(fn col, acc -> MapSet.union(col, acc) end)
    |> MapSet.size()
  end

  @spec split_shiny_cards(collection()) :: {[card()], [card()]}
  def split_shiny_cards(collection) do
    collection
    |> MapSet.split_with(&String.starts_with?(&1, "Shiny"))
    |> Tuple.to_list()
    |> Enum.map(&MapSet.to_list/1)
    |> List.to_tuple()
  end
end

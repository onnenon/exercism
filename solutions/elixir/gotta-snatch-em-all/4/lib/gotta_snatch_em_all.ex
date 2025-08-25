defmodule GottaSnatchEmAll do
  @type card :: String.t()
  @type collection :: MapSet.t(card())

  @spec new_collection(card()) :: collection()
  def new_collection(card) do
    MapSet.new([card])
  end

  @spec add_card(card(), collection()) :: {boolean(), collection()}
  def add_card(card, collection),
    do: {MapSet.member?(collection, card), MapSet.put(collection, card)}

  @spec trade_card(card(), card(), collection()) :: {boolean(), collection()}
  def trade_card(your_card, their_card, collection) do
    have_card? = &MapSet.member?(collection, &1)

    new_collection = MapSet.delete(collection, your_card) |> MapSet.put(their_card)
    worth? = have_card?.(your_card) and not have_card?.(their_card)

    {worth?, new_collection}
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
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()
  end

  @spec total_cards([collection()]) :: non_neg_integer()
  def total_cards([]), do: 0

  def total_cards(collections) do
    collections
    |> Enum.reduce(&MapSet.union/2)
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

defmodule Poker do
  @type suit :: :hearts | :clubs | :diamonds | :spades
  @type hand_category ::
          :high_card
          | :pair
          | :two_pair
          | :three_of_a_kind
          | :straight
          | :flush
          | :full_house
          | :four_of_a_kind
          | :straight_flush

  defmodule Card do
    @type t :: %__MODULE__{
            suit: Poker.suit(),
            rank: integer()
          }
    defstruct [:suit, :rank]
  end

  defmodule Hand do
    @type t :: %__MODULE__{
            category: Poker.hand_category(),
            cards: list(Card.t()),
            raw: list(String.t())
          }
    defstruct [:category, :raw, cards: []]
  end

  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand([_] = hands), do: hands

  def best_hand(hands) do
    hands_with_categories =
      hands
      |> Enum.map(&parse_hand/1)

    highest_ranking_hands =
      hands_with_categories
      |> Enum.sort(&compare_hands/2)
      |> get_highest_ranking_hands()

    highest_ranking_hands
    |> Enum.map(& &1.raw)
  end

  defp compare_hands(hand1, hand2) do
    rank1 = hand_category_to_rank(hand1.category)
    rank2 = hand_category_to_rank(hand2.category)

    cond do
      rank1 > rank2 -> true
      rank1 < rank2 -> false
      true -> compare_same_category_hands(hand1, hand2)
    end
  end

  defp compare_same_category_hands(hand1, hand2) do
    case hand1.category do
      :straight_flush -> compare_straight_hands(hand1, hand2)
      :four_of_a_kind -> compare_four_of_a_kind_hands(hand1, hand2)
      :full_house -> compare_full_house_hands(hand1, hand2)
      :flush -> compare_by_high_cards(hand1, hand2)
      :straight -> compare_straight_hands(hand1, hand2)
      :three_of_a_kind -> compare_three_of_a_kind_hands(hand1, hand2)
      :two_pair -> compare_two_pair_hands(hand1, hand2)
      :pair -> compare_pair_hands(hand1, hand2)
      :high_card -> compare_by_high_cards(hand1, hand2)
      _ -> false
    end
  end

  defp compare_by_high_cards(hand1, hand2) do
    ranks1 = hand1.cards |> Enum.map(& &1.rank) |> Enum.sort(&(&1 >= &2))
    ranks2 = hand2.cards |> Enum.map(& &1.rank) |> Enum.sort(&(&1 >= &2))

    compare_ranks_lists(ranks1, ranks2)
  end

  defp compare_ranks_lists([], []), do: false

  defp compare_ranks_lists([r1 | rest1], [r2 | rest2]) do
    cond do
      r1 > r2 -> true
      r1 < r2 -> false
      true -> compare_ranks_lists(rest1, rest2)
    end
  end

  # Compare straight hands (also used for straight flushes)
  defp compare_straight_hands(hand1, hand2) do
    high_card1 = get_straight_high_card(hand1)
    high_card2 = get_straight_high_card(hand2)

    high_card1 > high_card2
  end

  # Get the high card of a straight, handling A-5 as the lowest straight
  defp get_straight_high_card(hand) do
    ranks = Enum.map(hand.cards, & &1.rank)

    # Check if this is an A-5 straight
    if Enum.member?(ranks, 14) && Enum.sort(ranks -- [14]) == [2, 3, 4, 5] do
      # A-5 straight is ranked by the 5
      5
    else
      Enum.max(ranks)
    end
  end

  # Compare four of a kind hands
  defp compare_four_of_a_kind_hands(hand1, hand2) do
    {four_rank1, kicker1} = get_four_of_a_kind_info(hand1)
    {four_rank2, kicker2} = get_four_of_a_kind_info(hand2)

    cond do
      four_rank1 > four_rank2 -> true
      four_rank1 < four_rank2 -> false
      kicker1 > kicker2 -> true
      kicker1 < kicker2 -> false
      true -> false
    end
  end

  defp get_four_of_a_kind_info(hand) do
    ranks = Enum.map(hand.cards, & &1.rank)
    rank_counts = Enum.frequencies(ranks)

    four_rank =
      rank_counts
      |> Enum.find(fn {_rank, count} -> count == 4 end)
      |> elem(0)

    kicker =
      rank_counts
      |> Enum.find(fn {_rank, count} -> count == 1 end)
      |> elem(0)

    {four_rank, kicker}
  end

  defp compare_full_house_hands(hand1, hand2) do
    {three_rank1, pair_rank1} = get_full_house_info(hand1)
    {three_rank2, pair_rank2} = get_full_house_info(hand2)

    cond do
      three_rank1 > three_rank2 -> true
      three_rank1 < three_rank2 -> false
      pair_rank1 > pair_rank2 -> true
      pair_rank1 < pair_rank2 -> false
      true -> false
    end
  end

  defp get_full_house_info(hand) do
    ranks = Enum.map(hand.cards, & &1.rank)
    rank_counts = Enum.frequencies(ranks)

    three_rank =
      rank_counts
      |> Enum.find(fn {_rank, count} -> count == 3 end)
      |> elem(0)

    pair_rank =
      rank_counts
      |> Enum.find(fn {_rank, count} -> count == 2 end)
      |> elem(0)

    {three_rank, pair_rank}
  end

  defp compare_three_of_a_kind_hands(hand1, hand2) do
    {three_rank1, kickers1} = get_three_of_a_kind_info(hand1)
    {three_rank2, kickers2} = get_three_of_a_kind_info(hand2)

    cond do
      three_rank1 > three_rank2 -> true
      three_rank1 < three_rank2 -> false
      true -> compare_ranks_lists(kickers1, kickers2)
    end
  end

  defp get_three_of_a_kind_info(hand) do
    ranks = Enum.map(hand.cards, & &1.rank)
    rank_counts = Enum.frequencies(ranks)

    three_rank =
      rank_counts
      |> Enum.find(fn {_rank, count} -> count == 3 end)
      |> elem(0)

    kickers =
      ranks
      |> Enum.filter(fn rank -> rank != three_rank end)
      |> Enum.sort(&(&1 >= &2))

    {three_rank, kickers}
  end

  defp compare_two_pair_hands(hand1, hand2) do
    {high_pair1, low_pair1, kicker1} = get_two_pair_info(hand1)
    {high_pair2, low_pair2, kicker2} = get_two_pair_info(hand2)

    cond do
      high_pair1 > high_pair2 -> true
      high_pair1 < high_pair2 -> false
      low_pair1 > low_pair2 -> true
      low_pair1 < low_pair2 -> false
      kicker1 > kicker2 -> true
      kicker1 < kicker2 -> false
      true -> false
    end
  end

  defp get_two_pair_info(hand) do
    ranks = Enum.map(hand.cards, & &1.rank)
    rank_counts = Enum.frequencies(ranks)

    pairs =
      rank_counts
      |> Enum.filter(fn {_rank, count} -> count == 2 end)
      |> Enum.map(fn {rank, _count} -> rank end)
      |> Enum.sort(&(&1 >= &2))

    [high_pair, low_pair] = pairs

    kicker =
      ranks
      |> Enum.find(fn rank -> !Enum.member?(pairs, rank) end)

    {high_pair, low_pair, kicker}
  end

  defp compare_pair_hands(hand1, hand2) do
    {pair_rank1, kickers1} = get_pair_info(hand1)
    {pair_rank2, kickers2} = get_pair_info(hand2)

    cond do
      pair_rank1 > pair_rank2 -> true
      pair_rank1 < pair_rank2 -> false
      true -> compare_ranks_lists(kickers1, kickers2)
    end
  end

  # Get the rank of the pair and the kickers
  defp get_pair_info(hand) do
    ranks = Enum.map(hand.cards, & &1.rank)
    rank_counts = Enum.frequencies(ranks)

    pair_rank =
      rank_counts
      |> Enum.find(fn {_rank, count} -> count == 2 end)
      |> elem(0)

    kickers =
      ranks
      |> Enum.filter(fn rank -> rank != pair_rank end)
      |> Enum.sort(&(&1 >= &2))

    {pair_rank, kickers}
  end

  defp get_highest_ranking_hands([highest_hand | rest]) do
    same_category_hands = [
      highest_hand
      | Enum.filter(rest, fn hand ->
          hand.category == highest_hand.category
        end)
    ]

    Enum.filter(same_category_hands, fn hand1 ->
      !Enum.any?(same_category_hands, fn hand2 ->
        hand1 != hand2 && compare_hands(hand2, hand1)
      end)
    end)
  end

  defp parse_hand(hand) do
    alias Poker.Card

    cards =
      hand
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(fn
        [r, s] -> %Card{rank: rank_from_string(r), suit: suit_from_string(s)}
        [r1, r2, s] -> %Card{rank: rank_from_string(r1 <> r2), suit: suit_from_string(s)}
      end)

    category = get_category(cards)

    %Hand{cards: cards, category: category, raw: hand}
  end

  @spec rank_from_string(String.t()) :: integer()
  defp rank_from_string(r) do
    case r do
      "A" -> 14
      "K" -> 13
      "Q" -> 12
      "J" -> 11
      "10" -> 10
      n -> String.to_integer(n)
    end
  end

  @spec suit_from_string(<<_::8>>) :: Poker.suit()
  defp suit_from_string(s) do
    case s do
      "S" -> :spades
      "H" -> :hearts
      "D" -> :diamonds
      "C" -> :clubs
    end
  end

  @spec get_category(list(Poker.Card.t())) :: Poker.hand_category()
  defp get_category(cards) do
    ranks = Enum.map(cards, & &1.rank)
    suits = Enum.map(cards, & &1.suit)

    cond do
      straight_flush?(ranks, suits) -> :straight_flush
      four_of_a_kind?(ranks) -> :four_of_a_kind
      full_house?(ranks) -> :full_house
      flush?(suits) -> :flush
      straight?(ranks) -> :straight
      three_of_a_kind?(ranks) -> :three_of_a_kind
      two_pair?(ranks) -> :two_pair
      pair?(ranks) -> :pair
      true -> :high_card
    end
  end

  defp straight_flush?(ranks, suits) do
    straight?(ranks) && flush?(suits)
  end

  defp four_of_a_kind?(ranks) do
    rank_counts = Enum.frequencies(ranks)
    Enum.any?(rank_counts, fn {_rank, count} -> count == 4 end)
  end

  defp full_house?(ranks) do
    rank_counts = Enum.frequencies(ranks)
    Map.values(rank_counts) |> Enum.sort() == [2, 3]
  end

  defp flush?(suits) do
    length(Enum.uniq(suits)) == 1
  end

  defp straight?(ranks) do
    sorted_unique_ranks = Enum.sort(Enum.uniq(ranks))

    regular_straight =
      length(sorted_unique_ranks) == 5 &&
        Enum.max(sorted_unique_ranks) - Enum.min(sorted_unique_ranks) == 4

    ace_low_straight =
      length(sorted_unique_ranks) == 5 &&
        Enum.member?(ranks, 14) &&
        Enum.sort(ranks -- [14]) == [2, 3, 4, 5]

    regular_straight || ace_low_straight
  end

  defp three_of_a_kind?(ranks) do
    rank_counts = Enum.frequencies(ranks)

    Enum.any?(rank_counts, fn {_rank, count} -> count == 3 end) &&
      Enum.count(rank_counts) == 3
  end

  defp two_pair?(ranks) do
    rank_counts = Enum.frequencies(ranks)
    Enum.count(rank_counts, fn {_rank, count} -> count == 2 end) == 2
  end

  defp pair?(ranks) do
    rank_counts = Enum.frequencies(ranks)
    Enum.count(rank_counts, fn {_rank, count} -> count == 2 end) == 1
  end

  def hand_category_to_rank(category) do
    case category do
      :straight_flush -> 9
      :four_of_a_kind -> 8
      :full_house -> 7
      :flush -> 6
      :straight -> 5
      :three_of_a_kind -> 4
      :two_pair -> 3
      :pair -> 2
      :high_card -> 1
      _ -> 0
    end
  end
end

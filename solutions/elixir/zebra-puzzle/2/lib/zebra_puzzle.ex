defmodule ZebraPuzzle do
  @moduledoc """
  There are five houses.
  The Englishman lives in the red house.
  The Spaniard owns the dog.
  The person in the green house drinks coffee.
  The Ukrainian drinks tea.
  The green house is immediately to the right of the ivory house.
  The snail owner likes to go dancing.
  The person in the yellow house is a painter.
  The person in the middle house drinks milk.
  The Norwegian lives in the first house.
  The person who enjoys reading lives in the house next to the person with the fox.
  The painter's house is next to the house with the horse.
  The person who plays football drinks orange juice.
  The Japanese person plays chess.
  The Norwegian lives next to the blue house.
  """

  @puzzle_content [
    House: ~c"",
    Nationality: ~w[english spaniard ukrainian norwegian japanese]a,
    Color: ~w[red green ivory blue yellow]a,
    Pet: ~w[dog snail fox horse zebra]a,
    Drink: ~w[tea coffee milk orange_juice water]a,
    Hobby: ~w[dancing painting reading chess football]a
  ]

  defp adjacent?(list1, item1, list2, item2) do
    indices1 = find_indices(list1, item1)
    indices2 = find_indices(list2, item2)

    Enum.any?(indices1, fn i1 ->
      Enum.any?(indices2, fn i2 ->
        abs(i1 - i2) == 1
      end)
    end)
  end

  defp left_of?(list1, item1, list2, item2) do
    indices1 = find_indices(list1, item1)
    indices2 = find_indices(list2, item2)

    Enum.any?(indices1, fn i1 ->
      Enum.any?(indices2, fn i2 ->
        i1 + 1 == i2
      end)
    end)
  end

  defp coincident?(list1, item1, list2, item2) do
    indices1 = find_indices(list1, item1)
    indices2 = find_indices(list2, item2)

    Enum.any?(indices1, fn i -> i in indices2 end)
  end

  # Find all indices where an item appears in a list
  defp find_indices(list, item) do
    list
    |> Enum.with_index()
    |> Enum.filter(fn {val, _} -> val == item end)
    |> Enum.map(fn {_, idx} -> idx end)
  end

  defp permutation([]), do: [[]]

  defp permutation(list) do
    for x <- list, y <- permutation(list -- [x]), do: [x | y]
  end

  defp transpose(lists) do
    lists |> Enum.zip() |> Enum.map(&Tuple.to_list/1)
  end

  defp solve(content) do
    colors = permutation(content[:Color])
    pets = permutation(content[:Pet])
    drinks = permutation(content[:Drink])
    hobbies = permutation(content[:Hobby])
    nationalities = permutation(content[:Nationality])

    Stream.flat_map(nationalities, fn nation ->
      if hd(nation) != :norwegian,
        do: [],
        else:
          Stream.flat_map(colors, fn color ->
            if !left_of?(color, :green, color, :ivory) ||
                 !coincident?(nation, :english, color, :red) ||
                 !adjacent?(nation, :norwegian, color, :blue),
               do: [],
               else:
                 Stream.flat_map(pets, fn pet ->
                   if !coincident?(nation, :spaniard, pet, :dog),
                     do: [],
                     else:
                       Stream.flat_map(drinks, fn drink ->
                         if Enum.at(drink, 2) != :milk ||
                              !coincident?(nation, :ukrainian, drink, :tea) ||
                              !coincident?(color, :green, drink, :coffee),
                            do: [],
                            else:
                              Stream.map(hobbies, fn hobby ->
                                if coincident?(hobby, :dancing, pet, :snail) &&
                                     coincident?(hobby, :painting, color, :yellow) &&
                                     coincident?(hobby, :football, drink, :orange_juice) &&
                                     coincident?(hobby, :chess, nation, :japanese) &&
                                     adjacent?(hobby, :reading, pet, :fox) &&
                                     adjacent?(hobby, :painting, pet, :horse) do
                                  transpose([nation, color, pet, drink, hobby])
                                else
                                  nil
                                end
                              end)
                              |> Stream.reject(&is_nil/1)
                       end)
                 end)
          end)
    end)
    |> Stream.reject(&is_nil/1)
    |> Enum.at(0)
  end

  @doc """
  Determine who drinks the water
  """
  @spec drinks_water() :: atom
  def drinks_water() do
    solution = solve(@puzzle_content)

    solution
    |> Enum.find(fn house -> :water in house end)
    |> hd()
  end

  @doc """
  Determine who owns the zebra
  """
  @spec owns_zebra() :: atom
  def owns_zebra() do
    solution = solve(@puzzle_content)

    solution
    |> Enum.find(fn house -> :zebra in house end)
    |> hd()
  end
end

defmodule RPG do
  defmodule Character do
    defstruct health: 100, mana: 0
  end

  defmodule LoafOfBread do
    defstruct []
  end

  defmodule ManaPotion do
    defstruct strength: 10
  end

  defmodule Poison do
    defstruct []
  end

  defmodule EmptyBottle do
    defstruct []
  end

  # Add code to define the protocol and its implementations below here...
  defprotocol Edible do
    @spec eat(any, Character) :: {any(), Character}
    def eat(item, character)
  end

  defimpl Edible, for: LoafOfBread do
    def eat(_, character) do
      {nil, Map.update(character, :health, 100, &(&1 + 5))}
    end
  end

  defimpl Edible, for: ManaPotion do
    def eat(potion, character) do
      {%EmptyBottle{}, Map.update(character, :mana, 0, &(&1 + potion.strength))}
    end
  end

  defimpl Edible, for: Poison do
    def eat(_, character) do
      {%EmptyBottle{}, Map.put(character, :health, 0)}
    end
  end
end

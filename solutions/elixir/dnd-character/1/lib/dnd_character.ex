defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    ((score - 10) / 2) |> Float.floor() |> trunc()
  end

  @spec ability :: pos_integer()
  def ability do
    1..4
    |> Enum.map(fn _ -> Enum.random(1..6) end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    strength = ability()
    dexterity = ability()
    constitution = ability()
    intelligence = ability()
    wisdom = ability()
    charisma = ability()
    hitpoints = 10 + modifier(constitution)

    %DndCharacter{
      strength: strength,
      dexterity: dexterity,
      constitution: constitution,
      intelligence: intelligence,
      wisdom: wisdom,
      charisma: charisma,
      hitpoints: hitpoints
    }
  end
end

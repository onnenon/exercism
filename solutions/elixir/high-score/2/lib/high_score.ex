defmodule HighScore do
  @starting_score 0

  def new(), do: %{}

  def add_player(scores, name, score \\ @starting_score),  do: Map.put(scores, name, score)

  @spec remove_player(map(), String.t()) :: map()
  def remove_player(scores, name), do: Map.delete(scores, name)

  def reset_score(scores, name), do: Map.put(scores, name, @starting_score)

  def update_score(scores, name, score), do: Map.update(scores, name, score, fn e -> e + score end)

  def get_players(scores), do: Map.keys(scores)
end

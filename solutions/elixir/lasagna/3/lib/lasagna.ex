defmodule Lasagna do
  @lasagna_cook_time 40
  @layer_prep_time 2

  def expected_minutes_in_oven(), do: @lasagna_cook_time
  def remaining_minutes_in_oven(minutes), do: @lasagna_cook_time - minutes
  def preparation_time_in_minutes(layers), do: layers * @layer_prep_time
  def alarm(), do: "Ding!"

  def total_time_in_minutes(layers, elapsed_time),
    do: preparation_time_in_minutes(layers) + elapsed_time
end

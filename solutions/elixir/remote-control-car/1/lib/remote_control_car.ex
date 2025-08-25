defmodule RemoteControlCar do
  @enforce_keys [:nickname]
  defstruct [:nickname, battery_percentage: 100, distance_driven_in_meters: 0]
  # Please implement the struct with the specified fields

  def new() do
    %RemoteControlCar{nickname: "none"}
  end

  def new(nickname) do
    %RemoteControlCar{nickname: nickname}
  end

  def display_distance(%RemoteControlCar{distance_driven_in_meters: distance}) do
    "#{distance} meters"
  end

  def display_battery(%RemoteControlCar{battery_percentage: 0}) do
    "Battery empty"
  end

  def display_battery(%RemoteControlCar{battery_percentage: bp}) do
    "Battery at #{bp}%"
  end

  def drive(%RemoteControlCar{battery_percentage: 0} = rc), do: rc

  def drive(%RemoteControlCar{} = rc) do
    %{
      rc
      | distance_driven_in_meters: rc.distance_driven_in_meters + 20,
        battery_percentage: rc.battery_percentage - 1
    }
  end
end

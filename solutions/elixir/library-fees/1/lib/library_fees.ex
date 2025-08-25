defmodule LibraryFees do
  def datetime_from_string(string) do
    {_, datetime, _} = DateTime.from_iso8601(string)
    DateTime.to_naive(datetime)
  end

  def before_noon?(datetime) do
    time = NaiveDateTime.to_time(datetime)

    if Time.compare(time, ~T[12:00:00]) == :lt do
      true
    else
      false
    end
  end

  def return_date(checkout_datetime) do
    date = NaiveDateTime.to_date(checkout_datetime)

    if before_noon?(checkout_datetime) do
      Date.add(date, 28)
    else
      Date.add(date, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    if Date.compare(actual_return_datetime, planned_return_date) == :gt do
      Date.diff(actual_return_datetime, planned_return_date)
    else
      0
    end
  end

  def monday?(datetime) do
    NaiveDateTime.to_date(datetime) |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    with checkout_dt <- datetime_from_string(checkout),
         return_dt <- datetime_from_string(return),
         planned_return_date <- return_date(checkout_dt),
         actual_return_date <- NaiveDateTime.to_date(return_dt) do
      adj_rate = if monday?(return_dt), do: rate * 0.5, else: rate
      late_days = days_late(planned_return_date, actual_return_date)
      trunc(adj_rate * late_days)
    end
  end
end

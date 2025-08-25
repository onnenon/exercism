defmodule RPNCalculatorInspection do
  def start_reliability_check(calculator, input) do
    %{input: input, pid: spawn_link(fn -> calculator.(input) end)}
  end

  def await_reliability_check_result(%{pid: pid, input: input}, results) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(results, input, :ok)
      {:EXIT, ^pid, _} -> Map.put(results, input, :error)
    after
      100 -> Map.put(results, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    flag = Process.flag(:trap_exit, true)

    processes =
      inputs
      |> Enum.map(&start_reliability_check(calculator, &1))

    results =
      processes
      |> Enum.reduce(%{}, fn m, acc ->
        await_reliability_check_result(m, acc)
      end)

    Process.flag(:trap_exit, flag)
    results
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(fn input -> Task.async(fn -> calculator.(input) end) end)
    |> Enum.map(&Task.await(&1, 100))
  end
end

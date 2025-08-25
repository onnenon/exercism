# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: [], id: 0} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, & &1.plots)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn state ->
      next_id = state.id + 1
      new_plot = %Plot{plot_id: next_id, registered_to: register_to}
      {new_plot, %{plots: [new_plot | state.plots], id: next_id}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn state ->
      %{plots: Enum.reject(state.plots, fn plot -> plot.plot_id == plot_id end), id: state.id}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn state ->
      Enum.find(
        state.plots,
        {:not_found, "plot is unregistered"},
        fn plot -> plot.plot_id == plot_id end
      )
    end)
  end
end

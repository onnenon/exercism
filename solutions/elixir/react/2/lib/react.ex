defmodule React do
  use GenServer

  defmodule State do
    @type t :: %__MODULE__{}
    defstruct inputs: %{}, outputs: %{}, callbacks: %{}

    def new(cells) do
      cells
      |> Enum.reduce(%State{}, fn
        {:input, name, value}, acc -> put_in(acc.inputs[name], value)
        {:output, name, args, fun}, acc -> put_in(acc.outputs[name], %{args: args, fun: fun})
      end)
    end

    def get_value(%State{inputs: inputs}, cell_name) when is_map_key(inputs, cell_name),
      do: inputs[cell_name]

    def get_value(%State{outputs: outputs} = state, cell_name)
        when is_map_key(outputs, cell_name) do
      %{args: args, fun: fun} = outputs[cell_name]
      apply(fun, Enum.map(args, &get_value(state, &1)))
    end

    def set_value(%__MODULE__{} = state, cell_name, value) do
      new_state =
        put_in(state.inputs[cell_name], value)
        |> tap(fn new_state ->
          Enum.each(new_state.callbacks, fn {callback_name, callback_data} ->
            may_notify(callback_name, callback_data, state, new_state)
          end)
        end)

      {:ok, new_state}
    end

    defp may_notify(callback_name, %{cell_name: cell_name, fn: fun}, old_state, new_state) do
      old_state = get_value(old_state, cell_name)

      new_value = get_value(new_state, cell_name)

      if old_state != new_value, do: fun.(callback_name, new_value)
    end

    def add_callback(%__MODULE__{} = state, cell_name, callback_name, callback) do
      new_callbacks =
        Map.put(state.callbacks, callback_name, %{cell_name: cell_name, fn: callback})

      {:ok, %State{state | callbacks: new_callbacks}}
    end

    def remove_callback(%__MODULE__{} = state, callback_name) do
      new_callbacks = Map.delete(state.callbacks, callback_name)
      {:ok, %State{state | callbacks: new_callbacks}}
    end
  end

  @opaque cells :: pid

  @type cell :: {:input, String.t(), any} | {:output, String.t(), [String.t()], fun(), map()}

  @doc """
  Start a reactive system
  """
  @spec new(cells :: [cell]) :: {:ok, pid}
  def new(cells) do
    GenServer.start_link(__MODULE__, cells)
  end

  @doc """
  Return the value of an input or output cell
  """
  @spec get_value(cells :: pid, cell_name :: String.t()) :: any()
  def get_value(cells, cell_name) do
    GenServer.call(cells, {:get_value, cell_name})
  end

  @doc """
  Set the value of an input cell
  """
  @spec set_value(cells :: pid, cell_name :: String.t(), value :: any) :: :ok
  def set_value(cells, cell_name, value) do
    GenServer.call(cells, {:set_value, cell_name, value})
  end

  @doc """
  Add a callback to an output cell
  """
  @spec add_callback(
          cells :: pid,
          cell_name :: String.t(),
          callback_name :: String.t(),
          callback :: fun()
        ) :: :ok
  def add_callback(cells, cell_name, callback_name, callback) do
    GenServer.call(cells, {:add_callback, cell_name, callback_name, callback})
  end

  @doc """
  Remove a callback from an output cell
  """
  @spec remove_callback(cells :: pid, cell_name :: String.t(), callback_name :: String.t()) :: :ok
  def remove_callback(cells, _cell_name, callback_name) do
    GenServer.call(cells, {:remove_callback, callback_name})
  end

  @impl GenServer
  def init(cells) do
    State.new(cells)
    {:ok, State.new(cells)}
  end

  @impl GenServer
  def handle_call({:get_value, cell_name}, _from, state) do
    value = State.get_value(state, cell_name)
    {:reply, value, state}
  end

  @impl GenServer
  def handle_call({:set_value, cell_name, value}, _from, state) do
    with {:ok, new_state} <- State.set_value(state, cell_name, value) do
      {:reply, :ok, new_state}
    else
      e -> {:reply, e, state}
    end
  end

  @impl GenServer
  def handle_call({:add_callback, cell_name, callback_name, callback}, _from, state) do
    with {:ok, new_state} <- State.add_callback(state, cell_name, callback_name, callback) do
      {:reply, :ok, new_state}
    else
      e -> {:reply, e, state}
    end
  end

  @impl GenServer
  def handle_call({:remove_callback, callback_name}, _from, state) do
    with {:ok, new_state} <- State.remove_callback(state, callback_name) do
      {:reply, :ok, new_state}
    else
      e -> {:reply, e, state}
    end
  end
end

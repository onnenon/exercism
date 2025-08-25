defmodule React do
  use GenServer

  defmodule State do
    @type t :: %__MODULE__{}
    defstruct cells: [], callbacks: %{}

    def new(cells) do
      %State{cells: cells, callbacks: %{}}
    end

    def get_value(%__MODULE__{} = state, cell_name) do
      case Enum.find(state.cells, fn
             {:input, ^cell_name, _} -> true
             {:output, ^cell_name, _, _} -> true
             _ -> false
           end) do
        {:input, ^cell_name, value} ->
          {:ok, value}

        {:output, ^cell_name, args, func} ->
          arg_values =
            Enum.map(args, fn arg ->
              case get_value(state, arg) do
                {:ok, v} -> v
                _ -> nil
              end
            end)

          {:ok, apply(func, arg_values)}

        nil ->
          {:error, :not_found}
      end
    end

    def set_value(%__MODULE__{} = state, cell_name, value) do
      new_cells = update_input_cell(state.cells, cell_name, value)
      new_state = %State{state | cells: new_cells}

      affected = all_affected_output_cells(state, [cell_name], MapSet.new())
      callbacks = callbacks_to_fire(state, new_state, affected)
      fire_callbacks(callbacks)

      {:ok, new_state}
    end

    defp update_input_cell(cells, cell_name, value) do
      Enum.map(cells, fn
        {:input, ^cell_name, _} -> {:input, cell_name, value}
        other -> other
      end)
    end

    def get_affected_cells(%__MODULE__{} = state, cell_name) do
      state.cells
      |> Enum.filter(fn
        {:output, _name, arr, _} -> cell_name in arr
        _ -> false
      end)
      |> Enum.map(fn {:output, name, _, _} -> name end)
    end

    defp all_affected_output_cells(state, cells_to_check, acc) do
      new_cells =
        cells_to_check
        |> Enum.flat_map(fn cell -> get_affected_cells(state, cell) end)
        |> Enum.reject(fn cell -> MapSet.member?(acc, cell) end)

      new_acc = Enum.reduce(new_cells, acc, &MapSet.put(&2, &1))

      if Enum.empty?(new_cells) do
        MapSet.to_list(new_acc)
      else
        all_affected_output_cells(state, new_cells, new_acc)
      end
    end

    defp callbacks_to_fire(old_state, new_state, affected_cells) do
      affected_cells
      |> Enum.flat_map(fn out_cell_name ->
        old_value = State.get_value(old_state, out_cell_name)
        new_value = State.get_value(new_state, out_cell_name)

        case {old_value, new_value} do
          {{:ok, old}, {:ok, new}} when old != new ->
            old_state.callbacks
            |> Enum.filter(fn {{cell, _cb_name}, _cb_fun} -> cell == out_cell_name end)
            |> Enum.map(fn {{_cell, cb_name}, cb_fun} -> {cb_name, cb_fun, new} end)

          _ ->
            []
        end
      end)
      |> Enum.uniq_by(fn {cb_name, _cb_fun, new} -> {cb_name, new} end)
    end

    defp fire_callbacks(callbacks) do
      Enum.each(callbacks, fn {cb_name, cb_fun, new} -> cb_fun.(cb_name, new) end)
    end

    def add_callback(%__MODULE__{} = state, cell_name, callback_name, callback) do
      new_callbacks = Map.put(state.callbacks, {cell_name, callback_name}, callback)
      {:ok, %State{state | callbacks: new_callbacks}}
    end

    def remove_callback(%__MODULE__{} = state, cell_name, callback_name) do
      new_callbacks = Map.delete(state.callbacks, {cell_name, callback_name})
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
  def remove_callback(cells, cell_name, callback_name) do
    GenServer.call(cells, {:remove_callback, cell_name, callback_name})
  end

  @impl GenServer
  def init(cells) do
    State.new(cells)
    {:ok, State.new(cells)}
  end

  @impl GenServer
  def handle_call({:get_value, cell_name}, _from, state) do
    with {:ok, value} <- State.get_value(state, cell_name) do
      {:reply, value, state}
    else
      e -> {:reply, e, state}
    end
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
  def handle_call({:remove_callback, cell_name, callback_name}, _from, state) do
    with {:ok, new_state} <- State.remove_callback(state, cell_name, callback_name) do
      {:reply, :ok, new_state}
    else
      e -> {:reply, e, state}
    end
  end
end

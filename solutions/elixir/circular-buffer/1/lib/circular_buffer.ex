defmodule CircularBuffer do
  use GenServer

  defmodule State do
    @type t :: %__MODULE__{}

    @enforce_keys [:buffer, :capacity]
    defstruct [:buffer, :capacity, count: 0, head_idx: 0, tail_idx: 0]

    @spec new(non_neg_integer()) :: CircularBuffer.State.t()
    def new(capacity) do
      %State{buffer: Tuple.duplicate(nil, capacity), capacity: capacity}
    end

    @spec read(CircularBuffer.State.t()) ::
            {:error, :empty} | {:ok, any(), CircularBuffer.State.t()}
    def read(%__MODULE__{} = state) do
      if state.count > 0 do
        item = elem(state.buffer, state.head_idx)
        new_count = state.count - 1
        new_head_idx = rem(state.head_idx + 1, state.capacity)
        new_state = %{state | count: new_count, head_idx: new_head_idx}
        {:ok, item, new_state}
      else
        {:error, :empty}
      end
    end

    @spec write(CircularBuffer.State.t(), any()) ::
            {:error, :full} | {:ok, CircularBuffer.State.t()}
    def write(%__MODULE__{} = state, item, overwrite \\ false) do
      cond do
        state.count == state.capacity and not overwrite ->
          {:error, :full}

        state.count == state.capacity and overwrite ->
          new_buffer = put_elem(state.buffer, state.tail_idx, item)
          new_tail = rem(state.tail_idx + 1, state.capacity)
          new_head = rem(state.head_idx + 1, state.capacity)
          new_state = %{state | buffer: new_buffer, tail_idx: new_tail, head_idx: new_head}
          {:ok, new_state}

        true ->
          new_buffer = put_elem(state.buffer, state.tail_idx, item)
          new_tail = rem(state.tail_idx + 1, state.capacity)
          new_count = state.count + 1
          new_state = %{state | buffer: new_buffer, tail_idx: new_tail, count: new_count}
          {:ok, new_state}
      end
    end
  end

  @moduledoc """
  An API to a stateful process that fills and empties a circular buffer
  """

  @doc """
  Create a new buffer of a given capacity
  """
  @spec new(capacity :: integer) :: {:ok, pid}
  def new(capacity) do
    GenServer.start_link(__MODULE__, capacity)
  end

  @doc """
  Read the oldest entry in the buffer, fail if it is empty
  """
  @spec read(buffer :: pid) :: {:ok, any} | {:error, atom}
  def read(buffer) do
    GenServer.call(buffer, :read)
  end

  @doc """
  Write a new item in the buffer, fail if is full
  """
  @spec write(buffer :: pid, item :: any) :: :ok | {:error, atom}
  def write(buffer, item) do
    GenServer.call(buffer, {:write, item})
  end

  @doc """
  Write an item in the buffer, overwrite the oldest entry if it is full
  """
  @spec overwrite(buffer :: pid, item :: any) :: :ok
  def overwrite(buffer, item) do
    GenServer.call(buffer, {:overwrite, item})
  end

  @doc """
  Clear the buffer
  """
  @spec clear(buffer :: pid) :: :ok
  def clear(buffer) do
    GenServer.call(buffer, :clear)
  end

  @impl GenServer
  def init(capacity) do
    {:ok, State.new(capacity)}
  end

  @impl GenServer
  def handle_call(:read, _from, state) do
    with {:ok, item, new_state} <- State.read(state) do
      {:reply, {:ok, item}, new_state}
    else
      error -> {:reply, error, state}
    end
  end

  @impl GenServer
  def handle_call({:write, item}, _from, state) do
    with {:ok, new_state} <- State.write(state, item) do
      {:reply, :ok, new_state}
    else
      error -> {:reply, error, state}
    end
  end

  @impl GenServer
  def handle_call({:overwrite, item}, _from, state) do
    with {:ok, new_state} <- State.write(state, item, true) do
      {:reply, :ok, new_state}
    else
      error -> {:reply, error, state}
    end
  end

  @impl GenServer
  def handle_call(:clear, _from, state) do
    {:reply, :ok, State.new(state.capacity)}
  end
end

defmodule RPNCalculator.Exception do
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    @default_message "stack underflow occurred"
    defexception message: @default_message

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        _ -> %StackUnderflowError{message: @default_message <> ", context: " <> value}
      end
    end
  end

  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([d, n]), do: n / d
  def divide(_), do: raise(StackUnderflowError, "when dividing")
end

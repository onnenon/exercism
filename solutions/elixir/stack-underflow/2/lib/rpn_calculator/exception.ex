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

  def divide(stack) do
    case stack do
      [0, _] -> raise DivisionByZeroError
      [d, n] -> n / d
      _ -> raise StackUnderflowError, "when dividing"
    end
  end
end

defmodule TopSecret do
  def to_ast(string) do
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, [{:when, _, [{name, _, args}, _]}, _]} = ast, acc)
      when op in [:def, :defp] do
    {ast, [Atom.to_string(name) |> String.slice(0, length(args)) | acc]}
  end

  def decode_secret_message_part({op, _, [{_, _, nil} | _]} = ast, acc)
      when op in [:def, :defp] do
    {ast, ["" | acc]}
  end

  def decode_secret_message_part({op, _, [{name, _, args} | _]} = ast, acc)
      when op in [:def, :defp] do
    {ast, [Atom.to_string(name) |> String.slice(0, length(args)) | acc]}
  end

  def decode_secret_message_part(ast, acc), do: {ast, acc}

  def decode_secret_message(string) do
    code = to_ast(string)

    case code do
      {:defmodule, _, [_, [do: {:__block__, _, bodies}]]} ->
        Enum.map(bodies, fn body -> decode_secret_message_part(body, []) end)
        |> Enum.reduce([], fn {_ast, acc}, acc_list -> acc ++ acc_list end)
        |> Enum.reverse()
        |> Enum.join()

      {:defmodule, _, [_, [do: body]]} ->
        decode_secret_message_part(body, []) |> elem(1) |> hd()

      {:__block__, _, bodies_or_modules} ->
        case bodies_or_modules do
          [{:defmodule, _, _} | _] ->
            Enum.map(
              bodies_or_modules,
              fn
                {:defmodule, _, [_, [do: {:__block__, _, bodies}]]} -> bodies
                {:defmodule, _, [_, [do: body]]} -> [body]
              end
            )
            |> List.flatten()
            |> Enum.map(fn body -> decode_secret_message_part(body, []) end)
            |> Enum.reduce([], fn {_ast, acc}, acc_list -> acc ++ acc_list end)
            |> Enum.reverse()
            |> Enum.join()

          _ ->
            Enum.map(bodies_or_modules, fn body -> decode_secret_message_part(body, []) end)
            |> Enum.reduce([], fn {_ast, acc}, acc_list -> acc ++ acc_list end)
            |> Enum.reverse()
            |> Enum.join()
        end
    end
  end
end

defmodule Username do
  @spec sanitize(charlist()) :: charlist()

  def sanitize([]), do: ~c""

  def sanitize([head | tail]) do
    cleaned =
      case head do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        ?_ -> ~c"_"
        h when h >= ?a and h <= ?z -> [h]
        _ -> ~c""
      end

    cleaned ++ sanitize(tail)
  end
end

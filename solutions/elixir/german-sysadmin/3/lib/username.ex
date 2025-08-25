defmodule Username do
  @spec sanitize(charlist()) :: charlist()

  def sanitize([]), do: ~c""

  def sanitize([h | t]) do
    cleaned =
      case h do
        ?ä -> ~c"ae"
        ?ö -> ~c"oe"
        ?ü -> ~c"ue"
        ?ß -> ~c"ss"
        ?_ -> [h]
        x when x < ?a or x > ?z -> ~c""
        _ -> [h]
      end

    cleaned ++ sanitize(t)
  end
end

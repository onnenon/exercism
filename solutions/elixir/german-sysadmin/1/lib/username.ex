defmodule Username do
  @spec sanitize(charlist()) :: charlist()
  def sanitize([h | t]) do
    case h do
    h when h == ?ä -> ~c"ae" ++ sanitize(t)
    h when h == ?ö -> ~c"oe" ++ sanitize(t)
    h when h == ?ü -> ~c"ue" ++ sanitize(t)
    h when h == ?ß -> ~c"ss" ++ sanitize(t)
    h when h == ?_ -> [h] ++ sanitize(t)
    h when h < ?a or h > ?z -> sanitize(t)
    _ -> [h] ++ sanitize(t)
    end
  end

  def sanitize([]), do: ~c""
end

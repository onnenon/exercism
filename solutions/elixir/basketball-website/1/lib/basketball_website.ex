defmodule BasketballWebsite do
  defp get_at_key(nil, _), do: nil
  defp get_at_key(data, [h | []]), do: data[h]
  defp get_at_key(data, [h | t]), do: get_at_key(data[h], t)

  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    get_at_key(data, keys)
  end

  def get_in_path(data, path) do
    keys = String.split(path, ".")
    Kernel.get_in(data, keys)
  end
end

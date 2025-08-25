defmodule BasketballWebsite do
  defp extract_from_path_(nil, _), do: nil
  defp extract_from_path_(data, [h | []]), do: data[h]
  defp extract_from_path_(data, [h | t]), do: extract_from_path_(data[h], t)

  def extract_from_path(data, path) do
    keys = String.split(path, ".")
    extract_from_path_(data, keys)
  end

  def get_in_path(data, path) do
    keys = String.split(path, ".")
    Kernel.get_in(data, keys)
  end
end

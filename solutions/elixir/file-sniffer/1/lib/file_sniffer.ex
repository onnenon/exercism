defmodule FileSniffer do
  def type_from_extension(extension) do
    case extension do
      "exe" -> "application/octet-stream"
      "bmp" -> "image/bmp"
      "png" -> "image/png"
      "jpg" -> "image/jpg"
      "gif" -> "image/gif"
      _ -> nil
    end
  end

  def type_from_binary(<<0x42, 0x4D, _rest::binary>>), do: "image/bmp"
  def type_from_binary(<<0x47, 0x49, 0x46, _rest::binary>>), do: "image/gif"
  def type_from_binary(<<0xFF, 0xD8, 0xFF, _rest::binary>>), do: "image/jpg"

  def type_from_binary(<<0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, _rest::binary>>),
    do: "image/png"

  def type_from_binary(<<0x7F, 0x45, 0x4C, 0x46, _rest::binary>>), do: "application/octet-stream"
  def type_from_binary(_), do: nil

  def verify(file_binary, extension) do
    type_bin = type_from_binary(file_binary)
    type_ext = type_from_extension(extension)

    if type_bin == type_ext and type_bin != nil do
      {:ok, type_bin}
    else
      {:error, "Warning, file format and file extension do not match."}
    end
  end
end

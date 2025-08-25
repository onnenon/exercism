defmodule DNA do
  def encode_nucleotide(code_point) do
    case code_point do
      ?A -> 0b0001
      ?C -> 0b0010
      ?G -> 0b0100
      ?T -> 0b1000
      ?\s -> 0b0000
    end
  end

  def decode_nucleotide(encoded_code) do
    case encoded_code do
      0b0001 -> ?A
      0b0010 -> ?C
      0b0100 -> ?G
      0b1000 -> ?T
      0b0000 -> ?\s
    end
  end

  def encode(dna), do: encode_(dna, <<>>)

  defp encode_([], acc), do: acc
  defp encode_([h | t], acc), do: encode_(t, <<acc::bitstring, encode_nucleotide(h)::4>>)

  def decode(dna), do: decode_(dna, ~c"")

  defp decode_(<<>>, acc), do: acc
  defp decode_(<<h::4, rest::bitstring>>, acc), do: decode_(rest, acc ++ [decode_nucleotide(h)])
end

defmodule ProteinTranslation do
  @codon_to_protein %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }
  @nucleotides ["A", "U", "G", "C"]

  defp do_of_rna([], acc), do: {:ok, acc}
  defp do_of_rna([codon | _], _) when byte_size(codon) != 3, do: {:error, "invalid RNA"}

  defp do_of_rna([codon | rest], acc) do
    if not valid_nucleotides?(codon) do
      {:error, "invalid RNA"}
    else
      case of_codon(codon) do
        {:ok, "STOP"} -> {:ok, acc}
        {:error, _} = e -> e
        {:ok, c} -> do_of_rna(rest, acc ++ [c])
      end
    end
  end

  defp valid_nucleotides?(codon), do: String.graphemes(codon) |> Enum.all?(&(&1 in @nucleotides))

  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @spec of_rna(String.t()) :: {:ok, list(String.t())} | {:error, String.t()}
  def of_rna(rna) do
    rna |> String.graphemes() |> Enum.chunk_every(3) |> Enum.map(&Enum.join/1) |> do_of_rna([])
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def of_codon(codon) do
    case Map.fetch(@codon_to_protein, codon) do
      {:ok, _} = p -> p
      :error -> {:error, "invalid codon"}
    end
  end
end

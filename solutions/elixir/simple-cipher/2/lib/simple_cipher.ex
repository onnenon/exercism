defmodule SimpleCipher do
  @doc """
  Given a `plaintext` and `key`, encode each character of the `plaintext` by
  shifting it by the corresponding letter in the alphabet shifted by the number
  of letters represented by the `key` character, repeating the `key` if it is
  shorter than the `plaintext`.

  For example, for the letter 'd', the alphabet is rotated to become:

  defghijklmnopqrstuvwxyzabc

  You would encode the `plaintext` by taking the current letter and mapping it
  to the letter in the same position in this rotated alphabet.

  abcdefghijklmnopqrstuvwxyz
  defghijklmnopqrstuvwxyzabc

  "a" becomes "d", "t" becomes "w", etc...

  Each letter in the `plaintext` will be encoded with the alphabet of the `key`
  character in the same position. If the `key` is shorter than the `plaintext`,
  repeat the `key`.

  Example:

  plaintext = "testing"
  key = "abc"

  The key should repeat to become the same length as the text, becoming
  "abcabca". If the key is longer than the text, only use as many letters of it
  as are necessary.
  """
  def encode(plaintext, key) do
    key = repeat_key(key, String.length(plaintext)) |> String.to_charlist()

    plaintext
    |> String.to_charlist()
    |> Enum.zip_with(key, &encode_char/2)
    |> Enum.map(&<<&1>>)
    |> Enum.join()
  end

  @doc """
  Given a `ciphertext` and `key`, decode each character of the `ciphertext` by
  finding the corresponding letter in the alphabet shifted by the number of
  letters represented by the `key` character, repeating the `key` if it is
  shorter than the `ciphertext`.

  The same rules for key length and shifted alphabets apply as in `encode/2`,
  but you will go the opposite way, so "d" becomes "a", "w" becomes "t",
  etc..., depending on how much you shift the alphabet.
  """
  def decode(ciphertext, key) do
    make_stream(ciphertext, key)
    |> Enum.map(&decode_char/2)
    |> Enum.map(&<<&1>>)
    |> Enum.join()

    # ciphertext
    # |> String.to_charlist()
    # |> Enum.zip_with(key, &decode_char/2)
    # |> Enum.map(&<<&1>>)
    # |> Enum.join()
  end

  @doc """
  Generate a random key of a given length. It should contain lowercase letters only.
  """
  def generate_key(length) do
    for _ <- 1..length, into: "", do: <<Enum.random(?a..?z)>>
  end

  defp make_stream(text, key) do
    key_stream = key |> String.graphemes() |> Stream.cycle()

    text
    |> String.graphemes()
    |> Stream.zip()
  end

  defp repeat_key(key, length) do
    key
    |> String.duplicate(div(length, String.length(key)) + 1)
    |> String.slice(0, length)
  end

  defp encode_char(plain, key) do
    offset = key - ?a
    ?a + Integer.mod(plain - ?a + offset, 26)
  end

  defp decode_char(cipher, key) do
    offset = key - ?a
    ?a + Integer.mod(cipher - ?a - offset, 26)
  end
end

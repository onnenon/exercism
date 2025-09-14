let normalize x =
  x |> String.lowercase_ascii |> String.to_seq |> List.of_seq
  |> List.sort Char.compare |> List.to_seq |> String.of_seq

let is_anagram t c =
  let is_identitcal = String.lowercase_ascii t = String.lowercase_ascii c in
  let is_anagram = normalize t = normalize c in
  is_anagram && not is_identitcal

let anagrams target candidates = candidates |> List.filter (is_anagram target)

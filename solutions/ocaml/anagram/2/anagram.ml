let normalize x =
  x
  |> String.lowercase_ascii
  |> String.to_seq
  |> List.of_seq
  |> List.sort Char.compare
  |> List.to_seq
  |> String.of_seq
;;

let anagrams target candidates =
  let normalized_target = normalize target in
  let target_lower = String.lowercase_ascii target in
  let target_len = String.length target in
  let is_anagram candidate =
    if String.length candidate <> target_len
    then false
    else (
      let cand_lower = String.lowercase_ascii candidate in
      cand_lower <> target_lower && normalized_target = normalize candidate)
  in
  List.filter is_anagram candidates
;;

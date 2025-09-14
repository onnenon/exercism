let normalize x =
  x |> String.lowercase_ascii |> String.to_seq |> List.of_seq |> List.sort Char.compare
;;

let anagrams target =
  let target_lower = String.lowercase_ascii target in
  let normalized_target = normalize target in
  let is_anagram c =
    let cand_lower = String.lowercase_ascii c in
    cand_lower <> target_lower && normalized_target = normalize c
  in
  List.filter is_anagram
;;

let is_pangram phrase = 
  let chars_a_to_z = List.init 26 (fun i -> Char.chr(Char.code 'a' + i)) in
    let phrase_chars = phrase |> String.lowercase_ascii |> String.to_seq |> List.of_seq in
  chars_a_to_z |> List.for_all (fun c -> List.mem c phrase_chars)


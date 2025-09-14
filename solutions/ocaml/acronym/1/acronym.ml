let acronym phrase =
  phrase
  |> String.map (function
    | '-' | '_' -> ' '
    | c -> c)
  |> String.split_on_char ' '
  |> List.filter (fun s -> String.trim s <> "")
  |> List.map (fun s -> String.make 1 @@ Char.uppercase_ascii @@ String.get s 0)
  |> String.concat ""
;;

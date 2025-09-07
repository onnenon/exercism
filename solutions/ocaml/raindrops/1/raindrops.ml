let raindrop n =
  let sounds =
    [ (3, "Pling"); (5, "Plang"); (7, "Plong") ]
    |> List.filter_map (fun (factor, sound) ->
           if n mod factor = 0 then Some sound else None)
    |> String.concat ""
  in
  if sounds = "" then string_of_int n else sounds

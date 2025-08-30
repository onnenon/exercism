type nucleotide = A | C | G | T

let hamming_distance strand1 strand2 =
  if List.length strand1 <> List.length strand2 then
    Error "strands must be of equal length"
  else
    Ok
      (List.fold_left2
         (fun acc a b -> acc + if a = b then 0 else 1)
         0 strand1 strand2)

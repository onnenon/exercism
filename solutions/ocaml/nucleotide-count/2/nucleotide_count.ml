open Base

let empty = Map.empty (module Char)

let valid_nucleotide = function
  | 'A' | 'C' | 'G' | 'T' -> true
  | _ -> false

let count_nucleotide s c =
    if not (valid_nucleotide c) then Error c
  else
    String.to_list s
    |> List.fold_until
         ~init:0
         ~f:(fun acc ch ->
           if not (valid_nucleotide ch) then Stop (Error ch)
           else Continue (acc + if Char.equal ch c then 1 else 0)
         )
         ~finish:(fun acc -> Ok acc)

let count_nucleotides s =
    String.to_list s
  |> List.fold_until
       ~init:empty
       ~f:(fun acc c ->
         if valid_nucleotide c then
           Continue (Map.update acc c ~f:(function None -> 1 | Some n -> n + 1))
         else
           Stop (Error c)
       )
       ~finish:(fun acc -> Ok acc)

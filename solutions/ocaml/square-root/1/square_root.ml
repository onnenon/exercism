let square_root n =
  let rec aux x =
    match x with
    | x when x * x = n -> x
    | x when x = n -> failwith "can't happen with this exercise"
    | x -> aux (x + 1)
  in
  aux 1

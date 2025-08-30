let square_of_sum n =
  let sum = List.init n (fun x -> x + 1) |> List.fold_left ( + ) 0 in
  sum * sum

let sum_of_squares n =
  List.init n (fun x -> x + 1) |> List.fold_left (fun acc a -> acc + (a * a)) 0

let difference_of_squares n = square_of_sum n - sum_of_squares n

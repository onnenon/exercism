let score (x : float) (y : float) : int =
  let distance = sqrt ((x ** 2.) +. (y ** 2.)) in
  match distance with
  | x when x <= 1.0 -> 10
  | x when x <= 5.0 -> 5
  | x when x <= 10.0 -> 1
  | _ -> 0

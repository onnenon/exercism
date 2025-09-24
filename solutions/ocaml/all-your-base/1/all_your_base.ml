type base = int

let convert_bases ~from ~digits ~target =
  let to_base_ten = List.fold_left (fun acc d -> (acc * from) + d) 0 in
  let to_target_base target = function
    | 0 -> [ 0 ]
    | n ->
        let rec to_digits n acc =
          if n = 0 then acc else to_digits (n / target) ((n mod target) :: acc)
        in
        to_digits n []
  in
  if from < 2 || target < 2 || List.exists (fun x -> x < 0 || x >= from) digits
  then None
  else Some (digits |> to_base_ten |> to_target_base target)

type allergen =
  | Eggs
  | Peanuts
  | Shellfish
  | Strawberries
  | Tomatoes
  | Chocolate
  | Pollen
  | Cats

let allergen_values =
  [ Eggs, 0
  ; Peanuts, 1
  ; Shellfish, 2
  ; Strawberries, 3
  ; Tomatoes, 4
  ; Chocolate, 5
  ; Pollen, 6
  ; Cats, 7
  ]
;;

let is_bit_set n position = n land (1 lsl position) <> 0
let allergic_to score a = is_bit_set score (List.assoc a allergen_values)

let allergies score =
  allergen_values
  |> List.filter (fun (_, n) -> is_bit_set score n)
  |> List.map (fun (a, _) -> a)
;;

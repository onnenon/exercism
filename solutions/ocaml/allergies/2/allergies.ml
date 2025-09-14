type allergen =
  | Eggs
  | Peanuts
  | Shellfish
  | Strawberries
  | Tomatoes
  | Chocolate
  | Pollen
  | Cats

let all_allergens =
  [ Eggs; Peanuts; Shellfish; Strawberries; Tomatoes; Chocolate; Pollen; Cats ]

let allergen_to_bit = function
  | Eggs -> 0
  | Peanuts -> 1
  | Shellfish -> 2
  | Strawberries -> 3
  | Tomatoes -> 4
  | Chocolate -> 5
  | Pollen -> 6
  | Cats -> 7

let allergic_to score allergen =
  score land (1 lsl allergen_to_bit allergen) <> 0

let allergies score = List.filter (allergic_to score) all_allergens

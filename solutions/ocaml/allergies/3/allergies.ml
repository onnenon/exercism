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
  | Eggs -> 1
  | Peanuts -> 2
  | Shellfish -> 4
  | Strawberries -> 8
  | Tomatoes -> 16
  | Chocolate -> 32
  | Pollen -> 64
  | Cats -> 128

let allergic_to score allergen = allergen_to_bit allergen land score <> 0
let allergies score = List.filter (allergic_to score) all_allergens

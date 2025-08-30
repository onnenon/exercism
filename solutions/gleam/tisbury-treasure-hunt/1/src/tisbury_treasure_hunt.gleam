import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  #(place_location.1, place_location.0)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  list.count(treasures, fn(t) {
    place_location_to_treasure_location(place.1) == t.1
  })
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  case found_treasure, place, desired_treasure {
    #("Brass Spyglass", _), #("Abandoned Lighthouse", _), _ -> True
    #("Amethyst Octopus", _), #("Stormy Breakwater", _), #(n, _)
      if n == "Crystal Crab" || n == "Glass Starfish"
    -> True
    #("Vintage Pirate Hat", _), #("Harbor Managers Office", _), #(n, _)
      if n == "Model Ship in Large Bottle" || n == "Antique Glass Fishnet Float"
    -> True
    _, _, _ -> False
  }
}

open Base

let transform data =
  List.concat_map data ~f:(fun (points, chars) ->
      List.map chars ~f:(fun char -> (Char.lowercase char, points)))
  |> List.sort ~compare:Poly.compare

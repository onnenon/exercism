open Base

let transform data =
  List.concat_map data ~f:(fun (p, chars) ->
      List.map chars ~f:(fun c -> (Char.lowercase c, p)))
  |> List.sort ~compare:Poly.compare

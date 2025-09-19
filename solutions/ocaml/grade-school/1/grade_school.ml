open Base
module Int_map = Map.M (Int)

type school = string list Int_map.t

let empty_school = Map.empty (module Int)

let add student grade school =
  Map.update school grade ~f:(function
    | Some students -> student :: students |> List.sort ~compare:String.compare
    | None -> [ student ])

let grade g school = Map.find_multi school g
let sorted s = s

let roster school =
  Map.fold school ~init:[] ~f:(fun ~key:_ ~data:students acc -> acc @ students)

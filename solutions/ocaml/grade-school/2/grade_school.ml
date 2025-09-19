open Base
module Int_map = Map.M (Int)

type school = string list Int_map.t

let empty_school = Map.empty (module Int)

let add student grade school =
  Map.update school grade ~f:(function
    | Some students -> student :: students |> List.sort ~compare:String.compare
    | None -> [ student ])

let grade g school = Map.find_multi school g
let sorted school = Map.map school ~f:(List.sort ~compare:String.compare)

let roster school =
  Map.to_sequence school
  |> Sequence.concat_map ~f:(fun (_, students) -> Sequence.of_list students)
  |> Sequence.to_list

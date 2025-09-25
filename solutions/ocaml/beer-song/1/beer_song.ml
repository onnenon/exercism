let recite_verse number =
  match number with
  | 0 ->
      "No more bottles of beer on the wall, no more bottles of beer.\n\
       Go to the store and buy some more, 99 bottles of beer on the wall."
  | 1 ->
      "1 bottle of beer on the wall, 1 bottle of beer.\n\
       Take it down and pass it around, no more bottles of beer on the wall."
  | 2 ->
      "2 bottles of beer on the wall, 2 bottles of beer.\n\
       Take one down and pass it around, 1 bottle of beer on the wall."
  | n ->
      Printf.sprintf
        "%d bottles of beer on the wall, %d bottles of beer.\n\
         Take one down and pass it around, %d bottles of beer on the wall."
        n n (n - 1)

let recite from until =
  List.init until (fun i -> from - i)
  |> List.map recite_verse |> String.concat "\n\n"

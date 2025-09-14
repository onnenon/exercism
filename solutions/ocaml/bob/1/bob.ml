let is_letter c = match c with 'a' .. 'z' | 'A' .. 'Z' -> true | _ -> false
let is_uppercase c = match c with 'A' .. 'Z' -> true | _ -> false

let is_question s =
  let trimmed = String.trim s in
  String.length trimmed > 0 && trimmed.[String.length trimmed - 1] = '?'

let is_yelling s =
  let letters =
    s |> String.trim |> String.to_seq |> List.of_seq |> List.filter is_letter
  in
  letters <> [] && List.for_all is_uppercase letters

let is_silence s = String.trim s = ""

let response_for s =
  match s with
  | s when is_silence s -> "Fine. Be that way!"
  | s when is_question s && is_yelling s -> "Calm down, I know what I'm doing!"
  | s when is_question s -> "Sure."
  | s when is_yelling s -> "Whoa, chill out!"
  | _ -> "Whatever."

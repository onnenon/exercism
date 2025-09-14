open Base

let has_letters s = String.exists ~f:Char.is_alpha s
let is_yelling s = String.(uppercase s = s) && has_letters s
let is_question s = String.is_suffix ~suffix:"?" s
let is_silence s = String.is_empty s

let response_for input =
  let s = input |> String.strip in
  if is_silence s then "Fine. Be that way!"
  else if is_question s && is_yelling s then "Calm down, I know what I'm doing!"
  else if is_question s then "Sure."
  else if is_yelling s then "Whoa, chill out!"
  else "Whatever."

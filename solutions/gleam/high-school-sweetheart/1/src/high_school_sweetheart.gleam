import gleam/list
import gleam/result
import gleam/string

pub fn first_letter(name: String) {
  name |> string.trim() |> string.first() |> result.unwrap("")
}

pub fn initial(name: String) {
  name |> first_letter() |> string.uppercase() |> string.append(".")
}

pub fn initials(full_name: String) {
  full_name
  |> string.split(" ")
  |> list.map(fn(s) { initial(s) })
  |> string.join(" ")
}

pub fn pair(full_name1: String, full_name2: String) {
  let name1 = initials(full_name1)
  let name2 = initials(full_name2)
  let name_line = "**     " <> name1 <> "  +  " <> name2 <> "     **\n"
  let top =
    "\n     ******       ******\n   **      **   **      **\n **         ** **         **\n**            *            **\n**                         **\n"
  let bottom =
    " **                       **\n   **                   **\n     **               **\n       **           **\n         **       **\n           **   **\n             ***\n              *\n"
  top <> name_line <> bottom
}

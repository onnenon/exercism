import gleam/string

pub fn message(log_line: String) -> String {
  case string.split(log_line, "]: ") {
    [_, msg] -> string.trim(msg)
    _ -> ""
  }
}

pub fn log_level(log_line: String) -> String {
  case string.split(log_line, "]: ") {
    [level, _] -> level |> string.drop_start(1) |> string.lowercase()
    _ -> ""
  }
}

pub fn reformat(log_line: String) -> String {
  let level = log_level(log_line)
  let msg = message(log_line)
  msg <> " (" <> level <> ")"
}

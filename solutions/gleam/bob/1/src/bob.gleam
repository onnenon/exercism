import gleam/regexp
import gleam/string

fn has_letters(remark: String) -> Bool {
  let assert Ok(re) = regexp.from_string("[a-zA-Z]")
  regexp.check(re, remark)
}

fn is_question(remark: String) -> Bool {
  string.ends_with(remark, "?")
}

fn is_yelling(remark: String) -> Bool {
  has_letters(remark) && string.uppercase(remark) == remark
}

fn is_silence(remark: String) -> Bool {
  string.is_empty(remark)
}

pub fn hey(remark: String) -> String {
  let trimmed = string.trim(remark)
  case is_silence(trimmed), is_yelling(trimmed), is_question(trimmed) {
    True, _, _ -> "Fine. Be that way!"
    False, True, True -> "Calm down, I know what I'm doing!"
    False, True, False -> "Whoa, chill out!"
    False, False, True -> "Sure."
    _, _, _ -> "Whatever."
  }
}

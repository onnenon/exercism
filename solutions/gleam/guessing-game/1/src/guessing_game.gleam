pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    g if g < 41 -> "Too low"
    g if g > 43 -> "Too high"
    _ -> "So close"
  }
}

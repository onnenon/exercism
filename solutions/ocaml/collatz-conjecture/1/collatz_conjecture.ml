let rec collatz_conjecture = function
  | n when n <= 0 -> Error "Only positive integers are allowed"
  | 1 -> Ok 0
  | n when n mod 2 = 0 -> Result.map succ (collatz_conjecture (n / 2))
  | n -> Result.map succ (collatz_conjecture ((3 * n) + 1))

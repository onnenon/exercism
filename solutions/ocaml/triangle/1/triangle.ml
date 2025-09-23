let passes_inequality a b c = a + b > c && a + c > b && b + c > a

let is_equilateral a b c =
  if (a = b && b = c) && passes_inequality a b c then true else false

let is_isosceles a b c =
  if (a = b || b = c || a = c) && passes_inequality a b c then true else false

let is_scalene a b c =
  if (a != b && b != c && a != c) && passes_inequality a b c then true
  else false

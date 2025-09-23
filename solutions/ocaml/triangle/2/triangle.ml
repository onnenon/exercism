let passes_inequality a b c = a + b > c && a + c > b && b + c > a
let is_equilateral a b c = a = b && b = c && passes_inequality a b c
let is_isosceles a b c = (a = b || b = c || a = c) && passes_inequality a b c
let is_scalene a b c = a <> b && b <> c && a <> c && passes_inequality a b c

let primes n =
  if n < 2 then []
  else
    let candidates = List.init (n - 1) (fun i -> i + 2) in
    let rec sieve remaining primes =
      match remaining with
      | [] -> List.rev primes
      | p :: rest ->
          let filtered = List.filter (fun x -> x = p || x mod p <> 0) rest in
          sieve filtered (p :: primes)
    in
    sieve candidates []
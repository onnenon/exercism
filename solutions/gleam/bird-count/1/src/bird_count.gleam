import gleam/list

pub fn today(days: List(Int)) -> Int {
  case days {
    [n, ..] -> n
    _ -> 0
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [n, ..rest] -> [n + 1, ..rest]
    _ -> [1]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  list.contains(days, 0)
}

pub fn total(days: List(Int)) -> Int {
  case days {
    [a, b, ..rest] -> total([a + b, ..rest])
    [n] -> n
    [] -> 0
  }
}

pub fn busy_days(days: List(Int)) -> Int {
  list.fold(days, 0, fn(acc, d) {
    case d {
      d_ if d_ >= 5 -> acc + 1
      _ -> acc
    }
  })
}

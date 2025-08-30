import gleam/list

pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_price_(pizza, 0)
}

fn pizza_price_(pizza: Pizza, price: Int) -> Int {
  case pizza {
    Margherita -> 7 + price
    Caprese -> 9 + price
    Formaggio -> 10 + price
    ExtraSauce(p) -> pizza_price_(p, price + 1)
    ExtraToppings(p) -> pizza_price_(p, price + 2)
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  let length = list.length(order)
  case order {
    [] -> 0
    p if length == 1 -> order_price_(p, 3)
    p if length == 2 -> order_price_(p, 2)
    p -> order_price_(p, 0)
  }
}

fn order_price_(order: List(Pizza), price: Int) -> Int {
  case order {
    [p, ..rest] -> order_price_(rest, price + pizza_price(p))
    _ -> price
  }
}

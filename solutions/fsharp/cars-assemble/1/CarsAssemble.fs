module CarsAssemble

let baseCarsPerHour: int = 221

let successRate (speed: int) : float =
    match speed with
    | 10 -> 0.77
    | 9 -> 0.80
    | s when s > 4 -> 0.9
    | s when s > 0 -> 1.0
    | _ -> 0.0

let productionRatePerHour (speed: int) : float =
    float (baseCarsPerHour * speed) * successRate speed

let workingItemsPerMinute (speed: int) : int =
    int (productionRatePerHour speed / 60.0)

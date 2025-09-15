module LuciansLusciousLasagna

let expectedMinutesInOven = 40
let remainingMinutesInOven = (-) expectedMinutesInOven
let preparationTimeInMinutes = (*) 2

let elapsedTimeInMinutes layers minutes =
    minutes + preparationTimeInMinutes layers

module LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)


expectedMinutesInOven : number
expectedMinutesInOven =
    40


preparationTimeInMinutes : number -> number
preparationTimeInMinutes =
    (*) 2


elapsedTimeInMinutes : number -> number -> number
elapsedTimeInMinutes layers minutesInOven =
    preparationTimeInMinutes layers + minutesInOven

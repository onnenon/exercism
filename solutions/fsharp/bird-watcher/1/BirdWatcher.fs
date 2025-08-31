module BirdWatcher

let lastWeek: int[] = [| 0; 2; 5; 3; 7; 8; 4 |]

let yesterday (counts: int[]) : int = counts.[counts.Length - 2]

let total (counts: int[]) : int = Array.sum counts

let dayWithoutBirds = Array.contains 0

let incrementTodaysCount (counts: int[]) : int[] =
    counts |> Array.mapi (fun i x -> if i = counts.Length - 1 then x + 1 else x)

let private selectDaysByIndex pred (counts: int[]) =
    counts |> Array.indexed |> Array.filter (fun (i, _) -> pred i) |> Array.map snd

let private oddIndexDays = selectDaysByIndex (fun i -> i % 2 = 0)
let private evenIndexDays = selectDaysByIndex (fun i -> i % 2 = 1)

let private weekWithEvenZeros (counts: int[]) : bool =
    counts |> evenIndexDays |> Array.forall ((=) 0)

let private weekWithEvenTens (counts: int[]) : bool =
    counts |> evenIndexDays |> Array.forall ((=) 10)

let private weekWithOddFives (counts: int[]) : bool =
    counts |> oddIndexDays |> Array.forall ((=) 5)

let unusualWeek (counts: int[]) : bool =
    weekWithOddFives (counts)
    || weekWithEvenZeros (counts)
    || weekWithEvenTens (counts)

module BirdWatcher

let lastWeek: int[] = [| 0; 2; 5; 3; 7; 8; 4 |]

let yesterday (counts: int[]) : int = counts.[counts.Length - 2]

let total (counts: int[]) : int = Array.sum counts

let dayWithoutBirds = Array.contains 0

let incrementTodaysCount (counts: int[]) : int[] =
    counts |> Array.mapi (fun i x -> if i = counts.Length - 1 then x + 1 else x)

let unusualWeek (counts: int[]) : bool =
    match counts with
    | [| _; 0; _; 0; _; 0; _ |] -> true
    | [| _; 10; _; 10; _; 10; _ |] -> true
    | [| 5; _; 5; _; 5; _; 5 |] -> true
    | _ -> false

(ns bird-watcher)

(def last-week 
  [0 2 5 3 7 8 4]
  )

(defn today [birds]
  (last birds)
  )

(defn inc-bird [birds]
  (assoc birds 6 (inc (last birds)))
  )

(defn day-without-birds? [birds]
  (true? (some zero? birds)))

(defn n-days-count [birds n]
  (->> 
    (take n birds)
    (reduce +))
  )

(defn busy-days [birds]
  (->> birds
    (remove #(< % 5))
    count))


(defn odd-week? [birds]
  (= birds [1 0 1 0 1 0 1])
  )
